package ssen.component.displayLoaders 
{
	import gs.TweenMax;
	import gs.easing.Quad;
	import gs.events.TweenEvent;

	import ssen.component.progress.IProgressGraphic;
	import ssen.component.progress.SolidColorProgressGraphic;
	import ssen.core.display.CreateBoxes;
	import ssen.core.display.DisplayUtil;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.InvalidateStatus;
	import ssen.core.events.RespondEvent;
	import ssen.core.geom.Padding;
	import ssen.core.net.ResourceLoader;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	/**
	 * thumbnail loader 등의 기초적인 디스플레이 오브젝트 로더의 베이스
	 * @author ssen
	 */
	public class AbstDisplayLoader extends SSenSprite 
	{
		protected var _progress : IProgressGraphic;
		protected var _display : Sprite;
		private var _tween : TweenMax;
		private var _request : URLRequest;
		private var _context : LoaderContext;
		private var _loader : ResourceLoader;
		private var _width : int;
		private var _height : int;
		private var _full : Boolean;
		private var _ratio : Boolean;
		private var _content : DisplayObject;
		private var _bg : Boolean;
		private var _bgColor : uint;
		private var _bgAlpha : Number;
		private var _status : InvalidateStatus;
		private var _loading : Boolean;

		
		/**
		 * Constructor
		 * @param width 가로 사이즈
		 * @param height 세로 사이즈
		 * @param full 작은 그림을 늘려서 꽉 채울 것인지 확인
		 * @param ratio 비율을 유지할 것인지 확인
		 * @param bg 백그라운드 컬러
		 * @param bgColor 백그라운드 색상
		 * @param bgAlpha 백그라운드 알파값
		 */
		public function AbstDisplayLoader(width : int, height : int, full : Boolean = false, ratio : Boolean = true, bg : Boolean = true, bgColor : uint = 0xffffff, bgAlpha : Number = 1)
		{
			_width = width;
			_height = height;
			_full = full;
			_ratio = ratio;
			_bg = bg;
			_bgColor = bgColor;
			_bgAlpha = bgAlpha;
			
			_status = new InvalidateStatus();
			_status.width = true;
			_status.height = true;
			invalidate();
		}
		/* *********************************************************************
		 * public interface
		 ********************************************************************* */
		/**
		 * 로드를 시작함
		 */
		public function load(request : URLRequest, context : LoaderContext = null) : void
		{
			if (!_loading) {
				_loading = true;
				
				_request = request;
				_context = context;
				_status.load = true;
				invalidate();
			} else if (_status.load) {
				_request = request;
				_context = context;
			}
		}
		/**
		 * 로드를 닫음
		 */
		public function close() : void
		{
			if (_loading) {
				_loading = false;
				_status.load = false;
			}
		}
		/** 사용된 리소스들을 제거 */
		public function resourceKill() : void
		{
			close();
			if (_loader != null) _loader.resourceKill();
			if (_content != null) TweenMax.killTweensOf(_content);
		}
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			if (_width != value) {
				_width = value;
				_status.width = true;
				invalidate();
			}
		}
		/** @private */
		override public function get height() : Number
		{
			return _height;
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			if (_height != value) {
				_height = value;
				_status.height = true;
				invalidate();
			}
		}
		/* *********************************************************************
		 * display invalidating
		 ********************************************************************* */
		private function invalidate() : void
		{
			if (stage != null) {
				stage.addEventListener(Event.RENDER, render, false, 0, true);
				stage.addEventListener(Event.ENTER_FRAME, render, false, 0, true);
				stage.invalidate();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
			}
		}
		private function addedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			invalidate();
		}
		private function render(event : Event) : void
		{
			if (stage != null) {
				stage.removeEventListener(Event.RENDER, render);
				stage.removeEventListener(Event.ENTER_FRAME, render);
			}
			if (_status.invalidate) rendering();
		}
		private function rendering() : void
		{
			if (_status.width || _status.height) {
				drawBG();
				if (_content != null && contains(_content)) {
					resizeContent();					
				}
			}
			if (_status.load) {
				if (!removeContent()) loadContent();
			}
			_status.clear();
		}
		/* *********************************************************************
		 * flow
		 ********************************************************************* */
		private function removeContent() : Boolean
		{
			if (_content != null && contains(_content)) {
				_tween = TweenMax.to(_content, removeContentTransitionDuration(), removeContentTransitionStyle());
				_tween.addEventListener(TweenEvent.COMPLETE, removeContentComplete, false, 0, true);
				return true;
			}
			return false;
		}
		private function removeContentComplete(event : TweenEvent) : void
		{
			_tween.removeEventListener(TweenEvent.COMPLETE, removeContentComplete);
			_tween = null;
			removeChild(_content);
			_loader.unloadAndStop();
			_loader = null;
			
			loadContent();
		}
		private function loadContent() : void
		{
			_progress = createProgress();
			_progress.moveXY((_width >> 1) - (_progress.width >> 1), (_height >> 1) - (_progress.height >> 1));
			addChildAt(DisplayObject(_progress), 0);
			
			_loader = new ResourceLoader();
			_loader.addProgressionNotifierTarget(_progress);
			_loader.addEventListener(RespondEvent.RESPOND, respond, false, 0, true);
			_loader.load(_request, _context);
		}
		private function respond(event : RespondEvent) : void
		{
			close();
			_loader.removeEventListener(RespondEvent.RESPOND, respond);
			
			var display : DisplayObject;
			if (event.success) {
				display = DisplayObject(event.data);
			} else {
				display = createInvalidURL();
			}
			if (display is Bitmap) Bitmap(display).smoothing = true;
			_content = display;
			resizeContent();
			setLoadContentInitStyle(display);
			addChild(display);
			TweenMax.to(_content, addContentTransitionDuration(), addContnetTransitionStyle());
			_tween = TweenMax.to(_progress, addContentTransitionDuration(), {alpha:0, ease:Quad.easeOut});
			_tween.addEventListener(TweenEvent.COMPLETE, progressEnd, false, 0, true);
		}
		private function progressEnd(event : TweenEvent) : void
		{
			_tween.removeEventListener(TweenEvent.COMPLETE, progressEnd);
			removeChild(DisplayObject(_progress));
			_progress.resourceKill();
			_progress = null;
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function drawBG() : void
		{
			graphics.clear();
			if (_bg) {
				graphics.beginFill(_bgColor, _bgAlpha);
				graphics.drawRect(0, 0, _width, _height);
				graphics.endFill();
			}
		}
		private function resizeContent() : void
		{
			_content.scaleX = 1;
			_content.scaleY = 1;
			DisplayUtil.transformInStage(_content, _width, _height, _full, _ratio, displayPadding());
		}
		/* *********************************************************************
		 * abstract
		 ********************************************************************* */
		/** 여백공간 */
		protected function displayPadding() : Padding
		{
			return null;
		}
		/** 컨텐츠 사라지는 트위닝 시간 */
		protected function removeContentTransitionDuration() : Number
		{
			return .3;
		}
		/** 컨텐츠 나타나는 트위닝 시간 */
		protected function addContentTransitionDuration() : Number
		{
			return .3;
		}
		/** 컨텐츠 최초 상태 스타일 셋팅 */
		protected function setLoadContentInitStyle(content : DisplayObject) : void
		{
			content.alpha = 0;
		}
		/** 컨텐츠 나타날때 트위닝 스타일 */
		protected function addContnetTransitionStyle() : Object
		{
			return {alpha:1, ease:Quad.easeOut};
		}
		/** 컨텐츠 사라질때 트위닝 스타일 */
		protected function removeContentTransitionStyle() : Object
		{
			return {alpha:0, ease:Quad.easeOut};
		}
		/** 프로그레스 그래픽 */
		protected function createProgress() : IProgressGraphic
		{
			var progress : SolidColorProgressGraphic = new SolidColorProgressGraphic(0x000000, 0xaaaaaa, _width, 20);
			progress.y = (_height >> 1) - (progress.height >> 1);
			return progress;
		}
		/** 잘못된 URL등 에러상황에서 대체할 디스플레이 */
		protected function createInvalidURL() : DisplayObject
		{
			return CreateBoxes.createColorShapeBox(0xff0000, 50, 50);
		}
	}
}
