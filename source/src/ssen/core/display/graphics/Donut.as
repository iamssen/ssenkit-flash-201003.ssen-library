package ssen.core.display.graphics 
{
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Donut extends GraphicsVectorDraw
	{
		private var _x : Number;
		private var _y : Number;
		private var _radius : Number;
		private var _innerRadius : Number;
		private var _startDeg : Number;
		private var _endDeg : Number;
		private var _path : GraphicsPath;
		public function Donut(x : Number = 50, y : Number = 50, radius : Number = 100, innerRadius : Number = 50, startDeg : Number = 0, endDeg : Number = 360, stroke : IGraphicsStroke = null, fill : IGraphicsFill = null)
		{
			_path = new GraphicsPath();
			
			_x = x;
			_y = y;
			_radius = radius;
			_innerRadius = innerRadius;
			_startDeg = startDeg;
			_endDeg = endDeg;
			
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
		public function get radius() : Number
		{
			return _radius;
		}
		public function set radius(radius : Number) : void
		{
			_radius = radius;
			changed = true;
		}
		public function get innerRadius() : Number
		{
			return _innerRadius;
		}
		public function set innerRadius(innerRadius : Number) : void
		{
			_innerRadius = innerRadius;
			changed = true;
		}
		public function get startDeg() : Number
		{
			return _startDeg;
		}
		public function set startDeg(startDeg : Number) : void
		{
			_startDeg = startDeg;
			changed = true;
		}
		public function get endDeg() : Number
		{
			return _endDeg;
		}
		public function set endDeg(endDeg : Number) : void
		{
			_endDeg = endDeg;
			changed = true;
		}
		override public function draw(graphics : Graphics) : void 
		{
			if (changed) {
				PathMaker.donut(_path, _x, _y, _radius, _innerRadius, _startDeg, _endDeg);
				changed = false;
			}
			
			GraphicsDraw.draw(graphics, _path, fill, stroke);
		}
	}
}
