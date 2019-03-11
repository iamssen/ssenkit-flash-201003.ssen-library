package ssen.component.sliders 
{
	import ssen.component.base.IInput;
	import ssen.component.base.ISSenComponent;
	import ssen.core.display.expanse.ISSenSprite;
	import ssen.core.display.base.ISprite;		
	/**
	 * @author SSen
	 */
	public interface ISlider extends ISprite, ISSenComponent, IInput, ISSenSprite
	{
		/** 최소값 */
		function get minValue() : Number;
		/** 최대값 */
		function get maxValue() : Number;
		/** 최소값, 최대값 등을 셋팅 */
		function minMaxValuesReset(minValue : Number, maxValue : Number, value : Number, trackStep : Object = null, thumbSegmentStep : Boolean = false) : void
		/** 현재 위치의 0~1 값 */
		function get sec() : Number
		function set sec(sec : Number) : void
		/**
		 * wheel 이벤트에 대한 수신
		 * @param delta event.delta Mouse 이벤트 객체의 delta 값
		 */
		function wheel(delta : int) : void
	}
}
