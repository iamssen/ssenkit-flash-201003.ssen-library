package ssen.forms.buttons.events 
{
	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ToggleEvent extends Event 
	{
		/** on, off 상태가 변경될때 */
		static public const TOGGLE : String = "toggle";
		private var _toggle : Boolean;
		/** 생성자 */
		public function ToggleEvent(type : String, toggle : Boolean, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_toggle = toggle;
		}
		/** 켜져있는지 꺼져있는지 확인 */
		public function get toggle() : Boolean
		{
			return _toggle;
		}
		/** clone */
		override public function clone() : Event
		{
			return new ToggleEvent(type, toggle, bubbles, cancelable);
		}
		/** toString */
		override public function toString() : String
		{
			return formatToString("ToggleEvent", "type", "onoff");
		}
	}
}
