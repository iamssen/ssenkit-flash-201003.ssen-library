package ssen.core.display.graphics 
{
	import ssen.core.errors.AbstractMemberError;

	import flash.display.Graphics;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsPath;
	import flash.display.IGraphicsStroke;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class GraphicsDraw 
	{
		private static var _data : Vector.<IGraphicsData>;
		public static function draw(graphics : Graphics, path : IGraphicsPath, fill : IGraphicsFill = null, stroke : IGraphicsStroke = null) : void
		{
			if (!_data) {
				_data = new Vector.<IGraphicsData>(4, true);
				_data[3] = new GraphicsEndFill() as IGraphicsData;
			}
			_data[0] = fill as IGraphicsData;
			_data[1] = stroke as IGraphicsData;
			_data[2] = path as IGraphicsData;
			graphics.drawGraphicsData(_data);
		}
		private static const NO_STROKE : GraphicsStroke = new GraphicsStroke(0);
		private var _stroke : IGraphicsStroke;
		private var _changed : Boolean;
		public function draw(graphics : Graphics) : void
		{
			throw new AbstractMemberError();
		}
		public function get stroke() : IGraphicsStroke
		{
			return _stroke;
		}
		public function set stroke(stroke : IGraphicsStroke) : void
		{
			_stroke = stroke ? stroke : NO_STROKE;
			changed = true;
		}
		protected function get changed() : Boolean
		{
			return _changed;
		}
		protected function set changed(changed : Boolean) : void
		{
			_changed = changed;
		}
	}
}
