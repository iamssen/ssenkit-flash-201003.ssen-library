package ssen.component.checkBox 
{
	import ssen.component.buttons.ButtonType;
	import ssen.component.interaction.ButtonInteraction;
	import ssen.core.convert.GraphicsConverter;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.display.skin.SkinLabel;
	import ssen.core.events.OnOffEvent;
	import ssen.core.events.SSenEvent;
	import ssen.core.events.ValueEvent;
	import ssen.core.geom.VerticalAlign;
	import ssen.core.text.FontRender;
	import ssen.core.text.IFontRenderObject;
	import ssen.core.text.TextStyle;
	import ssen.core.utils.FormatToString;
	import ssen.data.selectGroup.ISelectItem;

	import flash.display.Sprite;
	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class CheckBoxItem extends SSenSprite implements ICheckBoxItem, IFontRenderObject
	{
		private var _label : SkinLabel;
		private var _data : ISelectItem;
		private var _enabled : Boolean;
		private var _width : Number;
		private var _checkBox : ISkinDisplayObject;
		private var _valign : String;
		private var _autoWidth : Boolean;
		private var _interaction : ButtonInteraction;
		private var _interactionBlock : Boolean;
		private var _dataBlock : Boolean;

		public function CheckBoxItem(checkBox : ISkinDisplayObject, 
										width : int, 
										autoWidth : Boolean,
										textColors : Dictionary, 
										textStyle : TextStyle,
										enabled : Boolean,
										valign : String = "middle",
										fontRender : FontRender = null,
										data : ISelectItem = null)
		{
			_enabled = enabled;
			initializeArt(checkBox, width, autoWidth, textColors, textStyle, valign, fontRender);
			
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
		private function initialize(data : ISelectItem) : void
		{
			_data = data;
			_interaction = new ButtonInteraction(Sprite(_checkBox), ButtonType.TOGGLE);
			_interaction.start();
			eventOn();
			dataBinding();
		}
		private function initializeArt(checkBox : ISkinDisplayObject, width : int, autoWidth : Boolean, textColors : Dictionary, textStyle : TextStyle, valign : String, fontRender : FontRender) : void
		{
			var textStyles : Dictionary = GraphicsConverter.textStyleToTextStyles(textStyle, textColors);
			_checkBox = checkBox;
			_autoWidth = autoWidth;
			_valign = valign;
			_label = new SkinLabel("dataless...", textStyles, null, true, fontRender);
			_width = width;
			
			addChildren(_checkBox, _label);
			align();
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function dataBinding() : void
		{
			_label.text = _data.labelText;
			if (_enabled) _interaction.toggleOn = _data.selected;
			sizeWidth();
		}
		private function sizeWidth() : void
		{
			if (_autoWidth) {
				_label.autoSizeWidth();
			} else {
				_label.width = _width - _checkBox.width - 5;
			}
		}
		private function align() : void
		{
			sizeWidth();
			
			_label.x = _checkBox.width + 5;
			
			switch (_valign) {
				case VerticalAlign.TOP :
					_checkBox.y = 0;
					_label.y = 0;
					break;
				case VerticalAlign.MIDDLE :
					if (_checkBox.height > _label.height) {
						_checkBox.y = 0;
						_label.y = (_checkBox.height >> 1) - (_label.height >> 1);
					} else {
						_checkBox.y = (_label.height >> 1) - (_checkBox.height >> 1);
						_label.y = 0;
					}  
					break;
				case VerticalAlign.BOTTOM :
					if (_checkBox.height > _label.height) {
						_checkBox.y = 0;
						_label.y = _checkBox.height - _label.height;
					} else {
						_checkBox.y = _label.height - _checkBox.height;
						_label.y = 0;
					}
					break;
			}
		}
		/* *********************************************************************
		 * art interface
		 ********************************************************************* */
		override public function get width() : Number
		{
			return (!_autoWidth) ? _width : _label.x + _label.width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			sizeWidth();
		}
		override public function get height() : Number
		{
			return (_checkBox.height > _label.height) ? _checkBox.height : _label.height;
		}
		override public function set height(value : Number) : void
		{
			FormatToString.ssenErrorTrace("height 는 자동으로 결정됩니다.");
		}
		public function get label() : SkinLabel
		{
			return _label;
		}
		public function get checkBox() : ISkinDisplayObject
		{
			return _checkBox;
		}
		public function get skinMode() : String
		{
			return _interaction.skinMode;
		}
		public function get valign() : String
		{
			return _valign;
		}
		public function set valign(valign : String) : void
		{
			_valign = valign;
			align();
		}
		public function get autoWidth() : Boolean
		{
			return _autoWidth;
		}
		public function set autoWidth(autoWidth : Boolean) : void
		{
			_autoWidth = autoWidth;
			sizeWidth();
		}
		/* *********************************************************************
		 * implement IComponent
		 ********************************************************************* */
		public function resourceKill() : void
		{
			eventOff();
			_label.setFontRender(null);
			_interaction.resourceKill();
			_label = null;
			_checkBox = null;
			_data = null;
		}
		public function componentResourceKill() : void
		{
			resourceKill();
		}
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
			return _label.height;
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
			_checkBox.skinDraw(flag);
			_label.skinDraw(flag);
			if (flag == SkinFlag.OVER) {
				if (!_label.roll) _label.rollStart(flag);
			} else {
				if (_label.roll) _label.rollStop(flag);
			}
		}
		/* *********************************************************************
		 * implement ICheckBoxItem
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
		 * event
		 ********************************************************************* */
		private function eventOn() : void
		{
			_data.addEventListener(ValueEvent.VALUE_CHANGED, valueChanged, false, 0, true);
			_interaction.addEventListener(SSenEvent.SKINNING, skinningHandle, false, 0, true);
			_checkBox.addEventListener(OnOffEvent.ONOFF, onoff, false, 0, true);
		}
		private function eventOff() : void
		{
			_data.removeEventListener(ValueEvent.VALUE_CHANGED, valueChanged);
			_interaction.removeEventListener(SSenEvent.SKINNING, skinningHandle);
			_checkBox.removeEventListener(OnOffEvent.ONOFF, onoff);
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
			}
			_interactionBlock = false;
		}
		private function skinningHandle(event : SSenEvent = null) : void
		{
			skinDraw(_interaction.skinMode);
		}
	}
}
