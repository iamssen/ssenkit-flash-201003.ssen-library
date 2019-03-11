package ssen.debug 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class NumberWave extends Sprite 
	{
		private var _height : Number;
		private var _time : int;
		private var _zero : Number;
		private var _min : Number;
		private var _max : Number;
		public function NumberWave(height : Number = 100, min : Number = 0, max : Number = 1)
		{
			_height = height;
			_time = 0;
			_zero = _height >> 1;
			_min = min;
			_max = max;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		public function add(value : Number) : void
		{
			value = (value / _max) + _min;
			var g : Graphics = graphics;
			g.beginFill(0x000000, 0.5);
			g.drawRect(_time, 0, 1, _height);
			g.endFill();
			g.beginFill(0xffffff);
			g.drawCircle(_time + 0.5, _zero, 0.5);
			g.endFill();
			g.beginFill(0x000000);
			g.drawCircle(_time + 0.5, (-value * (_height >> 1)) + (_height >> 1), 0.5);
			g.endFill();
			
			var max : Number = _time - stage.stageWidth;
			x = max > 0 ? -max : 0;
			
			_time++;
		}
		override public function get height() : Number
		{
			return _height;
		}
	}
}
