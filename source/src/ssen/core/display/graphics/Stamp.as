package ssen.core.display.graphics 
{
	import flash.display.GraphicsStroke;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsPath;
	import flash.geom.Matrix;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Stamp
	{
		private var _bank : Vector.<BitmapData>;
		private var _fill : GraphicsBitmapFill;
		private var _mat : Matrix;
		private var _path : GraphicsPath;
		private var _stroke : GraphicsStroke;
		public function Stamp()
		{
			_bank = new Vector.<BitmapData>();
			_fill = new GraphicsBitmapFill();
			_mat = new Matrix();
			_path = new GraphicsPath();
			_stroke = new GraphicsStroke(0);
		}
		public function draw(graphics : Graphics, object : DisplayObject) : void
		{
			var bitmap : BitmapData = new BitmapData(object.width, object.height, true, 0x00ffffff);
			bitmap.draw(object);
			_bank.push(bitmap);
			_fill.bitmapData = bitmap;
			_mat.identity();
			_mat.tx = object.x;
			_mat.ty = object.y;
			_fill.matrix = _mat;
			
			PathMaker.rect(_path, object.x, object.y, object.width, object.height);
			GraphicsDraw.draw(graphics, _path, _fill, _stroke);
		}
		public function dispose() : void
		{
			var f : int = _bank.length;
			while (--f >= 0) {
				_bank[f].dispose();
				_bank[f] = null;
			}
			_bank.length = 0;
		}
	}
}
