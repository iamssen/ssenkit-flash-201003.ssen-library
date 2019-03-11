package ssen.core.display 
{
	import flash.display.DisplayObject;	

	import ssen.core.number.MathEx;	

	import flash.geom.Matrix;	
	import flash.geom.Point;	
	import flash.geom.Rectangle;	
	import flash.display.BitmapData;	
	/**
	 * Description
	 * @author SSen
	 */
	public class BitmapUtil 
	{
		public static function displayObjectToBitmapData(displayObject : DisplayObject, isScale1 : Boolean = true) : BitmapData
		{
			if (isScale1) {
				displayObject.scaleX = 1;
				displayObject.scaleY = 1;
			}
			var bitmapData : BitmapData = new BitmapData(displayObject.width, displayObject.height, true, 0x00000000);
			bitmapData.draw(displayObject);
			
			return bitmapData;
		}
		/**
		 * source bitmapData 의 일부 영역을 잘라서 가져온다.
		 * @param source 오리지널 bitmapData
		 * @param x 잘라낼 x 위치
		 * @param y 잘라낼 y 위치
		 * @param width 잘라낼 가로 크기
		 * @param height 잘라낼 세로 크기
		 * @param pointX 잘라낼 x 위치 추가값
		 * @param pointY 잘라낼 y 위치 추가값
		 */
		static public function getSlice(source : BitmapData, x : int, y : int, width : int, height : int, pointX : int = 0, pointY : int = 0) : BitmapData
		{	
			var rect : Rectangle = new Rectangle(x, y, width, height);
			var pt : Point = new Point(pointX, pointY);
			var bmd : BitmapData = new BitmapData(width, height);
			bmd.copyPixels(source, rect, pt);
			return bmd;
		}

		
		static public const ROTATE_180 : int = 180;
		static public const ROTATE_90 : int = 90;
		static public const ROTATE_N90 : int = -90;
		static public const FLIP_VERTICAL : int = 1;
		static public const FLIP_HORIZONTAL : int = 2;

		
		static public function flip(source : BitmapData, direction : int) : BitmapData
		{
			var bmd : BitmapData = new BitmapData(source.width, source.height, true, 0x000000);
			var mat : Matrix = new Matrix();
			switch (direction) {
				case FLIP_VERTICAL :
					mat.scale(1, -1);
					mat.translate(0, source.height);
					break;
				case FLIP_HORIZONTAL :
					mat.scale(-1, 1);
					mat.translate(source.width, 0);
					break;
			}
			bmd.draw(source, mat);
			return bmd;
		}
		static public function rotate(source : BitmapData, angle : int = 90) : BitmapData
		{
			var width : int;
			var height : int;
			var x : Number;
			var y : Number;
			
			switch (angle) {
				case ROTATE_180 :
					width = source.width;
					height = source.height;
					x = width;
					y = height;
					break;
				case ROTATE_90 :
					width = source.height;
					height = source.width;
					x = width;
					y = 0;
					break;
				case ROTATE_N90 :
					width = source.height;
					height = source.width;
					x = 0;
					y = height;
					break;
			}
			
			var bmd : BitmapData = new BitmapData(width, height, true, 0x000000);
			var mat : Matrix = new Matrix();
			mat.createBox(1, 1, MathEx.deg2rad(angle), x, y);
			bmd.draw(source, mat);
			return bmd;
		}
	}
}
