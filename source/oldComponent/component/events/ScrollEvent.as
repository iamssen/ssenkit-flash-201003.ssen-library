package ssen.component.events 
{
	import flash.events.Event;
	/**
	 * ScrollBar, ScrollContainer 등에서 발생하는 스크롤 이벤트
	 * @author SSen
	 */
	public class ScrollEvent extends Event 
	{
		/** 스크롤되어 움직일때 */
		static public const SCROLL : String = "scrolling"; 
		/** Thumb 이 보이게 될때 */
		static public const THUMB_SHOW : String = "thumbShow";
		/** Thumb 이 안보이게 될때 */
		static public const THUMB_HIDE : String = "thumbHide";
		/** Container 내부의 content 가 변경 될때 */
		static public const CONTENT_CHANGE : String = "contentChange";
		/** Container 내부의 content 가 삭제 될때 */
		static public const CONTENT_DELETED : String = "contentDeleted";
		/** Container 의 mask 가 활성화 될때 */
		static public const MASK_ON : String = "maskOn";
		/** Container 의 mask 가 비활성 될때 */
		static public const MASK_OFF : String = "maskOff";
		private var _secX : Number;
		private var _secY : Number;

		/**
		 * 스크롤바의 이벤트를 가진다.
		 * @param type 이벤트의 타입
		 * @param sec 0~1 로 표현되는 위치값을 지정
		 * @param delta 0~1 의 수치상에서 얼만큼 움직였는지를 지정
		 */
		public function ScrollEvent(type : String, secX : Number = 0, secY : Number = 0, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_secX = secX;
			_secY = secY;
		}
		/** 0~1 로 표현되는 Y위치값을 가져온다 */
		public function get secX() : Number
		{
			return _secX;
		}
		/** 0~1 로 표현되는 Y위치값을 가져온다 */
		public function get secY() : Number
		{
			return _secY;
		}
		/** @public */
		override public function toString() : String
		{
			return '[ScrollEvent type="' + type + '" secX="' + _secX + '" secY="' + _secY + '"]';
		}
	}
}
