package ssen.core.events 
{
	import flash.events.Event;			
	/**
	 * DateEvent
	 * @author SSen
	 */
	public class DateEvent extends Event
	{
		/** 달력의 날짜가 변경되었을 경우 */
		static public const DATE_CHANGE : String = "dateChange";
		private var _date : Date;

		
		/**
		 * 생성자
		 * @param type 이벤트 타입
		 * @param date Date 객체
		 */
		public function DateEvent(type : String, date : Date, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_date = date;
		}
		/** Date */
		public function get date() : Date
		{
			return _date;
		}
		/** clone */
		override public function clone() : Event
		{
			return new DateEvent(type, date, bubbles, cancelable);
		}
		/** toString */
		public override function toString() : String
		{
			return formatToString("DateEvent", "type", "date");
		}
	}
}