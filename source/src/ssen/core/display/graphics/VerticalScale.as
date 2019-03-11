package ssen.core.display.graphics 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsPath;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class VerticalScale extends GraphicsBitmapDraw 
	{
		private var _x : Number;
		private var _y : Number;
		private var _width : Number;
		private var _height : Number;
		private var _topFix : Number;
		private var _bottomFix : Number;
		private var _fill : GraphicsBitmapFill;
		private var _mat : Matrix;
		private var _path : GraphicsPath;
		public function VerticalScale(x : Number = 0, y : Number = 0, height : Number = 100, topFix : Number = 10, bottomFix : Number = 10, bitmapData : BitmapData = null, smooth : Boolean = false)
		{
			_fill = new GraphicsBitmapFill();
			_mat = new Matrix();
			_path = new GraphicsPath();
			
			_x = x;
			_y = y;
			_width = bitmapData ? bitmapData.width : 100;
			_height = height;
			_topFix = topFix;
			_bottomFix = bottomFix;
			
			this.bitmapData = bitmapData;
			this.smooth = smooth;
			changed = true;
		}
		override public function draw(graphics : Graphics) : void 
		{
			var min : Number = _topFix + _bottomFix;
			var ow : Number = bitmapData.width;
			var oh : Number = bitmapData.height;
			if (_height > min) {
				var rows : Array = [0, _topFix, oh - _bottomFix, oh];
				var dRows : Array = [0, _topFix, _height - _bottomFix, _height];
				
				var origin : Rectangle;
				var draw : Rectangle;
			
				var cy : int = -1;
				while(++cy < 3) {
					origin = new Rectangle(0, rows[cy], _width, rows[cy + 1] - rows[cy]);
					draw = new Rectangle(0, dRows[cy], _width, dRows[cy + 1] - dRows[cy]);
					_mat.identity();
					_mat.a = draw.width / origin.width;
					_mat.d = draw.height / origin.height;
					_mat.tx = (draw.x - origin.x * _mat.a) + _x;
					_mat.ty = (draw.y - origin.y * _mat.d) + _y;
					_fill.bitmapData = bitmapData;
					_fill.matrix = _mat;
					PathMaker.rect(_path, draw.x + _x, draw.y + _y, draw.width, draw.height);
					GraphicsDraw.draw(graphics, _path, _fill, stroke);
				}
			} else {
				_mat.identity();
				_mat.tx = _x % ow;
				_mat.ty = _y % oh;
				_mat.a = _width / ow;
				_mat.d = _height / oh;
				_fill.bitmapData = bitmapData;
				_fill.matrix = _mat;
				PathMaker.rect(_path, _x, _y, _width, _height);
				GraphicsDraw.draw(graphics, _path, _fill, stroke);
			}
			changed = false;
		}
		public function get x() : Number
		{
			return _x;
		}
		public function set x(x : Number) : void
		{
			_x = x;
			changed = true;
		}
		public function get y() : Number
		{
			return _y;
		}
		public function set y(y : Number) : void
		{
			_y = y;
			changed = true;
		}
		public function get width() : Number
		{
			return _width;
		}
		public function set width(width : Number) : void
		{
			_width = width;
			changed = true;
		}
		public function get height() : Number
		{
			return _height;
		}
		public function set height(height : Number) : void
		{
			_height = height;
			changed = true;
		}
		public function get topFix() : Number
		{
			return _topFix;
		}
		public function set topFix(topFix : Number) : void
		{
			_topFix = topFix;
			changed = true;
		}
		public function get bottomFix() : Number
		{
			return _bottomFix;
		}
		public function set bottomFix(bottomFix : Number) : void
		{
			_bottomFix = bottomFix;
			changed = true;
		}
	}
}
