package examples.graphics 
{
	import examples.Example;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;	
	/**
	 * BitmapData.draw 에 사용할 matrix 설정
	 * @author SSen
	 */
	public class DrawMatrixExample extends Example 
	{
		public function DrawMatrixExample()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage); 
		}
		private function addedToStage(event : Event) : void
		{
			// 바탕색을 깔아주는 것일뿐...
			var g : Graphics = graphics;
			g.beginFill(0xaaaaaa);
			g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			g.endFill();
			
			// sample original bitmap data 를 만듬
			var origin : BitmapData = new BitmapData(30, 30, false, 0xffffffff);
			var gray : BitmapData = new BitmapData(10, 10, true, 0xffcccccc);
			var mat : Matrix = new Matrix();
			mat.tx = 10;
			origin.draw(gray, mat);
			mat.tx = 0;
			mat.ty = 10;
			origin.draw(gray, mat);
			mat.tx = 20;
			origin.draw(gray, mat);
			mat.tx = 10;
			mat.ty = 20;
			origin.draw(gray, mat);
			
			// draw 의 대상이 될 bitmapData 를 만듬
			var canvas : BitmapData = new BitmapData(30, 100, false, 0x00ffff);
			// original 에서 카피할 bitmapData 의 영역 지정
			var or : Rectangle = new Rectangle(0, 0, 30, 20);
			// canvas 에 draw 시킬 영역 지정
			var tr : Rectangle = new Rectangle(0, 0, 30, 50);
			// matrix 를 만들어줌 (걍 공식대로 사용할 것)
			mat.identity();
			mat.a = tr.width / or.width;
			mat.d = tr.height / or.height;
			mat.tx = tr.x - or.x * mat.a;
			mat.ty = tr.y - or.y * mat.b;
			// canvas 에 draw 시킨다
			canvas.draw(origin, mat, null, null, tr);
			
			
			var bitmap1 : Bitmap = new Bitmap(origin);
			bitmap1.x = 10;
			bitmap1.y = 10;
			
			var bitmap2 : Bitmap = new Bitmap(canvas);
			bitmap2.x = 50;
			bitmap2.y = 10;
			
			addChildren(bitmap1, bitmap2);
		}
	}
}
