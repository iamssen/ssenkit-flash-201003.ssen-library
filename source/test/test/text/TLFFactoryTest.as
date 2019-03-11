package test.text 
{
	import flash.text.TextFormat;
	import flash.text.engine.ElementFormat;

	import ssen.core.number.MathEx;

	import flash.text.TextField;
	import flash.utils.getTimer;

	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;

	import ssen.core.display.expanse.SSenSprite;
	import ssen.debug.TestButtonGroup;

	import flash.geom.Rectangle;
	import flash.text.engine.TextBaseline;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TLFFactoryTest extends SSenSprite 
	{
		private var _fac : StringTextLineFactory;
		private var _lines : Vector.<TextLine>;
		private var _line : TextLine;
		public function TLFFactoryTest()
		{
			var f : int = 1000;
			var t : int = getTimer();
			var te : TextElement = new TextElement("가나다라마바사");
			var ef : ElementFormat = new ElementFormat();
			te.elementFormat = ef;
			var tb : TextBlock = new TextBlock(te);
			while (--f >= 0) {
				if (_line) removeChild(_line);
				te.text = "aaaa" + MathEx.rand(10, 1000);
				tb.content = te;
				_line = tb.createTextLine();
				addChild(_line);
			}
			_line.x = 200;
			_line.y = 100;
			trace(getTimer() - t);
			f = 1000;
			var txt : TextField = new TextField();
			addChild(txt);
			t = getTimer();
			while(--f >= 0) {
				txt.text = "aaaa" + MathEx.rand(10, 1000);
				txt.setTextFormat(new TextFormat());
				txt.width = MathEx.rand(10, 300);
				txt.height = MathEx.rand(10, 100);
			}
			txt.x = 200;
			txt.y = 200;
			trace(getTimer() - t);
			_lines = new Vector.<TextLine>();
			
			test();
		}
		private function test2() : void 
		{
		}
		private function test() : void 
		{
			var format : TextLayoutFormat = new TextLayoutFormat();
			format.alignmentBaseline = TextBaseline.DESCENT;
			format.textAlign = TextAlign.CENTER;
			format.verticalAlign = VerticalAlign.MIDDLE;
			_fac = new StringTextLineFactory();
			_fac.compositionBounds = new Rectangle(0, 0, 100, 1);
			_fac.text = "가나다라마바사아자차카타파하";
			_fac.paragraphFormat = format;
			_fac.spanFormat = format;
			_fac.textFlowFormat = format;
			_fac.createTextLines(textCreated);
			
			var tb : TestButtonGroup = new TestButtonGroup("size change", sizeChange);
			tb.moveXY(10, 100);
			addChild(tb);
		}
		private function test1() : void 
		{
			if (_line) removeChild(_line);
			var te : TextElement = new TextElement("가나다라마바사");
			var ef : ElementFormat = new ElementFormat();
			te.elementFormat = ef;
			var tb : TextBlock = new TextBlock(te);
			_line = tb.createTextLine();
			addChild(_line);
		}
		private function sizeChange() : void 
		{
			var line : TextLine;
			for each(line in _lines) {
				line.width = 300;
				line.height = 300;
			}
		}
		private function textCreated(line : TextLine) : void 
		{
			trace(line.width, line.height, line.x, line.y);
			addChild(line);
			_lines.push(line);
		}
	}
}
