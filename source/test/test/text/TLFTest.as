package test.text 
{
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.factory.TextLineFactoryBase;
	import flashx.textLayout.formats.TextLayoutFormat;

	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.events.RespondEvent;
	import ssen.core.net.ResourceLoader;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.engine.FontLookup;
	import flash.text.engine.TextLine;
	import flash.utils.getQualifiedSuperclassName;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TLFTest extends SSenSprite 
	{
		private var _tf : TextFlow;
		private var _stlf : StringTextLineFactory;
		private var _tlf : TextLayoutFormat;
		private var _loader : ResourceLoader;

		
		public function TLFTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_loader = new ResourceLoader();
			_loader.addEventListener(RespondEvent.RESPOND, respond, false, 0, true);
			_loader.load(new URLRequest("NanumGothic.swf"), new LoaderContext(false, loaderInfo.applicationDomain));
		}
		private function respond(event : RespondEvent) : void
		{
			if (event.success) {
				var nanumGothic : Class = _loader.contentLoaderInfo.applicationDomain.getDefinition("ssen.library.fonts.NanumGothic") as Class;
				nanumGothic["initialize"]();
				
				start();
			}
		}
		private function start() : void
		{
			_tf = new TextFlow();
			_tlf = new TextLayoutFormat();
			_tlf.color = 0x0000ff;
			_tlf.fontSize = 20;
			_tlf.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlf.fontFamily = "Monaco, nanumGothic CFF";
			_stlf = new StringTextLineFactory();
			_stlf["compositionBounds"] = new Rectangle(100, 100, 400, 200);
			_stlf.text = "가나다라마바사 abcdefg ABCDEFG";
			_stlf.spanFormat = _tlf;
			_stlf.createTextLines(createdTextLine);
			
			_tlf.color = 0x00ff00;
			_tlf.fontFamily = "nanumGothic CFF";
			_stlf["compositionBounds"] = new Rectangle(100, 130, 400, 200);
			_stlf.spanFormat = _tlf;
			_stlf.createTextLines(createdTextLine);
			
			trace(getQualifiedSuperclassName(_stlf), _stlf is TextLineFactoryBase);
		}
		private function createdTextLine(line : TextLine) : void
		{
			addChild(line);
		}
	}
}
