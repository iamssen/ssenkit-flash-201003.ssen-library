package ssen.component.input 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.errors.AbstractMemberError;
	import ssen.core.events.SkinEvent;
	import ssen.core.geom.Padding;
	import ssen.forms.textInput.SingleLineText;
	import ssen.core.text.TextStyle;		
	/**
	 * @author SSen
	 */
	public class AbstInput extends SSenSprite 
	{
		protected var _width : Number;
		protected var _height : Number;
		protected var _bg : ISkinDisplayObject;
		protected var _txt : SingleLineText;
		protected var _padding : Padding;
		protected var _buttons : SSenSprite;

		
		public function AbstInput(width : int, height : int, inputType : String = "all", frontMark : String = "", backMark : String = "")
		{
			_bg = createBackGround();
			_txt = new SingleLineText(createTextStyle(), createFontColors(), inputType, frontMark, backMark);
			_padding = createPadding();
			_buttons = createButtonGroup();
			
			_txt.addEventListener(SkinEvent.SKINNING, skinningHandler, false, 0, true);
			
			_width = width;
			_height = height;
			alignObjectes(_width, _height);
			
			addChildren(_bg, _txt);
			if (_buttons != null) addChild(_buttons);
		}
		/* *********************************************************************
		 * input text field
		 ********************************************************************* */
		public function get frontMark() : String
		{
			return _txt.frontMark;
		}
		public function set frontMark(frontMark : String) : void
		{
			_txt.frontMark = frontMark;
		}
		public function get backMark() : String
		{
			return _txt.backMark;
		}
		public function set backMark(backMark : String) : void
		{
			_txt.backMark = backMark;
		}
		public function get value() : Object
		{
			return _txt.value;
		}
		public function set value(value : Object) : void
		{
			_txt.value = value;
		}
		public function get text() : String
		{
			return _txt.text;
		}
		public function get enabled() : Boolean
		{
			return _txt.enabled;
		}
		public function set enabled(enabled : Boolean) : void
		{
			_txt.enabled = enabled;
		}
		public function get highlight() : Boolean
		{
			return _txt.highlight;
		}
		public function set highlight(highlight : Boolean) : void
		{
			_txt.highlight = highlight;
		}
		public function autoSizeWidth() : void
		{
			_txt.autoSizeWidth();
			var width : Number = _txt.width + _padding.left + _padding.right;
			if (_buttons != null) width += _buttons.width;
			alignObjectes(width, _height);
		}
		public function autoSizeHeight() : void
		{
			_txt.autoSizeHeight();
			var height : Number = _txt.height + _padding.top + _padding.bottom;
			if (_buttons != null) height += _buttons.height;
			alignObjectes(_width, height);
		}
		public function get align() : String
		{
			return _txt.textStyle.align;
		}
		public function set align(align : String) : void
		{
			var ts : TextStyle = _txt.textStyle;
			ts.align = align;
			ts.color = _txt.textColor;
			_txt.textStyle = ts;
		}
		private function alignObjectes(width : Number, height : Number) : void
		{
			_bg.width = (_buttons == null) ? width : width - _buttons.width;
			_bg.height = height;
			_txt.width = _bg.width - _padding.left - _padding.right;
			_txt.height = _bg.height - _padding.top - _padding.bottom;
			_txt.x = _padding.left;
			_txt.y = _padding.top;
			if (_buttons != null) {
				_buttons.x = _bg.width;
			}
		}
		/* *********************************************************************
		 * art
		 ********************************************************************* */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			alignObjectes(value, _height);
		}
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			alignObjectes(_width, value);
		}
		/* *********************************************************************
		 * skinning
		 ********************************************************************* */
		private function skinningHandler(event : SkinEvent) : void
		{
			_bg.skinDraw(event.skinFlag);
		}
		/* *********************************************************************
		 * Skin Factory
		 ********************************************************************* */
		protected function createTextStyle() : TextStyle
		{
			throw new AbstractMemberError();
		}
		protected function createFontColors() : ColorCollection
		{
			throw new AbstractMemberError();
		}
		protected function createBackGround() : ISkinDisplayObject
		{
			throw new AbstractMemberError();
		}
		protected function createPadding() : Padding
		{
			throw new AbstractMemberError();
		}
		protected function createButtonGroup() : SSenSprite
		{
			return null;
		}
	}
}
