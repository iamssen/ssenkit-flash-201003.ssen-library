package ssen.core.display.graphics 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.geom.Padding;
	import ssen.core.number.MathEx;

	import flash.display.BitmapData;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	import flash.geom.Rectangle;
	import flash.text.Font;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.TextBaseline;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class BitBLTTest extends SSenSprite 
	{

		[Embed(source="asset/profile.png")]
		public static var profileImage : Class;
		public function BitBLTTest()
		{
			draw();
		}
		private function draw() : void
		{
			new Rect(20, 20, 50, 50, randomStroke(), randomFill()).draw(graphics);
			new Rect(10, 10, 50, 50, null, randomFill()).draw(graphics);
			new Distort(100, 70, 150, 10, 100, 150, 150, 180, bitmapFill(), true).draw(graphics);
			new Donut(60, 150, 50, 20, 280, 190, null, randomFill()).draw(graphics);
			new HorizontalScale(200, 10, 180, 30, 30, checkFill()).draw(graphics);
			new VerticalScale(200, 110, 180, 30, 30, checkFill()).draw(graphics);
			new Scale(300, 110, 150, 150, 30, 30, 30, 30, checkFill()).draw(graphics);
			var image:Image = new Image(150, 300, 100, 100, bitmapFill(), false, true);
			image.draw(graphics);
			image.x = 300;
			image.draw(graphics);
			image.bitmapData.dispose();
			new RoundRect(400, 30, 50, 50, 10, 10, null, randomFill()).draw(graphics);
			var text:TextTrash = new TextTrash(new Rectangle(350, 300, 100, 30), new Padding(5, 5, 5, 5), getElementFormat(), 0x000000, "left", "middle", "hello world");
			text.draw(graphics);
			text.paddingTop = 25;
			text.text = "hello???";
			text.draw(graphics);
		}
		protected function getElementFormat() : ElementFormat
		{
			var _defaultElementFormat:ElementFormat;
			if (_defaultElementFormat) return _defaultElementFormat;
			var fonts : Array = Font.enumerateFonts(true);
			var font : String;
			if (fonts.indexOf("돋움") > -1) {
				font = "돋움";
			} else if (fonts.indexOf("Dotum") > -1) {
				font = "Dotum";
			} else {
				font = "Arial";
			}
			
			var fd : FontDescription = new FontDescription(font);
			_defaultElementFormat = new ElementFormat(fd, 12);
			_defaultElementFormat.alignmentBaseline = TextBaseline.DESCENT;
			return _defaultElementFormat;
		}
		private function randomStroke() : IGraphicsStroke
		{
			var stroke : GraphicsStroke = new GraphicsStroke(MathEx.rand(1, 10));
			stroke.fill = randomFill();
			return stroke;
		}
		private function randomFill() : IGraphicsFill 
		{
			return new GraphicsSolidFill(MathEx.rand(0x000000, 0xffffff));
		}
		private function bitmapFill() : BitmapData
		{
			return new profileImage().bitmapData;
		}
		private function checkFill() : BitmapData
		{
			var bit : BitmapData = new BitmapData(90, 90, true, 0x88cccccc);
			bit.fillRect(new Rectangle(0, 0, 30, 30), 0x88000000);
			bit.fillRect(new Rectangle(60, 0, 30, 30), 0x88000000);
			bit.fillRect(new Rectangle(30, 30, 30, 30), 0x88000000);
			bit.fillRect(new Rectangle(0, 60, 30, 30), 0x88000000);
			bit.fillRect(new Rectangle(60, 60, 30, 30), 0x88000000);
			return bit;
		}
	}
}
