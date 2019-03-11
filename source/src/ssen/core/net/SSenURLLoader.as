package ssen.core.net 
{
	import ssen.component.progress.IProgressGraphic;
	import ssen.core.events.InteractionSwitcher;
	import ssen.core.events.RespondEvent;
	import ssen.core.utils.FormatToString;

	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;

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
	 * xml 등의 text data loader
	 * @author ssen
	 */
	public class SSenURLLoader extends URLStream implements ISSenLoader
	{
		private var _charSet : String;
		private var _loading : Boolean;
		private var _progressTargets : Vector.<IProgressGraphic>;
		private var _stopingTargets : Vector.<InteractionSwitcher>;
		private var _httpStatus : int;

		
		/**
		 * xml 등의 text data loader
		 * @param charSet 리턴받을 문자셋
		 */
		public function SSenURLLoader(charSet : String = "utf-8")
		{
			_charSet = charSet;
		}
		override public function load(request : URLRequest) : void
		{
			if (!_loading) {
				super.load(request);
				_loading = true;
				
				if (_stopingTargets != null) {
					var f : int;
					for (f = 0;f < _stopingTargets.length; f++) {
						_stopingTargets[f].off();
					}
				}
				
				addEventListener(Event.COMPLETE, complete, false, 0, true);
				addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus, false, 0, true);
				addEventListener(IOErrorEvent.IO_ERROR, ioError, false, 0, true);
				if (_progressTargets != null) addEventListener(ProgressEvent.PROGRESS, progress, false, 0, true);
				addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError, false, 0, true);
			}
		}
		override public function close() : void
		{
			if (_loading) {
				super.close();
				_loading = false;
				
				if (_stopingTargets != null) {
					var f : int;
					for (f = 0;f < _stopingTargets.length; f++) {
						_stopingTargets[f].on();
					}
				}
				
				removeEventListener(Event.COMPLETE, complete);
				removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatus);
				removeEventListener(IOErrorEvent.IO_ERROR, ioError);
				if (_progressTargets != null) removeEventListener(ProgressEvent.PROGRESS, progress);
				removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			}
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function securityError(event : SecurityErrorEvent) : void
		{
			dispatchEvent(new RespondEvent(RespondEvent.RESPOND, false, null, _httpStatus, event.type, event.text));
			close();
		}
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
			dispatchEvent(new RespondEvent(RespondEvent.RESPOND, true, byteToData(readMultiByte(bytesAvailable, _charSet)), _httpStatus));
			close();
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		/** string 을 특별히 처리해야 할 일이 있을때 변형시킨다 (VO 가공 이라던지) */
		protected function byteToData(byte : String) : Object
		{
			return byte;
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
		}
	}
}
