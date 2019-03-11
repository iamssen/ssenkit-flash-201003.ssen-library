package ssen.core.geom 
{
	import ssen.core.utils.FormatToString;

	import flash.geom.Point;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Point2D 
	{
		public var x : Number;
		public var y : Number;
		public function Point2D(x : Number = 0, y : Number = 0)
		{
			this.x = x;
			this.y = y;
		}
		public function copy(point : Point) : void
		{
			point.x = x;
			point.y = y;
		}
		public static function copyVertices(vec : Vector.<Number>, ...points : Array) : void
		{
			var f : int = -1;
			var i : int = 0;
			var point : Point2D;
			while(++f < points.length) {
				point = points[f];
				vec[i] = point.x;
				vec[i + 1] = point.y;
				i += 2;
			}
		}
		public function toString() : String 
		{
			return FormatToString.toString(this, "x", "y");
		}
	}
}
