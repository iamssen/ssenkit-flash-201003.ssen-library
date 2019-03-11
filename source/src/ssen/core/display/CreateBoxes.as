package ssen.core.display 
{
	import ssen.core.display.expanse.SSenShape;
	import ssen.core.display.expanse.SSenSprite;

	import flash.display.Graphics;
	import flash.geom.Rectangle;	
	/**
	 * color 박스를 간단하게 만든다
	 * @author SSen
	 */
	public class CreateBoxes 
	{
		/** 투명한 shape box 를 만든다 */
		public static function createTransparentShapeBox(width : Number = 100, height : Number = 100) : SSenShape
		{
			var shape : SSenShape = new SSenShape();
			var g : Graphics = shape.graphics;
			g.beginFill(0x000000, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			return shape;
		}
		// TODO alpha 옵션을 추가한다. alpha 를 0으로 해서 transparent 모드를 대신한다.
		/** 색깔이 있는 shape box 를 만든다 */
		public static function createColorShapeBox(color : uint = 0xffffff, width : Number = 100, height : Number = 100, donut : Rectangle = null) : SSenShape
		{
			var shape : SSenShape = new SSenShape();
			drawBox(shape.graphics, color, width, height, donut);
			return shape; 
		}
		/** box 를 그린다 */
		public static function drawBox(graphics : Graphics, color : uint, width : Number, height : Number, donut : Rectangle) : void
		{
			graphics.clear();
			graphics.beginFill(color);
			if (donut == null) {
				graphics.drawRect(0, 0, width, height);
			} else {
				var sizes : Vector.<Number> = new Vector.<Number>(6, true);
				sizes[0] = donut.x;
				sizes[1] = donut.width;
				sizes[2] = width - donut.x - donut.width;
				sizes[3] = donut.y;
				sizes[4] = donut.height;
				sizes[5] = height - donut.y - donut.height;
				graphics.drawRect(0, 0, width, sizes[3]);
				graphics.drawRect(0, sizes[3], sizes[0], sizes[4]);
				graphics.drawRect(sizes[0] + sizes[1], sizes[3], sizes[2], sizes[4]);
				graphics.drawRect(0, sizes[3] + sizes[4], width, sizes[5]);
			}
			graphics.endFill();
		}
		/** 투명한 sprite box 를 만든다 */
		public static function createTransparentSpriteBox(width : Number = 100, height : Number = 100) : SSenSprite
		{
			var sprite : SSenSprite = new SSenSprite();
			var g : Graphics = sprite.graphics;
			g.beginFill(0x000000, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			return sprite;
		}
		/** 색깔이 있는 sprite box 를 만든다 */
		public static function createColorSpriteBox(color : uint = 0xffffff, width : Number = 100, height : Number = 100, donut : Rectangle = null) : SSenSprite
		{
			var sprite : SSenSprite = new SSenSprite();
			drawBox(sprite.graphics, color, width, height, donut);
			return sprite; 
		}
	}
}
