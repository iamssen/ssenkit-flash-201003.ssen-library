package ssen.core.events 
{
	import flash.events.Event;	
	/**
	 * Value 에 사용되는 Event
	 * @author SSen
	 */
	public class ValueEvent extends Event 
	{
		/** 이미 존재하는 Value 의 값이 교체될때 */
		public static const VALUE_CHANGED : String = "valueChanged";
		/** 새로운 Value 가 추가될때 */
		public static const VALUE_ADDED : String = "valueAdded";
		/** Value 가 삭제될때 */
		public static const VALUE_DELETED : String = "valueDeleted";
		private var _valueName : String;
		private var _value : Object;

		
		/** 생성자 */
		public function ValueEvent(type : String, valueName : String, value : Object = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			_valueName = valueName;
			_value = value;
		}
		/** property name */
		public function get valueName() : String
		{
			return _valueName;
		}
		/** property value */
		public function get value() : Object
		{
			return _value;
		}
		/** clone */
		override public function clone() : Event
		{
			return new ValueEvent(type, _valueName, _value, bubbles, cancelable);
		}
		/** toString */
		public override function toString() : String
		{
			return formatToString("ValueEvent", "type", "valueName", "value");
		}
	}
}
