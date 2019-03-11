package ssen.core.display 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;	
	/**
	 * 9Slice, 3Slice 타입의 bitmapData 를 그려준다.
	 * @author SSen
	 */
	public class SliceBitmapDraw 
	{
		/**
		 * bitmapData 를 scale9Grid 에 맞춰서 리사이징한 후에 반환한다 
		 * @param source 오리지널 BitmapData
		 * @param scale9Grid Scale9Grid
		 * @param canvasWidth 최종 결과물의 width
		 * @param canvasHeight 최종 결과물의 height
		 * @param smoothing 부드럽게 하기 옵션
		 * 
		 * @author http://www.bytearray.org/?p=118 from ScaleBitmap 1.2.2
		 */
		static public function draw9Slice(source : BitmapData, scale9Grid : Rectangle, canvasWidth : int, canvasHeight : int, smoothing : Boolean = false) : BitmapData
		{
			var minWidth : int = source.width - scale9Grid.width;
			var minHeight : int = source.height - scale9Grid.height;
			var isMinWidth : Boolean = canvasWidth <= minWidth;
			var isMinHeight : Boolean = canvasHeight <= minHeight;
			var width : int = (!isMinWidth) ? canvasWidth : minWidth;
			var height : int = (!isMinHeight) ? canvasHeight : minHeight;
			var canvas : BitmapData = new BitmapData(width, height, true, 0x000000);
			
			var rows : Array = [0, scale9Grid.top, scale9Grid.bottom, source.height];
			var cols : Array = [0, scale9Grid.left, scale9Grid.right, source.width];
			
			var dRows : Array = [0, scale9Grid.top, height - (source.height - scale9Grid.bottom), height];
			var dCols : Array = [0, scale9Grid.left, width - (source.width - scale9Grid.right), width];

			var origin : Rectangle;
			var draw : Rectangle;
			var mat : Matrix = new Matrix();
			
			for (var cx : int = 0;cx < 3; cx++) {
				for (var cy : int = 0 ;cy < 3; cy++) {
					origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
					draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
					mat.identity();
					mat.a = draw.width / origin.width;
					mat.d = draw.height / origin.height;
					mat.tx = draw.x - origin.x * mat.a;
					mat.ty = draw.y - origin.y * mat.d;
					canvas.draw(source, mat, null, null, draw, smoothing);
				}
			}
			
			if (isMinWidth || isMinHeight) {
				var resized : BitmapData = new BitmapData(canvasWidth, canvasHeight, true, 0x000000);
				mat.identity();
				mat.a = resized.width / width;
				mat.d = resized.height / height;
				resized.draw(canvas, mat, null, null, null, true);
				
				return resized;
			} else {
				return canvas;
			}
		}
		/**
		 * bitmapData 를 scale9Grid 에 맞춰서 (가로만) 리사이징한 후에 반환한다 
		 * @param source 오리지널 BitmapData
		 * @param scale9Grid Scale9Grid (x, width 만 적용된다)
		 * @param canvasWidth 최종 결과물의 width
		 * @param smoothing 부드럽게 하기 옵션
		 * 
		 * @author http://www.bytearray.org/?p=118 from ScaleBitmap 1.2.2
		 */
		static public function draw3SliceHorizontal(source : BitmapData, scale9Grid : Rectangle, canvasWidth : int, smoothing : Boolean = false) : BitmapData
		{
			var minWidth : int = source.width - scale9Grid.width;
			var isMinWidth : Boolean = canvasWidth <= minWidth;
			var width : int = (!isMinWidth) ? canvasWidth : minWidth;
			var height : int = source.height;
			var canvas : BitmapData = new BitmapData(width, height, true, 0x000000);
			
			var cols : Array = [0, scale9Grid.left, scale9Grid.right, source.width];
			
			var dCols : Array = [0, scale9Grid.left, width - (source.width - scale9Grid.right), width];

			var origin : Rectangle;
			var draw : Rectangle;
			var mat : Matrix = new Matrix();
			
			for (var cx : int = 0;cx < 3; cx++) {
				origin = new Rectangle(cols[cx], 0, cols[cx + 1] - cols[cx], height);
				draw = new Rectangle(dCols[cx], 0, dCols[cx + 1] - dCols[cx], height);
				mat.identity();
				mat.a = draw.width / origin.width;
				mat.d = draw.height / origin.height;
				mat.tx = draw.x - origin.x * mat.a;
				mat.ty = draw.y - origin.y * mat.d;
				canvas.draw(source, mat, null, null, draw, smoothing);
			}
			
			if (isMinWidth) {
				var resized : BitmapData = new BitmapData(canvasWidth, height, true, 0x000000);
				mat.identity();
				mat.a = resized.width / width;
				mat.d = resized.height / height;
				resized.draw(canvas, mat, null, null, null, true);
				
				return resized;
			} else {
				return canvas;
			}
		}
		/**
		 * bitmapData 를 scale9Grid 에 맞춰서 (세로만) 리사이징한 후에 반환한다 
		 * @param source 오리지널 BitmapData
		 * @param scale9Grid Scale9Grid (y, height 만 적용된다)
		 * @param canvasHeight 최종 결과물의 height
		 * @param smoothing 부드럽게 하기 옵션
		 * 
		 * @author http://www.bytearray.org/?p=118 from ScaleBitmap 1.2.2
		 */
		static public function draw3SliceVertical(source : BitmapData, scale9Grid : Rectangle, canvasHeight : int, smoothing : Boolean = false) : BitmapData
		{
			var minHeight : int = source.height - scale9Grid.height;
			var isMinHeight : Boolean = canvasHeight <= minHeight;
			var width : int = source.width;
			var height : int = (!isMinHeight) ? canvasHeight : minHeight;
			var canvas : BitmapData = new BitmapData(width, height, true, 0x000000);
			
			var rows : Array = [0, scale9Grid.top, scale9Grid.bottom, source.height];
			
			var dRows : Array = [0, scale9Grid.top, height - (source.height - scale9Grid.bottom), height];

			var origin : Rectangle;
			var draw : Rectangle;
			var mat : Matrix = new Matrix();
			
			for (var cy : int = 0 ;cy < 3; cy++) {
				origin = new Rectangle(0, rows[cy], width, rows[cy + 1] - rows[cy]);
				draw = new Rectangle(0, dRows[cy], width, dRows[cy + 1] - dRows[cy]);
				mat.identity();
				mat.a = draw.width / origin.width;
				mat.d = draw.height / origin.height;
				mat.tx = draw.x - origin.x * mat.a;
				mat.ty = draw.y - origin.y * mat.d;
				canvas.draw(source, mat, null, null, draw, smoothing);
			}
			
			if (isMinHeight) {
				var resized : BitmapData = new BitmapData(width, canvasHeight, true, 0x000000);
				mat.identity();
				mat.a = resized.width / width;
				mat.d = resized.height / height;
				resized.draw(canvas, mat, null, null, null, true);
				
				return resized;
			} else {
				return canvas;
			}
		}
	}
}
