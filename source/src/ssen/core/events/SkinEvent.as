package ssen.core.events 
{
	import flash.events.Event;	
	/**
	 * 스킨 이벤트
	 * @author SSen
	 */
	public class SkinEvent extends Event 
	{
		/** 스킨을 입힐때 발생 */
		public static const SKINNING : String = "skinning";
		private var _skinFlag : String;

		
		/** 생성자 */
		public function SkinEvent(type : String, skinFlag : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_skinFlag = skinFlag;
		}
		/** 교체할 상태 이름 */
		public function get skinFlag() : String
		{
			return _skinFlag;
		}
		/** clone */
		override public function clone() : Event
		{
			return new SkinEvent(type, skinFlag, bubbles, cancelable);
		}
		/** toString */
		override public function toString() : String
		{
			return formatToString("SkinEvent", "type", "skinFlag");
		}
	}
}
