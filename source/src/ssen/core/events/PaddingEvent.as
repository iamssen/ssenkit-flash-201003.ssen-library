package ssen.core.events 
{
	import flash.events.Event;
	/**
	 * Padding 에 사용되는 이벤트
	 * @author SSen
	 */
	public class PaddingEvent extends Event 
	{
		/** padding 에 변화가 있을때 발생된다 */
		public static const PADDING_CHANGE : String = "paddingChange";
		private var _top : Number;
		private var _right : Number;
		private var _bottom : Number;
		private var _left : Number;

		
		/** 생성자 */
		public function PaddingEvent(type : String, top : Number = 0, right : Number = 0, bottom : Number = 0, left : Number = 0, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			_top = top;
			_right = right;
			_bottom = bottom;
			_left = left;
		}
		/** top */
		public function get top() : Number
		{
			return _top;
		}
		/** right */
		public function get right() : Number
		{
			return _right;
		}
		/** bottom */
		public function get bottom() : Number
		{
			return _bottom;
		}
		/** left */
		public function get left() : Number
		{
			return _left;
		}
		/** clone */
		override public function clone() : Event
		{
			return new PaddingEvent(type, top, right, bottom, left, bubbles, cancelable);
		}
		/** toString */
		override public function toString() : String
		{
			return formatToString("PaddingEvent", "type", "top", "right", "bottom", "left");
		}
	}
}
