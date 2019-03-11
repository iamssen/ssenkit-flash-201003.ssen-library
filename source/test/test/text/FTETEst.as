package test.text 
{
	import flash.geom.ColorTransform;

	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.events.RespondEvent;
	import ssen.core.utils.FormatToString;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.engine.BreakOpportunity;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.GroupElement;
	import flash.text.engine.RenderingMode;
	import flash.text.engine.TextBaseline;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FTETEst extends SSenSprite 
	{
		private var _loader : Loader;
		private static const FONT_SIZE : int = 16;
		private static const COLOR : uint = 0x555555;
		private static const LINE_WIDTH : int = 100;
		public function FTETEst()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			_loader.load(new URLRequest("NanumGothic.swf"));
		}
		private function complete(event : Event) : void 
		{
			var nanumGothic : Class = _loader.contentLoaderInfo.applicationDomain.getDefinition("ssen.library.fonts.NanumGothic") as Class;
			nanumGothic["initialize"]();
				
			start();
		}
		private function respond(event : RespondEvent) : void
		{
			if (event.success) {
			}
		}
		private function start() : void
		{
			var f : int;
			var font : Font;
			var fonts : Array = Font.enumerateFonts(false);
			for (f = 0;f < fonts.length;f++) {
				font = fonts[f];
				trace("load font", f, font, FormatToString.toString(font, "fontName", "fontStyle", "fontType"));
			}
			
			trace(FontDescription.isFontCompatible("nanumGothic CFF", FontWeight.NORMAL, FontPosture.NORMAL));
			
			create1();
			//create2();
		}
		private function create2() : void
		{
			var fd : FontDescription = new FontDescription("nanumGothic CFF", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.HORIZONTAL_STEM);
			var ef : ElementFormat = new ElementFormat(fd, FONT_SIZE, COLOR);
			ef.breakOpportunity = BreakOpportunity.AUTO;
			//ef.textRotation = TextRotation.ROTATE_90;
			var content : Vector.<ContentElement> = new Vector.<ContentElement>();
			content.push(new TextElement("아싸 아싸 아싸 아싸 아싸", ef));
			content.push(new TextElement("조쿠나조쿠나조쿠나", ef));
			content.push(new TextElement("뭐야뭐야뭐야뭐야", ef));
			content.push(new TextElement("크아크아크아크아크아", ef));
			content.push(new TextElement("붸레붸레붸레붸레붸레", ef));
			var tb : TextBlock = new TextBlock(new GroupElement(content));
			var tl : TextLine;
			var old : TextLine;
			var f : int;
			var nextY : int = 50;
			for (f = 0;f < 4;f++) {
				tl = tb.createTextLine(old, 200);
				//tl.addEventListener(MouseEvent.CLICK, lineClick);
				if (tl == null) {
					break;
				}
				tl.x = 50;
				tl.y = nextY;
				nextY += tl.height + 5;
				addChild(tl);
				old = tl;
			}
		}
		private function lineClick(event : MouseEvent) : void
		{
			var tl : TextLine = TextLine(event.target);
			var atom : int = tl.getAtomIndexAtPoint(event.stageX, event.stageY);
			var bound : Rectangle = tl.getAtomBounds(atom);
			var bitmap : Bitmap = new Bitmap(new BitmapData(bound.width, bound.height));
			bitmap.x = 100;
			bitmap.y = 100;
			bitmap.blendMode = BlendMode.MULTIPLY;
			addChild(bitmap);
			
			trace(event, atom, bound.width, bound.height, bound.left, bound.top);
		}
		private function create1() : void
		{
			var f : int;
			var line : TextLine;
			var nextX : int = 20;
			var options1 : Array;
			var options2 : Array;
			var options3 : Array;
			options1 = [TextBaseline.ASCENT, TextBaseline.DESCENT, TextBaseline.IDEOGRAPHIC_BOTTOM, TextBaseline.IDEOGRAPHIC_CENTER, TextBaseline.IDEOGRAPHIC_TOP, TextBaseline.ROMAN, TextBaseline.USE_DOMINANT_BASELINE];
			//options2 = [0, 0, 100, 0, 10, 100, 0];
			options2 = [0, 0, 0,0,0,0,0];
			options3 = [BreakOpportunity.ALL, BreakOpportunity.ANY, BreakOpportunity.AUTO, BreakOpportunity.NONE];
			var transform : ColorTransform = new ColorTransform();
			transform.color = 0x000000;
			for (f = 0;f < options1.length;f++) {
				line = createText(options1[f], options1[f], options2[f], options3[f]);
				line.y = 100;
				line.x = nextX;
				nextX = line.x + line.width + 10;
				line.transform.colorTransform = transform; 
				addChild(line);
			}
			
			//			line = createText("가나다라마바사아자차카타파");
			//			line.x = line.y = 50;
			//			addChild(line);
			graphics.beginFill(0x000000, 0);
			graphics.lineStyle(1, 0xeeeeee);
			graphics.moveTo(0, 100);
			graphics.lineTo(stage.stageWidth, 100);
			graphics.endFill();
		}
		private function createText(str : String, ...args) : TextLine
		{
			var fd : FontDescription = new FontDescription("nanumGothic CFF", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.HORIZONTAL_STEM);
			var ef : ElementFormat = new ElementFormat(fd, FONT_SIZE, COLOR);
			//ef.breakOpportunity = BreakOpportunity.NONE;
			ef.alignmentBaseline = args[0];
			//ef.dominantBaseline = TextBaseline.DESCENT;
			ef.baselineShift = args[1];
			var te : TextElement = new TextElement(str, ef);
			var tb : TextBlock = new TextBlock(te);
			return tb.createTextLine();
		}
	}
}
