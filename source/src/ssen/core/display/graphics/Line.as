package ssen.core.display.graphics 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsStroke;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Line extends GraphicsDraw 
	{
		private var _x0 : Number;
		private var _y0 : Number;
		private var _x1 : Number;
		private var _y1 : Number;
		private var _path : GraphicsPath;
		public function Line(x0 : Number = 0, y0 : Number = 0, x1 : Number = 100, y1 : Number = 0, stroke : GraphicsStroke = null)
		{
			_path = new GraphicsPath();
			
			_x0 = x0;
			_y0 = y0;
			_x1 = x1;
			_y1 = y1;
			this.stroke = stroke;
			
			changed = true;
		}
		public function get x0() : Number
		{
			return _x0;
		}
		public function set x0(x0 : Number) : void
		{
			_x0 = x0;
			changed = true;
		}
		public function get y0() : Number
		{
			return _y0;
		}
		public function set y0(y0 : Number) : void
		{
			_y0 = y0;
			changed = true;
		}
		public function get x1() : Number
		{
			return _x1;
		}
		public function set x1(x1 : Number) : void
		{
			_x1 = x1;
			changed = true;
		}
		public function get y1() : Number
		{
			return _y1;
		}
		public function set y1(y1 : Number) : void
		{
			_y1 = y1;
			changed = true;
		}
		override public function draw(graphics : Graphics) : void 
		{
			if (changed) {
				PathMaker.line(_path, x0, y0, x1, y1);
			}
			GraphicsDraw.draw(graphics, _path, null, stroke);
		}
	}
}
