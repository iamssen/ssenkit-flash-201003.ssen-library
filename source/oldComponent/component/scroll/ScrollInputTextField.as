package ssen.component.scroll 
{
	import ssen.component.events.ScrollEvent;
	import ssen.component.scroll.ScrollTextField;
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.events.SkinEvent;
	import ssen.core.text.TextStyle;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextFieldType;	
	/**
	 * @author SSen
	 */
	public class ScrollInputTextField extends ScrollTextField implements ISkinDisplayObject
	{
		private var _maxScrollH : int;
		private var _maxScrollV : int;
		private var _skinFlag : String;
		private var _fontColors : ColorCollection;
		private var _textStyle : TextStyle;
		private var _type : String;
		private var _highlight : Boolean;

		
		public function ScrollInputTextField(textStyle : TextStyle, fontColors : ColorCollection)
		{
			_fontColors = fontColors;
			alwaysShowSelection = true;
			type = TextFieldType.INPUT;
			this.textStyle = textStyle;
			eventOn();
		}
		/* *********************************************************************
		 * public api
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
		/** @private */
		override public function get type() : String
		{
			return _type;
		}
		override public function set type(type : String) : void
		{
			if (_type != type) {
				super.type = type;
				_type = type;
				if (type == TextFieldType.INPUT) {
					eventOn();
				} else {
					eventOff();
				}
				if (enable) {
					skinDraw(SkinFlag.DEFAULT);
				} else {
					skinDraw(SkinFlag.DISABLE);
				}
			}
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
		 * event
		 ********************************************************************* */
		private function eventOff() : void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN, change);
			removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
		}
		private function eventOn() : void
		{
			addEventListener(KeyboardEvent.KEY_DOWN, change, false, 0, true);
			addEventListener(FocusEvent.FOCUS_IN, focusIn, false, 0, true);
			addEventListener(FocusEvent.FOCUS_OUT, focusOut, false, 0, true);
		}
		private function focusIn(event : FocusEvent) : void
		{
			skinDraw(SkinFlag.ACTION);
		}
		private function focusOut(event : FocusEvent) : void
		{
			skinDraw(SkinFlag.DEFAULT);
		}
		private function change(event : Event = null) : void
		{
			if (_maxScrollH != maxScrollH || _maxScrollV != maxScrollV) {
				dispatchEvent(new ScrollEvent(ScrollEvent.CONTENT_CHANGE));
				_maxScrollH = maxScrollH;
				_maxScrollV = maxScrollV;
			}
			var x : Number = isNaN(secX) ? 0 : secX;
			var y : Number = isNaN(secY) ? 0 : secY;
			dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, x, y));
		}
		/* *********************************************************************
		 * implement IScrollContainer
		 ********************************************************************* */
		override public function refresh() : void
		{
			change();
		}
		override public function resourceKill() : void
		{
			eventOff();
		}
		/* *********************************************************************
		 * implement ISkinDisplayObject
		 ********************************************************************* */
		public function skinDraw(flag : String) : void
		{
			if (_highlight && flag == SkinFlag.DEFAULT) flag = SkinFlag.HIGHLIGHT;
			_skinFlag = flag;
			textColor = _fontColors.getColor(_skinFlag);
			if (_skinFlag != flag) dispatchEvent(new SkinEvent(SkinEvent.SKINNING, flag));
		}
		public function get skinFlag() : String
		{
			return _skinFlag;
		}
		public function get skinFlagList() : Vector.<String>
		{
			return _fontColors.skinFlagList;
		}
	}
}
