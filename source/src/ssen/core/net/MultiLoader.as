package ssen.core.net 
{
	import ssen.core.display.expanse.SSenLoader;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	/**
	 * @author SSen
	 */
	public class MultiLoader extends EventDispatcher 
	{
		private var _step : int;
		private var _f : int;
		private var _length : int;
		private var _ids : Dictionary;
		private var _byteTotal : uint;
		private var _byteLoaded : uint;
		private var _lastByteLoaded : uint;
		private var _urls : Vector.<URLRequest>;
		private var _contexts : Vector.<LoaderContext>;
		private var _loaders : Vector.<SSenLoader>;

		
		public function MultiLoader()
		{
			_step = 0;
			_ids = new Dictionary(true);
			_urls = new Vector.<URLRequest>();
			_contexts = new Vector.<LoaderContext>();
			_loaders = new Vector.<SSenLoader>();
		}
		public function addLoader(id : String, url : URLRequest, context : LoaderContext = null) : void
		{
			if (_step < 1) {
				_ids[id] = _urls.length;
				_urls.push(url);
				_contexts.push(context);
			}
		}
		public function getLoader(id : String) : SSenLoader
		{
			if (_step >= 3 && _ids[id] != undefined) {
				return _loaders[_ids[id]];
			}
			return null;
		}
		public function load() : void
		{
			if (_step < 1) {
				_step = 1;
				_f = 0;
				_length = _urls.length;
				_byteLoaded = 0;
				_byteTotal = 0;
				_lastByteLoaded = 0;
				startGetByteTotal();
			}
		}
		public function close() : void
		{
			var loader : SSenLoader = _loaders[_f];
			loader.close();
			
			var f : int;
			switch (_step) {
				case 1 :
					for (f = _f;f >= 0; f--) {
						loader = _loaders[f];
						if (loader.contentLoaderInfo.hasEventListener(ProgressEvent.PROGRESS)) loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, getByteTotal);
						loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
						loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus);
					}
					break;
				case 2 :
					loader = _loaders[_f];
					loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
					loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus);
					break;
			}
		}
		private function startGetByteTotal() : void
		{
			var loader : SSenLoader = new SSenLoader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, getByteTotal, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus, false, 0, true);
			loader.load(_urls[_f], _contexts[_f]);
			_loaders[_f] = loader;
		}
		private function getByteTotal(event : ProgressEvent) : void
		{
			_byteTotal += event.bytesTotal;
			var loader : SSenLoader = event.target["loader"];
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, getByteTotal);
			loader.close();
			if (_f < _length - 1) {
				_f++;
				startGetByteTotal();
			} else {
				_step = 2;
				_f = 0;
				startLoad();
			}
		}
		private function startLoad() : void
		{
			var loader : SSenLoader = _loaders[_f];
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			loader.load(_urls[_f], _contexts[_f]);
		}
		private function httpStatus(event : HTTPStatusEvent) : void
		{
			dispatchEvent(event);
		}
		private function ioError(event : IOErrorEvent) : void
		{
			dispatchEvent(event);
		}
		private function loadComplete(event : Event) : void
		{
			var loader : SSenLoader = event.target["loader"];
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus);
			_lastByteLoaded += loader.contentLoaderInfo.bytesTotal;
			if (_f < _length - 1) {
				_f++;
				startLoad();
			} else {
				_step = 3;
				_f = 0;
				complete();
			}
		}
		private function complete() : void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function progress(event : ProgressEvent) : void
		{
			_byteLoaded = _lastByteLoaded + event.bytesLoaded;
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _byteLoaded, _byteTotal));
		}
		public function resourceKill() : void
		{
			_urls = null;
			_contexts = null;
			_loaders = null;
		}
	}
}
