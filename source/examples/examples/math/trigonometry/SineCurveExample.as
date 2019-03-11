package examples.math.trigonometry 
{
	import examples.Example;

	import ssen.core.number.MathEx;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;		
	/**
	 * @author SSen
	 */
	public class SineCurveExample extends Example 
	{
		private var _timer : Timer;
		private var _center : Point;
		private var _clip : Shape;
		private var _degree : int;
		private var _distance : int;

		public function SineCurveExample()
		{
			// setting
			_center = new Point(150, 120);
			_clip = getShape(0x000000);
			_distance = 80;
			var center : Shape = getShape(0x0000ff);
			center.x = _center.x;
			center.y = _center.y;
			addChildren(center, _clip);
			
			// storage initialize
			_degree = 0;
			draw();
			
			// timer start
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, timer);
			_timer.start();
		}
		private function draw() : void
		{
			// convert to radian
			var r : Number = MathEx.RADIAN[_degree];
			// cosine curve
			var x : Number = _distance * Math.cos(r);
			// sine curve
			var y : Number = -_distance * Math.sin(r);
			
			_clip.x = x + _center.x;
			_clip.y = y + _center.y;
		}
		private function timer(event : TimerEvent) : void
		{
			_degree += 2;
			_degree %= 360;
			draw();
		}
		private function getShape(color : uint) : Shape
		{
			var shape : Shape = new Shape();
			var g : Graphics = shape.graphics;
			g.beginFill(color);
			g.drawCircle(-2, -2, 4);
			g.endFill();
			
			return shape;
		}
	}
}
