package ssen.frame 
{
	import ssen.core.display.expanse.SSenLoader;
	import ssen.core.display.expanse.SSenSprite;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class SSenFrame extends SSenSprite 
	{
		private static var _frame : SSenFrame;
		private static var _app : SSenApplication;
		private static var _panel : SSenPanel;
		public static function get frame() : SSenFrame
		{
			return _frame;
		}
		public static function get application() : SSenApplication
		{
			return _app;
		}
		public static function get panel() : SSenPanel
		{
			return _panel;
		}
		private var _appLoader : SSenLoader;
		private var _progress : Number;
		public function SSenFrame()
		{
			if (_frame) throw new Error("primary object");
			_frame = this;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initialize();
		}
		protected function initialize() : void 
		{
		}
		protected function loadApplication(url : URLRequest) : void
		{
			if (_app) throw new Error("primary object");
			_appLoader = new SSenLoader();
			_appLoader.contentLoaderInfo.addEventListener(Event.OPEN, appLoadStart);
			_appLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, appProgress);
			_appLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, appStart);
			_appLoader.load(url);
		}
		private function appLoadStart(event : Event) : void 
		{
			openProgress("app");
		}
		private function appStart(event : Event) : void 
		{
			_app = SSenApplication(_appLoader.content);
			addChild(_app);
			_panel = getPanel();
			trace("????", _panel);
			addChild(_panel);
			closeProgress();
		}
		protected function getPanel() : SSenPanel
		{
			return new SSenPanel();
		}
		private function appProgress(event : ProgressEvent) : void 
		{
			progress = _appLoader.contentLoaderInfo.bytesLoaded / _appLoader.contentLoaderInfo.bytesTotal;
		}
		public function openProgress(progressStyle : String = "default") : void
		{
			trace("start progress", progressStyle);
		}
		public function closeProgress() : void
		{
			trace("end progress");
		}
		public function get progress() : Number
		{
			return _progress;
		}
		public function set progress(progress : Number) : void
		{
			_progress = progress;
			trace(progress);
		}
	}
}
