package ssen.core.geom 
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Camera3D 
	{
		private var _position : Vector3D;		// 카메라 위치
		private var _look : Vector3D;	// 시선 위치
		private var _up : Vector3D;		// 상방벡터
		private var _view : Vector3D;		// 카메라가 향항 방향(방향벡터)
		private var _cross : Vector3D;	// 카메라의 측면 방향(방향벡터)
		private var _matrix : Matrix3D;		
		private var _mat : Matrix3D;
		private var _invalidate : Boolean;
		private var _reverse : Boolean;
		private var _reverseMatrix : Matrix3D;
		private var _scale:Number;
		// 카메라 행렬
		public function initialize(position : Vector3D, look : Vector3D, up : Vector3D) : void
		{
			_matrix = new Matrix3D();
			_mat = new Matrix3D();
			
			setView(position, look, up);
		}
		private function setView(position : Vector3D, look : Vector3D, up : Vector3D) : void 
		{
			_position = position;
			_look = look;
			_up = up;
			
			_view = _look.subtract(_position);
			_view.normalize();
			_cross = _up.crossProduct(_view);
			
			_invalidate = true;
		}
		public function rotateX(angle : Number) : void 
		{
			_mat.identity();
			_mat.appendRotation(angle, _cross);
			var view : Vector3D = _mat.transformVector(_view);
			view = view.add(_position);
			setView(_position, view, _up);
		}
		public function rotateY(angle : Number) : void 
		{
			_mat.identity();
			_mat.appendRotation(-angle, _up);
			var view : Vector3D = _mat.transformVector(_view);
			view = view.add(_position);
			setView(_position, view, _up);
		}
		public function moveX(dist : Number) : void 
		{
			var position : Vector3D = _position;
			var look : Vector3D = _look;
			var move : Vector3D = _cross.clone();
			move.normalize();
			move.scaleBy(dist);
			position = position.add(move);
			look = look.add(move);
			setView(position, look, _up);
		}
		public function moveY(dist : Number) : void 
		{
			var position : Vector3D = _position;
			var look : Vector3D = _look;
			var move : Vector3D = _up.clone();
			move.normalize();
			move.scaleBy(dist);
			position = position.add(move);
			look = look.add(move);
			setView(position, look, _up);
		}
		public function moveZ(dist : Number) : void 
		{
			var position : Vector3D = _position.clone();
			var look : Vector3D = _look.clone();
			var move : Vector3D = _view.clone();
			move.normalize();
			move.scaleBy(dist);
			position = position.add(move);
			look = look.add(move);
			setView(position, look, _up);
		}
		public function MoveTo(move : Vector3D) : void
		{
			var dv : Vector3D = move.subtract(_position);
			_position = move;
			_look = _look.add(dv);
			setView(_position, _look, _up);
		}
		private function setMatrix() : void
		{
			var zAxis : Vector3D = _look.subtract(_position);
			zAxis.normalize();
			var xAxis : Vector3D = _up.crossProduct(zAxis);
			xAxis.normalize();
			var yAxis : Vector3D = zAxis.crossProduct(xAxis);
			
			var data : Vector.<Number> = _matrix.rawData;
			data[0] = xAxis.x;
			data[1] = yAxis.x; 
			data[2] = zAxis.x; 
			data[3] = 0;
			data[4] = xAxis.y; 
			data[5] = yAxis.y; 
			data[6] = zAxis.y; 
			data[7] = 0;
			data[8] = xAxis.z; 
			data[9] = yAxis.z; 
			data[10] = zAxis.z; 
			data[11] = 0;
			data[12] = -xAxis.dotProduct(_position); 
			data[13] = -yAxis.dotProduct(_position); 
			data[14] = -zAxis.dotProduct(_position); 
			data[15] = 1;
			_matrix.rawData = data;
			
			_invalidate = false;
			_reverse = true;
			
			_matrix.appendScale(_scale, _scale, 1);
		}
		public function matrix() : Matrix3D
		{
			if (_invalidate) setMatrix();
			return _matrix;
		}
		public function reverseMatrix() : Matrix3D
		{
			_reverseMatrix = _matrix.clone();
			_reverseMatrix.invert();
			_reverse = false;
			
			return _reverseMatrix;
		}
		public function transformVector(vector : Vector3D) : Vector3D
		{
			if (_invalidate) setMatrix();
			return _matrix.transformVector(vector);
		}
		public function get invalidate() : Boolean
		{
			return _invalidate;
		}
		public function set invalidate(invalidate : Boolean) : void
		{
			_invalidate = invalidate;
		}
		public function get position() : Vector3D
		{
			return _position;
		}
		public function set position(position : Vector3D) : void
		{
			_position = position;
		}
		public function get look() : Vector3D
		{
			return _look;
		}
		public function set look(look : Vector3D) : void
		{
			_look = look;
		}
		public function get scale() : Number
		{
			return _scale;
		}
		public function set scale(scale : Number) : void
		{
			_scale = scale;
			_invalidate = true;
		}
	}
}
