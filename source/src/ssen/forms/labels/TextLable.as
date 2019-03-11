package ssen.forms.labels 
{
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;
	import ssen.forms.base.ISSenFormData;
	/**
	 * TextLable : skin[default, action, disable, highlight]
	 * @author ssen (i@ssen.name)
	 */
	public class TextLable extends SSenTextField implements ISSenTextLable, ISkinDisplayObject 
	{
		private var _data : TextLableData;
		private var _enabled : Boolean;
		private var _textStyle : TextStyle;
		private var _fontColors : ColorCollection;
		private var _skinFlag : String;
		private var _initialized : Boolean;
		public function get initialized() : Boolean
		{
			return _initialized;
		}
		public function initialize() : void
		{
			_initialized = true;
		}
		protected function getTextStyle() : TextStyle
		{
			return new TextStyle();
		}
		protected function getFontColors() : ColorCollection
		{
			var colors : ColorCollection = new ColorCollection();
			colors.addColor(SkinFlag.DEFAULT, 0x000000);
			colors.addColor(SkinFlag.ACTION, 0x000000);
			colors.addColor(SkinFlag.DISABLE, 0x000000);
			colors.addColor(SkinFlag.HIGHLIGHT, 0x000000);
			return colors;
		}
		public function setting(data : TextLableData = null, width : Number = 150, height : Number = 30, textStyle : TextStyle = null, fontColors : ColorCollection = null) : void
		{
			_data = data;
			this.textStyle = textStyle ? textStyle : getTextStyle();
			this.fontColors = fontColors ? fontColors : getFontColors();
			this.data = data;
			this.width = width;
			this.height = height;
			if (_data) skinDraw(SkinFlag.DEFAULT);
		}
		override public function set text(text : String) : void 
		{
			_data.title = text;
			super.text = text;
		}
		/** 상태별 색상 지정 */
		public function get fontColors() : ColorCollection
		{
			return _fontColors;
		}
		public function set fontColors(fontColors : ColorCollection) : void
		{
			_fontColors = fontColors;
			skinDraw(_skinFlag);
		}
		/** 텍스트 포맷 */
		public function get textStyle() : TextStyle
		{
			return _textStyle;
		}
		public function set textStyle(textStyle : TextStyle) : void
		{
			_textStyle = textStyle;
			setTextFormat(textStyle);
			defaultTextFormat = textStyle;
		}
		/* *********************************************************************
		 * implement ISSenTextLable 
		 ********************************************************************* */
		public function kill() : void
		{
			_data = null;
			text = "";
		}
		public function deconstruction() : void
		{
			kill();
		}
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		public function get data() : ISSenFormData
		{
			return _data;
		}
		public function set enabled(enabled : Boolean) : void
		{
			_enabled = enabled;
		}
		public function set data(data : ISSenFormData) : void
		{
			_data = TextLableData(data);
			text = _data.title;
		}
		/* *********************************************************************
		 * implement ISkinDisplayObject 
		 ********************************************************************* */
		public function skinDraw(flag : String) : void
		{
			if (_skinFlag != flag) {
				_skinFlag = flag;
				textColor = _fontColors.getColor(_skinFlag);
			}
		}
		public function get skinFlag() : String
		{
			return _skinFlag;
		}
		public function setFormSize(width : Number, height : Number) : void
		{
			formWidth = width;
			formHeight = height;
		}
		public function get formWidth() : Number
		{
			return width;
		}
		public function get formHeight() : Number
		{
			return height;
		}
		public function set formWidth(width : Number) : void
		{
			this.width = width;
		}
		public function set formHeight(height : Number) : void
		{
			this.height = height;
		}
	}
}
