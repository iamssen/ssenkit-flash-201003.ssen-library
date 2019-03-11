package ssen.forms.textInput {
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.text.TextStyle;
	import ssen.forms.base.FormSprite;
	import ssen.forms.base.ISSenFormData;
	import ssen.forms.scroll.ScrollBar;
	import ssen.forms.scroll.ScrollBarPool;
	import ssen.forms.scroll.ScrollDirection;

	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.FocusEvent;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextArea extends FormSprite implements ISSenTextInput {

		[Embed(source="asset/textArea/piece_default.png")]
		private static var defaultImage : Class;
		private static var _pieceDefault : BitmapData;

		[Embed(source="asset/textArea/piece_disable.png")]
		private static var disableImage : Class;
		private static var _pieceDisable : BitmapData;
		private var _text : InputTextField;
		private var _scrollH : ScrollBar;
		private var _scrollV : ScrollBar;
		private var _vertical : Boolean;
		private var _horizontal : Boolean;
		private var _trackMode : String;

		public function initialize() : void {
			_text = new InputTextField();
			_text.initialize();
			_text.multiline = true;
			_text.wordWrap = true;
			
			addChild(_text);
			_initialized = true;
		}

		public function setting(data : TextInputData = null, 
								width : int = 300, height : int = 100, 
								verticalScroll : Boolean = true, 
								horizontalScroll : Boolean = true, 
								textStyle : TextStyle = null, 
								fontColors : ColorCollection = null, 
								scrollTrackMode : String = "point") : void {
			_enabled = true;
			
			_formWidth = width;
			_formHeight = height;
			_vertical = verticalScroll;
			_horizontal = horizontalScroll;
			_trackMode = scrollTrackMode;
			
			if (verticalScroll) {
				_scrollV = getScrollV();
				_scrollV.initialize();
				_scrollV.addEventListener(Event.SCROLL, scroll);
				addChild(_scrollV);
			} 
			if (horizontalScroll) {
				_scrollH = getScrollH();
				_scrollH.initialize();
				_scrollH.addEventListener(Event.SCROLL, scroll);
				addChild(_scrollH);
			}
			
			_text.setting(data, _formWidth, _formHeight, textStyle ? textStyle : getTextStyle(), fontColors ? fontColors : getFontColors());
			draw();
			
			setScroll();
			_text.addEventListener(FocusEvent.FOCUS_IN, textFocusIn);
			_text.addEventListener(Event.CHANGE, textChange);
		}

		private function textFocusIn(event : FocusEvent) : void {
			_text.removeEventListener(FocusEvent.FOCUS_IN, textFocusIn);
			
			_text.addEventListener(Event.SCROLL, textScroll);
			_text.addEventListener(FocusEvent.FOCUS_OUT, textFocusOut);
		}

		private function textFocusOut(event : FocusEvent) : void {
			_text.removeEventListener(Event.SCROLL, textScroll);
			_text.removeEventListener(FocusEvent.FOCUS_OUT, textFocusOut);
			
			_text.addEventListener(FocusEvent.FOCUS_IN, textFocusIn);
		}

		private function textChange(event : Event) : void {
			setScroll();
			dispatchEvent(event);
		}

		private function setScroll() : void {
			if (_scrollV) {
				_scrollV.scrollPosition = _text.scrollV - 1;
				_scrollV.maxScrollPosition = _text.maxScrollV - 1;
				_scrollV.minScrollPosition = 0;
				_scrollV.pageSize = _text.numLines - 1;
			}
			if (_scrollH) {
				_scrollH.scrollPosition = _text.scrollH;
				_scrollH.maxScrollPosition = _text.maxScrollH;
				_scrollH.minScrollPosition = 0;
				_scrollH.pageSize = _text.maxScrollH + _text.width;
			}
		}

		private function textScroll(event : Event) : void {
			if (_scrollV) _scrollV.scrollPosition = _text.scrollV - 1;
			if (_scrollH) _scrollH.scrollPosition = _text.scrollH;
		}

		private function scroll(event : Event) : void {
			if (_scrollV) _text.scrollV = _scrollV.scrollPosition + 1;
			if (_scrollH) _text.scrollH = _scrollH.scrollPosition;
		}

		protected function getTextStyle() : TextStyle {
			return new TextStyle();
		}

		protected function getFontColors() : ColorCollection {
			var colors : ColorCollection = new ColorCollection();
			colors.addColor(SkinFlag.DEFAULT, 0x616161);
			colors.addColor(SkinFlag.ACTION, 0x464646);
			colors.addColor(SkinFlag.DISABLE, 0xcccccc);
			colors.addColor(SkinFlag.HIGHLIGHT, 0xb62828);
			return colors;
		}

		protected function getScrollH() : ScrollBar {
			var scroll : ScrollBar = ScrollBarPool.scroll;
			if (!scroll.initialized) scroll.initialize();
			scroll.setting(ScrollDirection.HORIZONTAL, _formWidth - 10, 10, _trackMode);
			return scroll;
		}

		protected function getScrollV() : ScrollBar {
			var scroll : ScrollBar = ScrollBarPool.scroll;
			if (!scroll.initialized) scroll.initialize();
			scroll.setting(ScrollDirection.VERTICAL, 10, _formHeight - 10, _trackMode);
			return scroll;
		}

		protected function draw() : void {
			var textWidth : Number = scrollV ? formWidth - scrollV.width : formWidth;
			var textHeight : Number = scrollH ? formHeight - scrollH.height : formHeight;
			tf.width = textWidth - 2;
			tf.height = textHeight - 2;
			tf.x = 1;
			tf.y = 1;
			if (scrollV) {
				scrollV.formHeight = textHeight;
				scrollV.x = textWidth;
				scrollV.y = 1;
			}
			if (scrollH) {
				scrollH.formWidth = textWidth;
				scrollH.y = textHeight;
				scrollH.x = 1;
			}
			
			graphics.clear();
			graphics.beginFill(0x000000, 0);
			graphics.lineStyle(1, 0xd8d8d8);
			graphics.drawRect(0, 0, formWidth, formHeight);
			graphics.endFill();
			
			drawPiece();
		}

		private function drawPiece() : void {
			if (!scrollV || !scrollH) return;
			if (!_pieceDefault) _pieceDefault = new defaultImage().bitmapData;
			if (!_pieceDisable) _pieceDisable = new disableImage().bitmapData;
			
			graphics.beginBitmapFill(_enabled ? _pieceDefault : _pieceDisable);
			graphics.drawRect(scrollV.x, scrollH.y, 10, 10);
			graphics.endFill();
		}

		protected function get tf() : InputTextField {
			return _text;
		}

		public function get text() : String {
			return _text.text;
		}

		public function set text(text : String) : void {
			_text.text = text;
		}

		protected function get scrollH() : ScrollBar {
			return _scrollH;
		}

		protected function get scrollV() : ScrollBar {
			return _scrollV;
		}

		override public function set formWidth(width : Number) : void {
			_formWidth = width;
			draw();
		}

		override public function set formHeight(height : Number) : void {
			_formHeight = height;
			draw();
		}

		/* *********************************************************************
		 * implement ISSenTextInput 
		 ********************************************************************* */
		override public function kill() : void {
			_text.data = null;
			_enabled = false;
			if (_scrollV) {
				removeChild(_scrollV);
				ScrollBarPool.scroll = _scrollV;
				_scrollV = null;
			}
			if (_scrollH) {
				removeChild(_scrollH);
				ScrollBarPool.scroll = _scrollH;
				_scrollH = null;
			}
		}

		override public function deconstruction() : void {
		}

		override public function get data() : ISSenFormData {
			return _text.data;
		}

		override public function set enabled(enabled : Boolean) : void {
			if (enabled != _enabled) {
				_enabled = enabled;
				mouseChildren = enabled;
				_text.enabled = enabled;
				if (_scrollV) _scrollV.enabled = enabled;
				if (_scrollH) _scrollH.enabled = enabled;
				drawPiece();
			}
		}

		override public function set data(data : ISSenFormData) : void {
			_text.data = data;
			draw();
			setScroll();
		}
	}
}
