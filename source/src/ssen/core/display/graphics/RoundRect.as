package ssen.core.display.graphics 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class RoundRect extends GraphicsVectorDraw
	{
		private var _x : Number;
		private var _y : Number;
		private var _width : Number;
		private var _height : Number;
		private var _path : GraphicsPath;
		private var _ellipseWidth : Number;
		private var _ellipseHeight : Number;
		public function RoundRect(x : Number = 0, y : Number = 0, width : Number = 100, height : Number = 100, ellipseWidth : Number = 10, ellipseHeight : Number = 10, stroke : IGraphicsStroke = null, fill : IGraphicsFill = null) 
		{
			_path = new GraphicsPath();
			
			_x = x;
			_y = y;
			_width = width;
			_height = height;
			_ellipseWidth = ellipseWidth;
			_ellipseHeight = ellipseHeight;
			
			this.stroke = stroke;
			this.fill = fill;
			
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
		override public function draw(graphics : Graphics) : void
		{
			if (changed) {
				PathMaker.roundRect(_path, _x, _y, _width, _height, _ellipseWidth, _ellipseHeight);
				changed = false;
			}
			
			GraphicsDraw.draw(graphics, _path, fill, stroke);
		}
		public function get ellipseWidth() : Number
		{
			return _ellipseWidth;
		}
		public function set ellipseWidth(ellipseWidth : Number) : void
		{
			_ellipseWidth = ellipseWidth;
			changed = true;
		}
		public function get ellipseHeight() : Number
		{
			return _ellipseHeight;
		}
		public function set ellipseHeight(ellipseHeight : Number) : void
		{
			_ellipseHeight = ellipseHeight;
			changed = true;
		}
	}
}
