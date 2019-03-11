package ssen.component.list
{
	import ssen.component.buttons.ButtonType;
	import ssen.component.interaction.ButtonInteraction;
	import ssen.core.convert.GraphicsConverter;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.IconCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.display.skin.SkinLabel;
	import ssen.core.events.OnOffEvent;
	import ssen.core.events.SSenEvent;
	import ssen.core.events.ValueEvent;
	import ssen.core.geom.Padding;
	import ssen.core.text.FontRender;
	import ssen.core.text.IFontRenderObject;
	import ssen.core.text.TextStyle;
	import ssen.data.selectGroup.ISelectItem;
	
	import flash.display.PixelSnapping;
	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class LabelListItem extends SSenSprite implements IListItem, IFontRenderObject
	{
		/* *********************************************************************
		 * model
		 ********************************************************************* */
		private var _data : ISelectItem;
		/* *********************************************************************
		 * art
		 ********************************************************************* */
		private var _label : SkinLabel;
		private var _bg : ISkinDisplayObject;
		private var _padding : Padding;
		private var _width : Number;
		private var _height : Number;
		private var _thumbnails : IconCollection;
		/* *********************************************************************
		 * interaction
		 ********************************************************************* */
		private var _interaction : ButtonInteraction;
		private var _enabled : Boolean;
		private var _dataBlock : Boolean;
		private var _interactionBlock : Boolean;

		/**
		 * Constructor
		 * @param bg background skin object [default, over, action, selected, disable]
		 * @param width component width
		 * @param height component height
		 * @param padding labelSize = bgSize - padding
		 * @param textColors label text colors [default, over, action, selected, disable]
		 * @param thumbnail label thumbnail
		 * @param fontRender label fontRender
		 */
		public function LabelListItem(bg : ISkinDisplayObject, 
										width : Number, 
										height : Number, 
										padding : Padding,
										textColors : Dictionary, 
										textStyle : TextStyle,
										enabled : Boolean,
										thumbnails : IconCollection = null, 
										fontRender : FontRender = null,
										data : ISelectItem = null
										)
		{
			_thumbnails = thumbnails;
			_enabled = enabled;
			initializeArt(bg, width, height, padding, textColors, textStyle, fontRender);
			
			if (data != null) {
				initialize(data);
			} else {
				if (_enabled) {
					skinDraw(SkinFlag.DEFAULT);
				} else {
					skinDraw(SkinFlag.DISABLE);
				}
			}
		}
		private function initializeArt(bg : ISkinDisplayObject, 
										width : Number, 
										height : Number, 
										padding : Padding,
										textColors : Dictionary, 
										textStyle : TextStyle, 
										fontRender : FontRender = null) : void
		{
			// set display
			var textStyles : Dictionary = GraphicsConverter.textStyleToTextStyles(textStyle, textColors);
			_label = new SkinLabel("dataless...", textStyles, null, true, fontRender);
			_bg = bg;
			_padding = padding;
			_width = width;
			_height = height;
			
			// add child, initialize align, event
			addChildren(_bg, _label);
			align();
		}
		private function initialize(data : ISelectItem) : void
		{
			_data = data;
			_interaction = new ButtonInteraction(this, ButtonType.TOGGLE);
			_interaction.start();
			eventOn();
			dataBinding();
		}
		/* *********************************************************************
		 * art interface
		 ********************************************************************* */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			align();
		}
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			align();
		}
		public function get label() : SkinLabel
		{
			return _label;
		}
		public function get bg() : ISkinDisplayObject
		{
			return _bg;
		}
		public function get skinMode() : String
		{
			return _interaction.skinMode;
		}
		/* *********************************************************************
		 * implement ILabelListItem
		 ********************************************************************* */
		public function get data() : ISelectItem
		{
			return _data;
		}
		public function set data(data : ISelectItem) : void
		{
			if (_data == null) {
				initialize(data);
			} else {
				_data.removeEventListener(ValueEvent.VALUE_CHANGED, valueChanged);
				_data = data;
				dataBinding();
				_data.addEventListener(ValueEvent.VALUE_CHANGED, valueChanged, false, 0, true);
			}
		}
		public function get prevItem() : IListItem
		{
			if (parent != null && parent is AbstListItems) {
				return AbstListItems(parent).prevItem(this);
			}
			return null;
		}
		public function get nextItem() : IListItem
		{
			if (parent != null && parent is AbstListItems) {
				return AbstListItems(parent).nextItem(this);
			}
			return null;
		}
		/* *********************************************************************
		 * implement IComponent
		 ********************************************************************* */
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		public function set enabled(enabled : Boolean) : void
		{
			if (_enabled != enabled) {
				if (enabled) {
					_interaction.start();
				} else {
					_interaction.stop();
				}
				_enabled = enabled;
				skinningHandle();
			}
		}
		public function get minHeight() : Number
		{
			return _label.height + _padding.top + _padding.bottom;
		}
		public function get minWidth() : Number
		{
			return 0;
		}
		public function get maxHeight() : Number
		{
			return 0;
		}
		public function get maxWidth() : Number
		{
			return 0;
		}
		public function resourceKill() : void
		{
			eventOff();
			_label.setFontRender(null);
			_interaction.resourceKill();
			_label = null;
			_bg = null;
			_data = null;
		}
		public function componentResourceKill() : void
		{
			resourceKill();
		}
		/* *********************************************************************
		 * implement IFontRenderObject
		 ********************************************************************* */
		public function setFontRenderingStyle(embedFonts : Boolean = false, sharpness : Number = 0, thickness : Number = 0) : void
		{
			_label.setFontRenderingStyle(embedFonts, sharpness, thickness);
		}
		public function setFontRender(fontRender : FontRender = null) : void
		{
			_label.setFontRender(fontRender);
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function dataBinding() : void
		{
			_label.text = _data.labelText;
			if (_enabled) _interaction.toggleOn = _data.selected;
			setThumbnail(_data.thumbnail);
		}
		private function align() : void
		{
			if (minHeight > _height) _height = minHeight;
			var w : Number = _width;
			var h : Number = _height;
			
			_bg.width = w;
			_bg.height = h;
			
			_label.x = _padding.left;
			_label.y = _padding.top + (_bg.height >> 1) - (_label.height >> 1);
			_label.width = w - _padding.left - _padding.right;
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function eventOn() : void
		{
			_data.addEventListener(ValueEvent.VALUE_CHANGED, valueChanged, false, 0, true);
			_interaction.addEventListener(SSenEvent.SKINNING, skinningHandle, false, 0, true);
			addEventListener(OnOffEvent.ONOFF, onoff, false, 0, true);
		}
		private function eventOff() : void
		{
			_data.removeEventListener(ValueEvent.VALUE_CHANGED, valueChanged);
			_interaction.removeEventListener(SSenEvent.SKINNING, skinningHandle);
			removeEventListener(OnOffEvent.ONOFF, onoff);
		}
		private function onoff(event : OnOffEvent) : void
		{
			if (!_interactionBlock) {
				_dataBlock = true;
				if (event.onoff) {
					_data.group.selectItem(_data);
				} else {
					_data.group.deselectItem(_data);
				}
				_dataBlock = false;
			}
		}
		private function valueChanged(event : ValueEvent) : void
		{
			_interactionBlock = true;
			switch (event.valueName) {
				case "labelText" : 
					_label.text = _data.labelText;
					break;
				case "selected" : 
					if (!_dataBlock) _interaction.toggleOn = _data.selected;
					break;
				case "thumbnail" :
					setThumbnail(_data.thumbnail);
					break;
			}
			_interactionBlock = false;
		}
		private function setThumbnail(name : String) : void
		{
			if (_thumbnails != null && _thumbnails.hasThumbnail(name)) {
				_label.setThumbnail(_thumbnails.getThumbnail(name, PixelSnapping.AUTO, true));
			}
		}
		private function skinningHandle(event : SSenEvent = null) : void
		{
			skinDraw(_interaction.skinMode);
		}
		/* *********************************************************************
		 * implement ISkinObject
		 ********************************************************************* */
		public function get skinFlag() : String
		{
			return _label.skinFlag;
		}
		public function get skinFlagList() : Vector.<String>
		{
			return _label.skinFlagList;
		}
		public function skinDraw(flag : String) : void
		{
			_label.skinDraw(flag);
			_bg.skinDraw(flag);
			
			if (flag == SkinFlag.OVER) {
				if (!_label.roll) _label.rollStart(flag);
			} else {
				if (_label.roll) _label.rollStop(flag);
			}
		}
	}
}
