package ssen.core.net 
{
	import ssen.component.progress.IProgressGraphic;
	import ssen.core.events.InteractionSwitcher;
	import ssen.core.events.RespondEvent;
	import ssen.core.utils.FormatToString;

	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
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
	 * @author ssen
	 */
	public class ResourceLoader extends Loader implements ISSenLoader 
	{
		private var _loading : Boolean;
		private var _progressTargets : Vector.<IProgressGraphic>;
		private var _stopingTargets : Vector.<InteractionSwitcher>;
		private var _httpStatus : int;
		private var _id : String;
		private var _type : String;

		
		override public function load(request : URLRequest, context : LoaderContext = null) : void
		{
			if (!_loading) {
				super.load(request, context);
				_loading = true;
				
				if (_stopingTargets != null) {
					var f : int;
					for (f = 0;f < _stopingTargets.length; f++) {
						_stopingTargets[f].off();
					}
				}
				
				contentLoaderInfo.addEventListener(Event.COMPLETE, complete, false, 0, true);
				contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus, false, 0, true);
				contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError, false, 0, true);
				if (_progressTargets != null) contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress, false, 0, true);
			}
		}
		override public function close() : void
		{
			if (_loading) {
				_loading = false;
				
				if (_stopingTargets != null) {
					var f : int;
					for (f = 0;f < _stopingTargets.length; f++) {
						_stopingTargets[f].on();
					}
				}
				
				contentLoaderInfo.removeEventListener(Event.COMPLETE, complete);
				contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus);
				contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
				if (_progressTargets != null) contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			}
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function progress(event : ProgressEvent) : void
		{
			var progress : Number = event.bytesLoaded / event.bytesTotal;
			var f : int;
			for (f = 0;f < _progressTargets.length; f++) {
				_progressTargets[f].progress = progress;
			}
		}
		private function ioError(event : IOErrorEvent) : void
		{
			dispatchEvent(new RespondEvent(RespondEvent.RESPOND, false, null, _httpStatus, event.type, event.text));
			close();
		}
		private function httpStatus(event : HTTPStatusEvent) : void
		{
			_httpStatus = event.status;
		}
		private function complete(event : Event) : void
		{
			dispatchEvent(new RespondEvent(RespondEvent.RESPOND, true, this, _httpStatus));
			close();
		}
		/* *********************************************************************
		 * implement ISSenLoader
		 ********************************************************************* */
		/** @copy ssen.core.net.ISSenLoader#addStopingEventTarget() */
		public function addStopingEventTarget(target : InteractiveObject) : void
		{
			if (_loading) {
				FormatToString.ssenErrorTrace("ssen url loader add stoping event target : loading 중이라 명령이 무시됩니다.");
				return;
			}
			if (_stopingTargets == null) _stopingTargets = new Vector.<InteractionSwitcher>();
			_stopingTargets.push(new InteractionSwitcher(target));
		}
		/** @copy ssen.core.net.ISSenLoader#addProgressionNotifierTarget() */
		public function addProgressionNotifierTarget(target : IProgressGraphic) : void
		{
			if (_loading) {
				FormatToString.ssenErrorTrace("ssen url loader add progression notifier target : loading 중이라 명령이 무시됩니다.");
				return;
			}
			if (_progressTargets == null) _progressTargets = new Vector.<IProgressGraphic>();
			_progressTargets.push(target);
		}
		/** @copy ssen.core.net.ISSenLoader#resourceKill() */
		public function resourceKill() : void
		{
			close();
			_progressTargets = null;
			_stopingTargets = null;
			unloadAndStop();
		}
		public function get id() : String
		{
			return _id;
		}
		public function set id(id : String) : void
		{
			_id = id;
		}
		public function get rslType() : String
		{
			return _type;
		}
		public function set rslType(type : String) : void
		{
			_type = type;
		}
	}
}
