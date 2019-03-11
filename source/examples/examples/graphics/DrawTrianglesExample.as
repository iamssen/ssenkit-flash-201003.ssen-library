package examples.graphics 
{
	import examples.Example;

	import ssen.core.display.DistortShape;
	import ssen.core.number.MathEx;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * @author SSen
	 */
	public class DrawTrianglesExample extends Example 
	{
		public function DrawTrianglesExample()
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
			
			// triangle setting
			var vertices : Vector.<Number> = new Vector.<Number>();
			// top left, top right
			vertices.push(0, 0, 80, 20);
			// down left, down right
			vertices.push(0, 100, 80, 80);
			var indices : Vector.<int> = new Vector.<int>();
			// tl --> tr --> dl , tr --> dr --> dl 순서로 삼각형을 그림
			indices.push(0, 1, 2, 1, 3, 2);
			var uvData : Vector.<Number> = new Vector.<Number>();
			// vertices 와 1 : 1 매치, bitmapData.width 를 1 로 취급 100분율로 bitmapData 를 맵핑
			uvData.push(0, 0, 1, 0, 0, 1, 1, 1);
			
			// bitmapData
			var bmd : BitmapData = new BitmapData(100, 100, false, MathEx.rand(0xffffff, 0x000000));
			
			// draw
			var sp : Sprite = new Sprite();
			g = sp.graphics;
			g.beginBitmapFill(bmd, null, false, true);
			g.lineStyle(1, 0x000000);
			g.drawTriangles(vertices, indices, uvData, TriangleCulling.NONE);
			g.endFill();
			
			sp.x = 10;
			sp.y = 10;
			sp.buttonMode = true;
			
			// 개인적으로 만든 라이브러리
			var ds : DistortShape = new DistortShape(new Point(0, 0), new Point(80, 20), new Point(0, 100), new Point(80, 80), new BitmapData(100, 100, false, MathEx.rand(0xffffff, 0x000000)));
			ds.x = 10;
			ds.y = 150;
			
			addChildren(sp, ds);
			
			trace(sp.width, sp.height);
		}
	}
}
