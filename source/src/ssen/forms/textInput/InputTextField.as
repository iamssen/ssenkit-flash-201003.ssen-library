package ssen.forms.textInput 
{
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;
	import ssen.forms.base.ISSenFormData;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextFieldType;
	/**
	 * 입력 형태의 TextField
	 * @author SSen
	 */
	public class InputTextField extends SSenTextField implements ISkinDisplayObject, ISSenTextInput
	{
		private var _fontColors : ColorCollection;
		private var _textStyle : TextStyle;
		private var _skinFlag : String;
		private var _enabled : Boolean;
		private var _highlight : Boolean;
		private var _data : TextInputData;
		private var _initialized : Boolean;
		public function initialize() : void
		{
			super.type = TextFieldType.INPUT;
			_initialized = true;
		}
		protected function getTextStyle() : TextStyle
		{
			return new TextStyle();
		}
		protected function getFontColors() : ColorCollection
		{
			var colors : ColorCollection = new ColorCollection();
			colors.addColor(SkinFlag.DEFAULT, 0x616161);
			colors.addColor(SkinFlag.ACTION, 0x464646);
			colors.addColor(SkinFlag.DISABLE, 0xcccccc);
			colors.addColor(SkinFlag.HIGHLIGHT, 0xb62828);
			return colors;
		}
		public function setting(data : TextInputData = null, width : int = 150, height : int = 25, textStyle : TextStyle = null, fontColors : ColorCollection = null) : void
		{
			_enabled = true;
			_skinFlag = SkinFlag.DEFAULT;
			
			this.textStyle = textStyle ? textStyle : getTextStyle();
			this.fontColors = fontColors ? fontColors : getFontColors();
			this.data = data ? data : new TextInputData("");
			this.width = width;
			this.height = height;
			this.inputType = data.type;
			
			text = data.formatedText;
			eventOn();
		}
		/* *********************************************************************
		 * api
		 ********************************************************************* */
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
		/** 입력 제한 형태 */
		public function get inputType() : String
		{
			return _data.type;
		}
		public function set inputType(inputType : String) : void
		{
			_data.type = inputType;
			text = _data.formatedText;
			switch (inputType) {
				case TextInputType.NUMBER :
					restrict = FavoriteRestrict.NUMBER;
					displayAsPassword = false;
					break;
				case TextInputType.ENGLISH :
				case TextInputType.DOMAIN :
				case TextInputType.EMAIL :
					restrict = FavoriteRestrict.ENGLISH;
					displayAsPassword = false;
					break;
				case TextInputType.PASSWORD :
					restrict = FavoriteRestrict.NULL;
					displayAsPassword = true;
				default :
					restrict = FavoriteRestrict.NULL; 
					break;
			}
		}
		/** 활성 상태 */
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		public function set enabled(enabled : Boolean) : void
		{
			if (enabled != _enabled) {
				if (enabled) {
					if (stage.focus == this) {
						skinDraw(SkinFlag.ACTION);
					} else {
						skinDraw(SkinFlag.DEFAULT);
					}
					type = TextFieldType.DYNAMIC;
				} else {
					skinDraw(SkinFlag.DISABLE);
					type = TextFieldType.INPUT;
				}
				mouseEnabled = enabled;
				tabEnabled = enabled;
				_enabled = enabled;
			}
		}
		/** @private */
		override public function get type() : String
		{
			return TextFieldType.INPUT;
		}
		override public function set type(type : String) : void
		{	
		}
		/** 주목 상태 */
		public function get highlight() : Boolean
		{
			return _highlight;
		}
		public function set highlight(highlight : Boolean) : void
		{
			_highlight = highlight;
			skinDraw(SkinFlag.DEFAULT);
		}
		/* *********************************************************************
		 * implement ISkinDisplayObject
		 ********************************************************************* */
		/** @copy ssen.core.display.skin.ISkinDisplayObject#skinDraw() */
		public function skinDraw(flag : String) : void
		{
			if (_highlight && flag == SkinFlag.DEFAULT) flag = SkinFlag.HIGHLIGHT;
			_skinFlag = flag;
			textColor = _fontColors.getColor(_skinFlag);
			trace(textColor.toString(16), _skinFlag);
		}
		/** @copy ssen.core.display.skin.ISkinDisplayObject#skinFlag */
		public function get skinFlag() : String
		{
			return _skinFlag;
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function eventOn() : void
		{
			addEventListener(FocusEvent.FOCUS_IN, focusIn, false, 0, true);
			addEventListener(FocusEvent.FOCUS_OUT, focusOut, false, 0, true);
			addEventListener(Event.CHANGE, change, false, 0, true);
		}
		private function change(event : Event) : void
		{
			_data.text = text;
		}
		private function eventOff() : void
		{
			removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			removeEventListener(Event.CHANGE, change);
		}
		private function focusOut(event : FocusEvent) : void
		{
			text = _data.formatedText;
			skinDraw(SkinFlag.DEFAULT);
		}
		private function focusIn(event : FocusEvent) : void
		{
			text = String(_data.text);
			skinDraw(SkinFlag.ACTION);
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		public function kill() : void
		{
			text = "";
			_data = null;
			eventOff();
		}
		public function deconstruction() : void
		{
		}
		public function get data() : ISSenFormData
		{
			return _data;
		}
		public function get initialized() : Boolean
		{
			return _initialized;
		}
		public function set data(data : ISSenFormData) : void
		{
			_data = TextInputData(data);
			inputType = _data.type;
			text = _data.formatedText;
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
