package ssen.component.scroll 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.errors.AbstractMemberError;
	import ssen.core.geom.Padding;
	import ssen.core.text.TextStyle;

	import flash.display.DisplayObject;
	/**
	 * @author SSen
	 */
	public class TextAreaBase extends SSenSprite implements ITextArea
	{
		protected var _text : ScrollInputTextField;
		protected var _width : Number;
		protected var _height : Number;
		protected var _directionMode : String;
		protected var _scrollerH : IScroller;
		protected var _scrollerV : IScroller;
		protected var _padding : Padding;
		protected var _piece : ISkinDisplayObject;
		private var _enable : Boolean;
		public function TextAreaBase(textStyle : TextStyle, fontColors : ColorCollection,
									width : Number = 300, height : Number = 250, padding : Padding = null,
									secX : Number = 0, secY : Number = 0, directionMode : String = "verticalAndHorizontal",
									isTrackHide : Boolean = false, trackMode : String = "point")
		{
			_width = width;
			_height = height;
			_padding = (padding == null) ? new Padding() : padding;
			
			// text field setting
			_text = new ScrollInputTextField(textStyle, fontColors);
			addChildren(_text);
			
			// scroller setting
			if (directionMode == DirectionMode.VERTICAL_AND_HORIZONTAL) {
				_directionMode = DirectionMode.VERTICAL_AND_HORIZONTAL;
				_scrollerH = createScrollerH(width);
				_scrollerV = createScrollerV(height);
				_scrollerH.init(_text, secX, isTrackHide, trackMode);
				_scrollerV.init(_text, secY, isTrackHide, trackMode);
				addChildren(_scrollerH, _scrollerV);
				
				_piece = createPiece();
				if (_piece) addChild(DisplayObject(_piece));
			} else if (directionMode == DirectionMode.VERTICAL) {
				_directionMode = DirectionMode.VERTICAL;
				_scrollerV = createScrollerV(height);
				_scrollerV.init(_text, secY, isTrackHide, trackMode);
				addChild(DisplayObject(_scrollerV));
			} else if (directionMode == DirectionMode.HORIZONTAL) {
				_directionMode = DirectionMode.HORIZONTAL;
				_scrollerH = createScrollerH(width);
				_scrollerH.init(_text, secX, isTrackHide, trackMode);
				addChild(DisplayObject(_scrollerH));
			} else {
				throw new Error("ssen.component.scroll.ScrollPane :: scrollerH 와 scrollerV 둘 중 하나는 존재해야 합니다.");
			}
			
			align();
		}
		protected function createPiece() : ISkinDisplayObject
		{
			return null;
		}
		protected function createScrollerH(width : Number) : IScroller
		{
			throw new AbstractMemberError();
		}
		protected function createScrollerV(height : Number) : IScroller
		{
			throw new AbstractMemberError();
		}
		protected function align() : void
		{
			trace("align", _width, _height);
			switch (_directionMode) {
				case DirectionMode.VERTICAL_AND_HORIZONTAL :
					_text.x = _padding.left;
					_text.y = _padding.top;
					_text.width = _width - _scrollerV.width - _padding.left - _padding.right;
					_text.height = _height - _scrollerH.height - _padding.top - _padding.bottom;
					_scrollerV.height = _text.height;
					_scrollerV.x = _text.width + _padding.left;
					_scrollerV.y = _padding.top;
					_scrollerH.width = _text.width;
					_scrollerH.x = _padding.left;
					_scrollerH.y = _text.height + _padding.top;
					
					if (_piece) {
						_piece.x = _width - _piece.width - _padding.left - _padding.right;
						_piece.y = _height - _piece.height - _padding.top - _padding.bottom;
					}
					break; 
				case DirectionMode.VERTICAL :
					_text.x = _padding.left;
					_text.y = _padding.top;
					_text.width = _width - _scrollerV.width - _padding.left - _padding.right;
					_text.height = _height - _padding.top - _padding.bottom;
					_scrollerV.height = _text.height;
					_scrollerV.x = _text.width + _padding.left;
					_scrollerV.y = _padding.top;
					break; 
				case DirectionMode.HORIZONTAL :
					_text.x = _padding.left;
					_text.y = _padding.top;
					_text.width = _width - _padding.left - _padding.right;
					_text.height = _height - _scrollerH.height - _padding.top - _padding.bottom;
					_scrollerH.width = _text.width;
					_scrollerH.x = _padding.left;
					_scrollerH.y = _text.height + _padding.top;
					break;
			}
		}
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			align();
			_text.refresh();
		}
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			align();
			_text.refresh();
		}
		public function get text() : String
		{
			return _text.text;
		}
		public function set text(text : String) : void
		{
			_text.text = text;
		}
		public function resourceKill() : void
		{
		}
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable != _enable) {
				_text.enable = enable;
				if (_scrollerH != null) _scrollerH.enable = enable;
				if (_scrollerV != null) _scrollerV.enable = enable;
				mouseChildren = enable;
				mouseEnabled = enable;
				_enable = enable;
			}
		}
		public function skinDraw(flag : String) : void
		{
		}
		public function get skinFlag() : String
		{
			// TODO: Auto-generated method stub
			return null;
		}
		public function get skinFlagList() : Vector.<String>
		{
			// TODO: Auto-generated method stub
			return null;
		}
	}
}
