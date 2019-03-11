package ssen.core.geom 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class GeomUtil 
	{
		/** bitmapData 에서 Padding 을 뽑아온다 */
		public static function getPaddingFromBitmapData(bitmapData : BitmapData, x : int, y : int, width : int, height : int) : Padding
		{
			var center : int = width >> 1;
			
			var l : int;
			var r : int;
			var t : int;
			var b : int;
			
			var f : int;
			var color : uint = 0xffffff;
			
			f = 0;
			while(++f <= height) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					t = f;
					break;
				}
			}
			f = height;
			while (--f >= 1) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					b = height - f - 1;
					break;
				}
			}
			f = 0;
			while(++f <= width) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					l = f;
					break;
				}
			}
			f = width;
			while (--f >= 1) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					r = width - f - 1;
					break;
				}
			}
			
			return new Padding(t, r, b, l);
		}
		/** bitmapData 에서 scale9Grid 를 뽑아온다 */
		public static function getScale9GridFromBitmapData(bitmapData : BitmapData,x : int, y : int, width : int, height : int) : Rectangle
		{
			var center : int = width >> 1;
			
			var l : int;
			var r : int;
			var t : int;
			var b : int;
			
			var f : int;
			var color : uint = 0xffffff;
			f = 0;
			while(++f <= height) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					t = f;
					break;
				}
			}
			f = height;
			while (--f >= 1) {
				if (bitmapData.getPixel(center + x, f + y) >= color) {
					b = height - f - 1;
					break;
				}
			}
			f = 0;
			while(++f <= width) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					l = f;
					break;
				}
			}
			f = width;
			while (--f >= 1) {
				if (bitmapData.getPixel(f + x, t + y) >= color) {
					r = width - f - 1;
					break;
				}
			}
			
			return new Rectangle(l, t, width - l - r, height - t - b);
		}
	}
}
