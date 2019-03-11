package ssen.core.display.graphics 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsPath;
	import flash.geom.Matrix;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Image extends GraphicsBitmapDraw
	{
		private var _mat : Matrix;
		private var _width : Number;
		private var _y : Number;
		private var _x : Number;
		private var _height : Number;
		private var _fill : GraphicsBitmapFill;
		private var _path : GraphicsPath;
		private var _repeat : Boolean;
		public function Image(x : Number = 0, y : Number = 0, width : Number = 0, height : Number = 0, bitmapData : BitmapData = null, repeat : Boolean = false, smooth : Boolean = false)
		{
			_fill = new GraphicsBitmapFill();
			_path = new GraphicsPath();
			_mat = new Matrix();
			
			_x = x;
			_y = y;
			_width = width > 0 ? width : bitmapData.width;
			_height = height > 0 ? height : bitmapData.height;
			_repeat = repeat;
			this.smooth = smooth;
			this.bitmapData = bitmapData;
			
			changed = true;
		}
		override public function draw(graphics : Graphics) : void 
		{
			if (changed) {
				_mat.identity();
				if (!_repeat) {
					_mat.a = _width / bitmapData.width;
					_mat.d = _height / bitmapData.height;
				}
				_mat.tx = _x;
				_mat.ty = _y;
				
				_fill.bitmapData = bitmapData;
				_fill.repeat = _repeat;
				_fill.smooth = smooth;
				_fill.matrix = _mat;
				
				PathMaker.rect(_path, _x, _y, _width, _height);
				
				changed = false;
			}
			GraphicsDraw.draw(graphics, _path, _fill, stroke);
		}
		public function get width() : Number
		{
			return _width;
		}
		public function set width(width : Number) : void
		{
			_width = width > 0 ? width : bitmapData.width;
			changed = true;
		}
		public function get height() : Number
		{
			return _height;
		}
		public function set height(height : Number) : void
		{
			_height = height > 0 ? height : bitmapData.height;
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
		public function get x() : Number
		{
			return _x;
		}
		public function set x(x : Number) : void
		{
			_x = x;
			changed = true;
		}
		public function get repeat() : Boolean
		{
			return _repeat;
		}
		public function set repeat(repeat : Boolean) : void
		{
			_repeat = repeat;
			changed = true;
		}
	}
}
