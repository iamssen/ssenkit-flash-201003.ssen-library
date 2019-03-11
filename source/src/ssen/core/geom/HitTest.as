package ssen.core.geom 
{
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.IGraphicsData;
	import flash.display.Shape;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class HitTest extends Shape 
	{
		private var _data : Vector.<IGraphicsData>;
		public function HitTest()
		{
			_data = new Vector.<IGraphicsData>(3, true);
			_data[0] = new GraphicsSolidFill(0x000000) as IGraphicsData;
			_data[2] = new GraphicsEndFill() as IGraphicsData;
		}
		public function test(path : GraphicsPath, x : int, y : int) : Boolean
		{
			_data[1] = path;
			graphics.clear();
			graphics.drawGraphicsData(_data);
			return hitTestPoint(x, y, true);
		}
	}
}
