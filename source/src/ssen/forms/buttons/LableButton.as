package ssen.forms.buttons 
{
	import ssen.core.display.graphics.TextTrash;
	import ssen.core.display.graphics.GraphicsBitmapDraw;
	import ssen.core.display.graphics.Scale;
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.InvalidateStatus;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.geom.HorizontalAlign;
	import ssen.core.geom.Padding;
	import ssen.core.geom.VerticalAlign;
	import ssen.core.text.TextStyle;
	import ssen.forms.base.FormSprite;

	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.TextBaseline;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class LableButton extends FormSprite implements ISSenButton 
	{

		[Embed(source="asset/defaultSkin/default.png")]
		private static var _defaultImage : Class;
		private static var _defaultBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/over.png")]
		private static var _overImage : Class;
		private static var _overBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/action.png")]
		private static var _downImage : Class;
		private static var _downBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/selected.png")]
		private static var _selectedImage : Class;
		private static var _selectedBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/disable.png")]
		private static var _disableImage : Class;
		private static var _disableBitmap : BitmapData;
		private static var _defaultFontColor : ColorCollection;
		private static var _defaultPadding : Padding;
		private static var _defaultTextStyle : TextStyle;
		private var _interaction : ButtonInteraction;
		private var _default : BitmapData;
		private var _over : BitmapData;
		private var _down : BitmapData;
		private var _selected : BitmapData;
		private var _disable : BitmapData;
		private var _scale : GraphicsBitmapDraw;
		private var _text : TextTrash;
		private var _fontColors : ColorCollection;
		private var _status : InvalidateStatus;
		private static var _defaultElementFormat : ElementFormat;
		public function initialize() : void
		{
			_default = getDefaultImage();
			_over = getOverImage();
			_down = getDownImage();
			_selected = getSelectedImage();
			_disable = getDisableImage();
			_scale = getScale();
			_text = new TextTrash(null, getTextPadding(), getElementFormat(), 0x000000, HorizontalAlign.CENTER, VerticalAlign.MIDDLE);
			_fontColors = getFontColor();
			
			_status = new InvalidateStatus();
			_interaction = new ButtonInteraction();
			_interaction.initialize(this);	
			_initialized = true;
		}
		protected function getElementFormat() : ElementFormat
		{
			if (_defaultElementFormat) return _defaultElementFormat;
			var fonts : Array = Font.enumerateFonts(true);
			var font : String;
			if (fonts.indexOf("돋움") > -1) {
				font = "돋움";
			} else if (fonts.indexOf("Dotum") > -1) {
				font = "Dotum";
			} else {
				font = "Arial";
			}
			
			var fd : FontDescription = new FontDescription(font);
			_defaultElementFormat = new ElementFormat(fd, 12);
			_defaultElementFormat.alignmentBaseline = TextBaseline.DESCENT;
			return _defaultElementFormat;
		}
		protected function getScale() : GraphicsBitmapDraw
		{
			return new Scale(0, 0, 0, 0, 5, 6, 4, 5);
		}
		protected function getDefaultImage() : BitmapData
		{
			if (!_defaultBitmap) _defaultBitmap = new _defaultImage().bitmapData;
			return _defaultBitmap;
		}
		protected function getOverImage() : BitmapData
		{
			if (!_overBitmap) _overBitmap = new _overImage().bitmapData;
			return _overBitmap;
		}
		protected function getDownImage() : BitmapData
		{
			if (!_downBitmap) _downBitmap = new _downImage().bitmapData;
			return _downBitmap;
		}
		protected function getSelectedImage() : BitmapData
		{
			if (!_selectedBitmap) _selectedBitmap = new _selectedImage().bitmapData;
			return _selectedBitmap;
		}
		protected function getDisableImage() : BitmapData
		{
			if (!_disableBitmap) _disableBitmap = new _disableImage().bitmapData;
			return _disableBitmap;
		}
		protected function getTextStyle() : TextStyle
		{
			if (!_defaultTextStyle) _defaultTextStyle = new TextStyle();
			return _defaultTextStyle;
		}
		protected function getFontColor() : ColorCollection
		{
			if (!_defaultFontColor) {
				_defaultFontColor = new ColorCollection();
				_defaultFontColor.addColor(SkinFlag.DEFAULT, 0x3f3f3f);
				_defaultFontColor.addColor(SkinFlag.OVER, 0x372404);
				_defaultFontColor.addColor(SkinFlag.ACTION, 0x372404);
				_defaultFontColor.addColor(SkinFlag.SELECTED, 0x22222f);
				_defaultFontColor.addColor(SkinFlag.DISABLE, 0x9d9d9d);
			}
			return _defaultFontColor;
		}
		protected function getTextPadding() : Padding
		{
			if (!_defaultPadding) _defaultPadding = new Padding(2, 4, 3, 4);
			return _defaultPadding;
		}
		public function setting(width : int = 150, height : int = 40, title : String = "button", toggle : Boolean = false, toggleOn : Boolean = false) : void
		{
			_formWidth = width;
			_formHeight = height;
			_text.text = title;
			scaleX = scaleY = 1;
			_interaction.setting(toggle, toggleOn);
			_interaction.start();
			
			buttonSkinDraw();
		}
		public function get title() : String
		{
			return _text.text;
		}
		public function set title(title : String) : void
		{
			_text.text = title;
			_status["title"] = true;
			invalidate();
		}
		override public function set formWidth(width : Number) : void
		{
			_formWidth = width;
			_status["width"] = true;
			invalidate();
		}
		override public function set formHeight(height : Number) : void
		{
			_formHeight = height;
			_status["height"] = true;
			invalidate();
		}
		/* *********************************************************************
		 * implement ISSenButton
		 ********************************************************************* */
		override public function kill() : void
		{
			_interaction.stop();
		}
		override public function deconstruction() : void
		{
			kill();
			super.kill();
			_interaction.deconstruction();
			_interaction = null;
		}
		public function get toggleOn() : Boolean
		{
			return _interaction.toggleOn;
		}
		public function set toggleOn(toggleOn : Boolean) : void
		{
			_interaction.toggleOn = toggleOn;
		}
		public function get toggle() : Boolean
		{
			return _interaction.toggle;
		}
		public function set toggle(toggle : Boolean) : void
		{
			_interaction.toggle = toggle;
		}
		public function get isMousePress() : Boolean
		{
			return _interaction.isMousePress;
		}
		override public function get enabled() : Boolean
		{
			return _interaction.enabled;
		}
		override public function set enabled(enabled : Boolean) : void
		{
			if (enabled) {
				_interaction.start();
			} else {
				_interaction.stop();
			}
		}
		/* *********************************************************************
		 * skinning
		 ********************************************************************* */
		public function buttonSkinDraw() : void
		{
			_status["draw"] = true;
			invalidate();
		}
		/* *********************************************************************
		 * display invalidating
		 ********************************************************************* */
		private function invalidate() : void
		{
			if (stage != null) {
				stage.addEventListener(Event.RENDER, render, false, 0, true);
				stage.addEventListener(Event.ENTER_FRAME, render, false, 0, true);
				stage.invalidate();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
			}
		}
		private function addedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			invalidate();
		}
		private function render(event : Event) : void
		{
			if (stage != null) {
				stage.removeEventListener(Event.RENDER, render);
				stage.removeEventListener(Event.ENTER_FRAME, render);
			}
			if (_status.invalidate) rendering();
		}
		private function rendering() : void
		{
			_text.boxWidth = _formWidth;
			_text.boxHeight = _formHeight;
			if (_scale is Scale) {
				Scale(_scale).width = _formWidth;
				Scale(_scale).height = _formHeight;
			}
			
			switch (_interaction.skinFlag) {
				case SkinFlag.DEFAULT : 
					_text.y = 0;
					_scale.bitmapData = _default; 
					break;
				case SkinFlag.OVER :
					_text.y = 0; 
					_scale.bitmapData = _over; 
					break;
				case SkinFlag.ACTION :
					_text.y = 1; 
					_scale.bitmapData = _down; 
					break;
				case SkinFlag.SELECTED :
					_text.y = 0; 
					_scale.bitmapData = _selected; 
					break;
				case SkinFlag.DISABLE :
					_text.y = 0; 
					_scale.bitmapData = _disable; 
					break;
			}
			_text.textColor = _fontColors.getColor(_interaction.skinFlag);
			
			graphics.clear();
			_scale.draw(graphics);
			_text.draw(graphics);
			_status.clear();
		}
	}
}
