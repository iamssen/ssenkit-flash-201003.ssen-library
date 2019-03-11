package ssen.core.display.graphics 
{
	import flash.display.GraphicsSolidFill;
	import flash.display.IGraphicsFill;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class GraphicsVectorDraw extends GraphicsDraw 
	{
		private static const NO_FILL : GraphicsSolidFill = new GraphicsSolidFill(0x000000, 0);
		private var _fill : IGraphicsFill;
		public function get fill() : IGraphicsFill
		{
			return _fill;
		}
		public function set fill(fill : IGraphicsFill) : void
		{
			_fill = fill ? fill : NO_FILL;
			changed = true;
		}
	}
}
