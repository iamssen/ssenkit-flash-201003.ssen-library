package ssen.core.net 
{
	import ssen.component.progress.IProgressGraphic;
	import ssen.core.array.Values;
	import ssen.core.events.InteractionSwitcher;
	import ssen.core.events.RespondEvent;
	import ssen.core.utils.FormatToString;

	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * ssen.core.events.RespondEvent.RESPOND
	 * @see ssen.core.events.RespondEvent#RESPOND 
	 */
	[Event(name="respond", type="ssen.core.events.RespondEvent")]

	/**
	 * flash.events.ProgressEvent.PROGRESS
	 * @see flash.events.ProgressEvent#PROGRESS 
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")]
	/**
	 * 다수의 ResourceLoader 를 한꺼번에 컨트롤 하고, RSL 처리를 한다
	 * @author SSen
	 */
	public class MultiResourceLoader extends EventDispatcher implements ISSenLoader
	{
		private var _f : int;
		private var _length : int;
		private var _byteTotal : uint;
		private var _byteLoaded : uint;
		private var _lastByteLoaded : uint;
		private var _loaded : Values;
		private var _cache : Values;
		private var _progressTargets : Vector.<IProgressGraphic>;
		private var _stopingTargets : Vector.<InteractionSwitcher>;
		private var _httpStatus : int;
		private var _loading : Boolean;
		private var _byteTotalLoaded : Boolean;
		private var _getByteCount : int;
		private var _errorType : String;
		private var _errorMessage : String;

		
		/* *********************************************************************
		 * public interface
		 ********************************************************************* */
		/**
		 * 로더를 추가한다
		 * @param id 로더의 키아이디
		 * @param src 로드할 리소스 url
		 * @param context 로더 컨텍스트
		 * @param rslType RSL 일 경우 타입을 기재 
		 */
		public function addLoader(id : String, src : URLRequest, context : LoaderContext = null, rslType : String = null) : Boolean
		{
			if (!_loading && (_loaded == null || _loaded[id] == undefined)) {
				if (_cache == null) {
					_cache = new Values();
				}
				var loader : ResourceLoader = new ResourceLoader();
				loader.id = id;
				loader.rslType = rslType;
				_cache[id] = {loader:loader, context:context, src:src};
				return true;
			} else {
				return false;
			}
		}
		/**
		 * Respond 가 정상적으로 도착한 이후 키아이디를 통해 로더를 가져올 수 있다
		 * @param id 로더의 키아이디
		 */
		public function getLoader(id : String) : ResourceLoader
		{
			if (_loaded[id] != undefined) {
				return _loaded[id];
			}
			return null;
		}
		/**
		 * 등록된 로더를 지운다
		 * @param id 로더의 키아이디
		 */
		public function removeLoader(id : String) : Boolean
		{
			var loader : ResourceLoader;
			if (_loaded[id] != undefined) {
				loader = _loaded[id];
				loader.unloadAndStop();
				delete _loaded[id];
				return true;
			}
			if (!_loading && _cache[id] != undefined) {
				loader = _cache[id]["loader"];
				loader.unloadAndStop();
				delete _cache[id];
				return true;
			}
			return false;
		}
		/**
		 * 등록한 로더들의 로드를 시작한다
		 */
		public function load() : void
		{
			if (!_loading) {
				_loading = true;
				_f = 0;
				_length = _cache.length;
				_byteTotalLoaded = false;
				_byteLoaded = 0;
				_byteTotal = 0;
				_lastByteLoaded = 0;
				startGetByteTotal();
			}
		}
		/** 로딩을 닫는다 */
		public function close() : void
		{
			if (_loading) {
				if (!_byteTotalLoaded) {
					closeGetByteTotal(_cache[_f]["loader"]);
				} else {
					closeLoad(_cache[_f]["loader"]);
				}
			}
		}
		/* *********************************************************************
		 * protected
		 ********************************************************************* */
		/** 리소스 처리, 특별한 처리가 필요할 경우 상속해서 사용한다 */
		protected function rsl(loader : ResourceLoader) : void
		{
			switch (loader.rslType) {
				case RSLType.CLASSES :
					break;
				case RSLType.FONT:
					break;
			}
		}
		/* *********************************************************************
		 * event and utils
		 ********************************************************************* */
		private function closeLoad(loader : ResourceLoader) : void
		{
			try {
				loader.close();
			} catch (error : Error) {
				FormatToString.ssenErrorTrace("ssen multi resource loader close load :", error);
			}
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loader.removeEventListener(RespondEvent.RESPOND, loadRespond);
		}
		private function closeGetByteTotal(loader : ResourceLoader) : void
		{
			try {
				loader.close();
			} catch (error : Error) {
				FormatToString.ssenErrorTrace("ssen multi resource loader close get byte total :", error);
			}
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, getByteTotal);
			loader.removeEventListener(RespondEvent.RESPOND, getByteRespond);
		}
		private function getByteRespond(event : RespondEvent) : void
		{
			closeGetByteTotal(_cache[_f]["loader"]);
			nextGetByteTotal();
		}
		private function startGetByteTotal() : void
		{
			_getByteCount = 0;
			var loader : ResourceLoader = _cache[_f]["loader"];
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, getByteTotal, false, 0, true);
			loader.addEventListener(RespondEvent.RESPOND, getByteRespond, false, 0, true);
			loader.load(_cache[_f]["src"], _cache[_f]["context"]);
		}
		private function nextGetByteTotal() : void
		{
			if (_f < _length - 1) {
				_f++;
				startGetByteTotal();
			} else {
				_byteTotalLoaded = true;
				_f = 0;
				startLoad();
			}
		}
		private function getByteTotal(event : ProgressEvent) : void
		{
			if (_getByteCount > 1) {
				_byteTotal += event.bytesTotal;
				closeGetByteTotal(_cache[_f]["loader"]);
				nextGetByteTotal();
			} else {
				_getByteCount++;
			}
		}
		private function startLoad() : void
		{
			var loader : ResourceLoader = _cache[_f]["loader"];
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress, false, 0, true);
			loader.addEventListener(RespondEvent.RESPOND, loadRespond, false, 0, true);
			loader.load(_cache[_f]["src"], _cache[_f]["context"]);
		}
		private function loadRespond(event : RespondEvent) : void
		{
			if (_httpStatus == 0 || event.httpStatus > 200) {
				if (_httpStatus >= 200) {
					_httpStatus = 600;
					_errorType = (_errorType != null) ? _errorType + "," + event.errorType : event.errorType;
					_errorMessage = (_errorMessage != null) ? _errorMessage + "," + event.errorMessage : event.errorMessage;
				} else {
					_httpStatus = event.httpStatus;
					_errorType = event.errorType;
					_errorMessage = event.errorMessage;
				}
			}
			
			var loader : ResourceLoader = _cache[_f]["loader"];
			closeLoad(loader);
			
			if (event.success) {
				if (_loaded == null) {
					_loaded = new Values();
				}
				
				_lastByteLoaded += loader.contentLoaderInfo.bytesTotal;
				_loaded[_cache.getNameAt(_f)] = _cache[_f]["loader"];
				rsl(_loaded[_cache.getNameAt(_f)]);
			}
			
			if (_f < _length - 1) {
				_f++;
				startLoad();
			} else {
				_loading = false;
				_f = 0;
				_cache = null;
				dispatchEvent(new RespondEvent(RespondEvent.RESPOND, true, this, _httpStatus, _errorType, _errorMessage));
				_httpStatus = 0;
				_errorType = null;
				_errorMessage = null;
			}
		}
		private function progress(event : ProgressEvent) : void
		{
			_byteLoaded = _lastByteLoaded + event.bytesLoaded;
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _byteLoaded, _byteTotal));
			if (_progressTargets != null) {
				var progress : Number = _byteLoaded / _byteTotal;
				var f : int;
				for (f = 0;f < _progressTargets.length; f++) {
					_progressTargets[f].progress = progress;
				}
			}
		}
		/* *********************************************************************
		 * implement ISSenLoader
		 ********************************************************************* */
		/** @copy ssen.core.net.ISSenLoader#addStopingEventTarget() */
		public function addStopingEventTarget(target : InteractiveObject) : void
		{
			if (_loading) {
				FormatToString.ssenErrorTrace("ssen multi resource loader add stoping event target : loading 중이라 명령이 무시됩니다.");
				return;
			}
			if (_stopingTargets == null) _stopingTargets = new Vector.<InteractionSwitcher>();
			_stopingTargets.push(new InteractionSwitcher(target));
		}
		/** @copy ssen.core.net.ISSenLoader#addProgressionNotifierTarget() */
		public function addProgressionNotifierTarget(target : IProgressGraphic) : void
		{
			if (_loading) {
				FormatToString.ssenErrorTrace("ssen multi resource loader add progression notifier target : loading 중이라 명령이 무시됩니다.");
				return;
			}
			if (_progressTargets == null) _progressTargets = new Vector.<IProgressGraphic>();
			_progressTargets.push(target);
		}
		/** @copy ssen.core.net.ISSenLoader#resourceKill() */
		public function resourceKill() : void
		{
			close();
			_cache = null;
			
			var f : int;
			var loader : ResourceLoader;
			if (_cache != null) {
				for (f = 0;f < _cache.length; f++) {
					loader = _cache[f]["loader"];
					loader.unloadAndStop();
				}
				_cache = null;
			}
			if (_loaded != null) {
				for (f = 0;f < _loaded.length; f++) {
					loader = _loaded["loader"];
					loader.unloadAndStop();
				}
				_loaded = null;
			}
			_progressTargets = null;
			_stopingTargets = null;
		}
	}
}
