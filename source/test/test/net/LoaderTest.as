package test.net 
{
	import ssen.component.progress.SolidColorProgressGraphic;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.events.RespondEvent;
	import ssen.core.net.MultiResourceLoader;
	import ssen.core.net.ResourceLoader;
	import ssen.core.net.SSenURLLoader;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	/**
	 * @author ssen
	 */
	public class LoaderTest extends SSenSprite 
	{
		private var _url : SSenURLLoader;
		private var _progress : SolidColorProgressGraphic;
		private var _resource : ResourceLoader;
		private var _multi : MultiResourceLoader;

		
		public function LoaderTest()
		{
			_progress = new SolidColorProgressGraphic(0xaaaaaa, 0x000000, 200, 10);
			_progress.moveXY(10, 10);
			
			addChildren(_progress);
			
			_url = new SSenURLLoader();
			//_url.addProgressionNotifierTarget(_progress);
			//_url.addEventListener(RespondEvent.RESPOND, respond, false, 0, true);
			//_url.load(new URLRequest("http://ssen.name/"));
			//_resource = new SSenResourceLoader();
			//_resource.addProgressionNotifierTarget(_progress); 
			//_resource.addEventListener(RespondEvent.RESPOND, respond, false, 0, true);
			//_resource.load(new URLRequest("http://ssen.name/portfolio/contents/0711card.jpg"));
			_multi = new MultiResourceLoader();
			_multi.addLoader("a", new URLRequest("http://ssen.name/portfolio/contents/0711card.jpg"));
			_multi.addLoader("b", new URLRequest("http://ssen.name/portfolio/contents/unipicture2.jpgx"));
			_multi.addLoader("c", new URLRequest("http://ssen.name/portfolio/contents/unipicture5.jpgx"));
			_multi.addEventListener(RespondEvent.RESPOND, multiRespond, false, 0, true);
			_multi.addEventListener(ProgressEvent.PROGRESS, multiProgress, false, 0, true);
			_multi.addProgressionNotifierTarget(_progress);
			_multi.load();
		}
		private function multiProgress(event : ProgressEvent) : void
		{
			//trace("progress", event.bytesLoaded / event.bytesTotal);
		}
		private function multiRespond(event : RespondEvent) : void
		{
			trace(event, _multi.getLoader("a"), _multi.getLoader("b"), _multi.getLoader("c"));
			
			if (_multi.getLoader("b") == null) {
				_multi.addLoader("b", new URLRequest("http://ssen.name/portfolio/contents/unipicture2.jpg"));
				_multi.removeLoader("a");
				_multi.load();
			}
		}
		private function respond(event : RespondEvent) : void
		{
			trace(event);
			if (event.data is Loader) {
				var loader : Loader = Loader(event.data);
				var bitmap : Bitmap = Bitmap(loader.content);
				loader.content.x = 10;
				loader.content.y = 25;
			}
			_resource.resourceKill();
			trace(loader.content, bitmap);
			addChild(bitmap);
		}
	}
}
