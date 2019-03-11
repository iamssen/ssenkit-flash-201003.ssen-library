package ssen.core.geom 
{
	import de.polygonal.core.ObjectPool;

	import flash.geom.Vector3D;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class World3D 
	{
		private var _camera : Camera3D;
		private var _x : int;
		private var _y : int;
		private var _f : int;
		private var _w : int;
		private var _h : int;
		public function initialize(camera : Camera3D, projectionCenterX : int, projectionCenterY : int, focalLength : int, stageWidth : int, stageHeight : int) : void 
		{
			_camera = camera;
			_x = projectionCenterX;
			_y = projectionCenterY;
			_f = focalLength;
			_w = stageWidth;
			_h = stageHeight;
		}
		public function get stageWidth() : int
		{
			return _w;
		}
		public function set stageWidth(stageWidth : int) : void
		{
			_w = stageWidth;
		}
		public function get stageHeight() : int
		{
			return _h;
		}
		public function set stageHeight(stageHeight : int) : void
		{
			_h = stageHeight;
		}
		public function get projectionCenterX() : int
		{
			return _x;
		}
		public function set projectionCenterX(projectionCenterX : int) : void
		{
			_x = projectionCenterX;
		}
		public function get projectionCenterY() : int
		{
			return _y;
		}
		public function set projectionCenterY(projectionCenterY : int) : void
		{
			_y = projectionCenterY;
		}
		public function get focalLength() : int
		{
			return _f;
		}
		public function set focalLength(focalLength : int) : void
		{
			_f = focalLength;
		}
		public function get camera() : Camera3D
		{
			return _camera;
		}
		public function set camera(camera : Camera3D) : void
		{
			_camera = camera;
		}
		public function project(vector : Vector3D) : Point2D
		{
			var v : Vector3D = _camera.transformVector(vector);
			var p : Point2D = point2d.object;
			p.x = v.x * _f / (_f - v.z) + _x;
			p.y = v.y * _f / (_f - v.z) + _y;
			return p;
		}
		public function getOriginPos(point : Point2D) : Point3D
		{
			// screen 의 x, y 를 가져와서
			// camera matrix 에서 역산한 뒤에
			// 실제 wall 의 x, y, z 를 가져온다.
			point.x = (point.x - _x) * _f / _f;
			point.y = (point.y - _y) * _f / _f;
			var vec : Vector3D = vector3d.object;
			vec.x = point.x;
			vec.y = point.y;
			vec.z = 0;
			var t : Vector3D = _camera.reverseMatrix().transformVector(vec);
			var p : Point3D = point3d.object;
			p.x = t.x + t.z;
			p.y = t.y + t.z;
			p.z = 0;
			vector3d.object = vec;
			return p;
		}
		/* *********************************************************************
		 * pooling
		 ********************************************************************* */
		private static var _point2d : ObjectPool;
		public static function get point2d() : ObjectPool
		{
			if (_point2d) return _point2d;
			_point2d = new ObjectPool();
			_point2d.allocate(10, Point2D);
			return _point2d;
		}
		private static var _point3d : ObjectPool;
		public static function get point3d() : ObjectPool
		{
			if (_point3d) return _point3d;
			_point3d = new ObjectPool();
			_point3d.allocate(10, Point3D);
			return _point3d;
		}
		private static var _vector3d : ObjectPool;
		public static function get vector3d() : ObjectPool
		{
			if (_vector3d) return _vector3d;
			_vector3d = new ObjectPool();
			_vector3d.allocate(10, Vector3D);
			return _vector3d;
		}
	}
}
