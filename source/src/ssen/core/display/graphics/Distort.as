package ssen.core.display.graphics 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsTrianglePath;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Distort extends GraphicsBitmapDraw
	{
		private var _tlX : Number;
		private var _tlY : Number;
		private var _trX : Number;
		private var _trY : Number;
		private var _dlX : Number;
		private var _dlY : Number;
		private var _drX : Number;
		private var _drY : Number;
		private var _fill : GraphicsBitmapFill;
		private var _path : GraphicsTrianglePath;
		public function Distort(tlX : Number = 0, tlY : Number = 0, trX : Number = 100, trY : Number = 0, dlX : Number = 0, dlY : Number = 100, drX : Number = 100, drY : Number = 100, bitmapData : BitmapData = null, smooth : Boolean = false)
		{
			_fill = new GraphicsBitmapFill();
			_path = new GraphicsTrianglePath();
			
			_tlX = tlX;
			_tlY = tlY;
			_trX = trX;
			_trY = trY;
			_dlX = dlX;
			_dlY = dlY;
			_drX = drX;
			_drY = drY;
			this.bitmapData = bitmapData;
			this.smooth = smooth;
			
			changed = true;
		}
		/** 좌상단 위치점을 바꾼다 */
		public function tl(x : Number, y : Number) : void
		{
			_tlX = x;
			_tlY = y;
			changed = true;
		}
		/** 우상단 위치점을 바꾼다 */
		public function tr(x : Number, y : Number) : void
		{
			_trX = x;
			_trY = y;
			changed = true;
		}
		/** 좌하단 위치점을 바꾼다 */
		public function dl(x : Number, y : Number) : void
		{
			_dlX = x;
			_dlY = y;
			changed = true;
		}
		/** 우하단 위치점을 바꾼다 */
		public function dr(x : Number, y : Number) : void
		{
			_drX = x;
			_drY = y;
			changed = true;
		}
		override public function draw(graphics : Graphics) : void
		{
			if (changed) {
				_fill.bitmapData = bitmapData;
				_fill.smooth = smooth;
				_fill.repeat = false;
				
				PathMaker.distort(_path, _tlX, _tlY, _trX, _trY, _dlX, _dlY, _drX, _drY);
				
				changed = false;
			}
			GraphicsDraw.draw(graphics, _path, _fill, stroke);
		}
	}
}
