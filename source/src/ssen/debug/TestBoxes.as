package ssen.debug 
{
	import ssen.core.number.MathEx;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;	
	/**
	 * 테스트에 사용하는 박스들을 만든다
	 * @author SSen
	 */
	public class TestBoxes 
	{
		/** 스크롤 테스트에 사용할 큰 박스를 만든다 */
		public static function getLineBox() : DisplayObject
		{
			var s : Shape = new Shape();
			var g : Graphics = s.graphics;
			var w : int = MathEx.rand(600, 4500);
			var h : int = MathEx.rand(600, 4500);
			g.beginFill(MathEx.rand(0x000000, 0xffffff));
			g.drawRect(0, 0, w, h);
			g.endFill();
			g.beginFill(0xC5D5FC);
			g.drawRect(0, 0, w, 10);
			g.drawRect(0, 10, 10, h - 20);
			g.drawRect(w - 10, 10, 10, h - 20);
			g.drawRect(0, h - 10, w, 10);
			g.endFill();
			
			return s;
		}
	}
}
