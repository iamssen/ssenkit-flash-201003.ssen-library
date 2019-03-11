package ssen.core.display.expanse 
{
	import ssen.core.display.expanse.ISSenDisplayObject;
	import ssen.core.display.expanse.SSenDisplayObjectExpansion;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;	
	/**
	 * 확장 Bitmap
	 * @author SSen
	 */
	public class SSenBitmap extends Bitmap implements ISSenDisplayObject
	{
		private var _expansion : SSenDisplayObjectExpansion;

		
		/** 생성자 */
		public function SSenBitmap(bitmapData : BitmapData = null, pixelSnapping : String = "auto", smoothing : Boolean = false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			_expansion = new SSenDisplayObjectExpansion(this);
		}
		/* *********************************************************************
		 * implement ISSenDisplayObject
		 ********************************************************************* */
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#hover */		
		public function get hover() : Boolean
		{
			return _expansion.hover;
		}
		public function set hover(hover : Boolean) : void
		{
			_expansion.hover = hover;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#canvas */
		public function get canvas() : Sprite
		{
			return _expansion.canvas;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#globalPosition */
		public function get globalPosition() : Point
		{
			return _expansion.globalPosition;
		}
		public function set globalPosition(point : Point) : void
		{
			_expansion.globalPosition = point;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#globalX */
		public function get globalX() : Number
		{
			return _expansion.globalX;
		}
		public function set globalX(value : Number) : void
		{
			_expansion.globalX = value;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#globalY */
		public function get globalY() : Number
		{
			return _expansion.globalY;
		}
		public function set globalY(value : Number) : void
		{
			_expansion.globalY = value;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#position */
		public function get position() : Point
		{
			return _expansion.position;
		}
		public function set position(point : Point) : void
		{
			_expansion.position = point;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextX() */
		public function nextX(spaceX : int = 0) : Number
		{
			return _expansion.nextX(spaceX);
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextY() */
		public function nextY(spaceY : int = 0) : Number
		{
			return _expansion.nextY(spaceY);
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#index */
		public function get index() : int
		{
			return _expansion.index;
		}
		public function set index(index : int) : void
		{
			_expansion.index = index;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextPosition() */
		public function nextPosition(spaceX : int = 5) : Point
		{
			return _expansion.nextPosition(spaceX);
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextPositionBr() */
		public function nextPositionBr(spaceY : int = 5) : Point
		{
			return _expansion.nextPositionBr(spaceY);
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#moveXY() */
		public function moveXY(x : Number, y : Number) : void
		{
			_expansion.moveXY(x, y);
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#setSize() */
		public function setSize(width : Number, height : Number) : void
		{
			_expansion.setSize(width, height);
		}
	}
}
