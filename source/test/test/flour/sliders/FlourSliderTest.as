package test.flour.sliders 
{
	import ssen.component.events.SlideEvent;
	import ssen.core.number.MathEx;
	import ssen.debug.TestButtonGroup;
	import ssen.flour.sliders.FlourSimpleSliderH;
	import ssen.flour.sliders.FlourSimpleSliderV;
	
	import test.flour.FlourTest;
	
	import flash.geom.Point;	
	/**
	 * @author SSen
	 */
	public class FlourSliderTest extends FlourTest 
	{
		private var sliderH : FlourSimpleSliderH;
		private var sliderV : FlourSimpleSliderV;

		override protected function initialize() : void
		{
			var vec : Vector.<Number> = new Vector.<Number>();
			vec.push(10, 90);
			/*
			 * slider test list
			 * TODO #resize
			 * TODO #step rewrite
			 * TODO #move speed change
			 * TODO wheel test
			 * TODO #minValue, maxValue, value change
			 * TODO #sec, value sync
			 * TODO #enable change
			 * 
			 */
			sliderH = new FlourSimpleSliderH(100, 0, 100, 50, 10, true);
			sliderH.position = new Point(10, 10);
			sliderV = new FlourSimpleSliderV(100, 0, 100, 50, 10, true);
			sliderV.position = sliderH.nextPosition(240);
			sliderH.addEventListener(SlideEvent.VALUE_CHANGED, sliderEvent);
			//sliderV.addEventListener(SlideEvent.SLIDE, sliderEvent);
			var test : TestButtonGroup = new TestButtonGroup("slider resize", sliderResize, "slider step rewrite", sliderStepRewrite, "slider move speed change", sliderMoveSpeedChange, "slider max value change", sliderMinMaxValueChange, "slider value random", sliderValueRandom, "slider sec change", sliderSecChange, "slider enable change", sliderEnableChange);
			test.position = sliderH.nextPositionBr(200);
			
			addChildren(test, sliderH, sliderV);
		}
		private function sliderEnableChange() : void
		{
			sliderH.enable = (sliderH.enable) ? false : true;
			sliderV.enable = (sliderV.enable) ? false : true;
		}
		private function sliderSecChange() : void
		{
			log("prev sec change :", sliderH.value, sliderV.value);
			sliderH.sec = 0.4;
			sliderV.sec = 0.8;
			log("next sec change :", sliderH.value, sliderV.value);
		}
		private function sliderValueRandom() : void
		{
			sliderH.value = MathEx.rand(sliderH.minValue, sliderH.maxValue);
			sliderV.value = MathEx.rand(sliderV.minValue * -2, sliderV.maxValue * 2);
			log(sliderH.value, sliderH.minValue, sliderH.maxValue, sliderV.value, sliderV.minValue, sliderV.maxValue);
		}
		private function sliderMinMaxValueChange() : void
		{
			sliderH.minMaxValuesReset(40, 1000, 100, 100, true);
			sliderV.minMaxValuesReset(0, 10, 100, 3, true);
			log(sliderH.value, sliderH.minValue, sliderH.maxValue, sliderV.value, sliderV.minValue, sliderV.maxValue);
		}
		private function sliderMoveSpeedChange() : void
		{
			sliderH.thumbMoveSpeed = 0.6;
			sliderV.thumbMoveSpeed = 0.1;
		}
		private function sliderEvent(event : SlideEvent) : void
		{
			log(event);
		}
		private function sliderStepRewrite() : void
		{
			var vec : Vector.<Number> = new Vector.<Number>();
			vec.push(20, 40, 70);
			if (sliderH.trackStep is Number) {
				sliderH.trackStep = vec;
				sliderV.trackStep = 5;
			} else {
				sliderH.trackStep = 10;
				sliderV.trackStep = vec;
			}
		}
		private function sliderResize() : void
		{
			sliderH.width = MathEx.rand(100, 300);
			sliderH.height = MathEx.rand(100, 300);
			sliderV.width = MathEx.rand(100, 300);
			sliderV.height = MathEx.rand(100, 300);
		}
	}
}
