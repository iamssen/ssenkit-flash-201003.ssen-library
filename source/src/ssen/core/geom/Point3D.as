package ssen.core.geom 
{
	import ssen.core.utils.FormatToString;
	import flash.geom.Vector3D;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Point3D 
	{
		public var x : Number;
		public var y : Number;
		public var z : Number;
		public function copy(vector : Vector3D) : void
		{
			vector.x = x;
			vector.y = y;
			vector.z = z;
		}
		public function toString() : String {
			return FormatToString.toString(this, "x", "y", "z");
		}
	}
}
