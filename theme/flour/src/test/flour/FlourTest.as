package test.flour 
{
	import ssen.core.display.SSenSprite;
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.Font;	
	/**
	 * @author SSen
	 */
	public class FlourTest extends SSenSprite 
	{
		private var load : SSenTextField;

		public function FlourTest()
		{
			var loader : Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fontLoaded);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loader.load(new URLRequest("flour_font_swc.swf"));
			
			var ts : TextStyle = new TextStyle();
			load = new SSenTextField();
			load.width = 300;
			load.height = 15;
			load.defaultTextFormat = ts;
			load.x = 10;
			load.y = 10;
			
			addChildren(load);
		}
		private function progress(event : ProgressEvent) : void
		{
			load.text = String((event.bytesLoaded / event.bytesTotal) * 100);
		}
		private function fontLoaded(event : Event) : void
		{
			var loadHeight : int = 70;
			load.x = 0;
			load.y = stage.stageHeight - loadHeight;
			load.width = stage.stageWidth;
			load.height = loadHeight;
			load.wordWrap = true;
			load.text = "log start...";
			
			var f : int;
			
			var info : LoaderInfo = event.target as LoaderInfo;
			var nanoomRegular : Class = info.applicationDomain.getDefinition("ssen.flour.fonts.NanoomGothicRegular") as Class;
			Font.registerFont(nanoomRegular);
			
			var font : Font;
			for (f = 0;f < Font.enumerateFonts().length; f++) {
				font = Font.enumerateFonts()[f];
				trace(font.fontName, "||", font.fontStyle, font.fontType);
			}
			
			initialize();
		}
		protected function initialize() : void
		{
		}
		protected function log(...logs) : void
		{
			var l : String = "";
			var f : int;
			for (f = 0;f < logs.length;f++) {
				l += " " + logs[f].toString();
			}
			load.text = l + "\n" + load.text;
			trace(l);
		}
	}
}
