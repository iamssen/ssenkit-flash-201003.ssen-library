package ssen.component.events
{
	import flash.events.Event;
	/**
	 * @author SSen
	 */
	public class SlideEvent extends Event 
	{
		/** 슬라이드 되어 움직일때 */
		static public const SLIDE : String = "slide";
		/** value 에 변경이 있을때, SLIDE 와 달리 easing 에 대한 감지가 없다 */
		static public const VALUE_CHANGED : String = "valueChanged";
		private var _sec : Number;
		private var _value : Number;
		private var _minValue : Number;
		private var _maxValue : Number;

		public function SlideEvent(type : String, value : Number, minValue : Number, maxValue : Number, sec : Number, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_sec = sec;
			_value = value;
			_minValue = minValue;
			_maxValue = maxValue;
		}
		public function get sec() : Number
		{
			return _sec;
		}
		public function get value() : Number
		{
			return _value;
		}
		public function get minValue() : Number
		{
			return _minValue;
		}
		public function get maxValue() : Number
		{
			return _maxValue;
		}
		override public function toString() : String
		{
			return '[SliderEvent type="' + type + '" value="' + _value + '" minValue="' + _minValue + '" maxValue="' + _maxValue + '" sec="' + _sec + '"]';
		}
	}
}
