package test.display 
{
	import flash.display.BitmapData;
	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class BeginBitmapFillAndDisposeTest extends SSenSprite 
	{
		[Embed(source="asset/gray.png")]
		public static var testImage : Class;
		public function BeginBitmapFillAndDisposeTest()
		{
			var bmd:BitmapData = new testImage().bitmapData;
			graphics.beginBitmapFill(bmd);
			graphics.drawRect(0, 0, bmd.width, bmd.height);
			graphics.endFill();
			//bmd.dispose();
		}
	}
}
