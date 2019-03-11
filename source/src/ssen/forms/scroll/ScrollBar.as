package ssen.forms.scroll 
{
	import ssen.core.display.skin.InvalidateStatus;
	import ssen.core.display.skin.SkinFlag;
	import ssen.forms.base.FormSprite;
	import ssen.forms.base.ISSenFormData;

	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Quad;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.IObjectTween;

	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ScrollBar extends FormSprite implements ISSenScrollbar
	{
		// value
		private var _maxValue : Number;
		private var _minValue : Number;
		private var _totalValue : Number;
		private var _value : Number;
		// converted
		private var _view : Number;
		private var _total : Number;
		private var _now : Number;
		// view
		private var _trackSize : Number;
		private var _thumbSize : Number;
		private var _thumbPos : Number;
		private var _thumbMaxPos : Number;
		private var _thumbEnable : Boolean;
		// init
		private var _status : InvalidateStatus;
		private var _direction : Boolean;
		// event
		private var _downStagePos : Number;
		private var _downThumbPos : Number;
	
		// setting
		private var _trackMode : Boolean;
		private var _trackHide : Boolean;
		private var _tween : IObjectTween;
		private var _trackSkinFlag : String;
		private var _thumbSkinFlag : String;
		private var _thumbPosEnd : Number;
		private var _max : Number;
		public function initialize() : void
		{
			_status = new InvalidateStatus();
			_initialized = true;
		}
		public function setting(direction : String = "vertical", width : Number = 10, height : Number = 300, trackMode : String = "point", trackHide : Boolean = false) : void
		{
			_direction = direction == ScrollDirection.HORIZONTAL;
			_formWidth = width;
			_formHeight = height;
			_status["size"] = true;
			_trackMode = trackMode == ScrollTrackMode.POINT;
			_trackHide = trackHide;
			buttonMode = true;
			invalidate();
			watingEventOn();
		}
		/* *********************************************************************
		 * event 
		 ********************************************************************* */
		private function watingEventOn() : void 
		{
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		private function watingEventOff() : void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		private function scrollEventOn() : void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, scroll);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function scrollEventOff() : void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, scroll);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function mouseOut(event : MouseEvent) : void 
		{
			thumbSkinChange(SkinFlag.DEFAULT);
			trackSkinChange(SkinFlag.DEFAULT);
		}
		private function mouseDown(event : MouseEvent) : void 
		{
			var downPos : Number;
			var stagePos : Number;
			if (_direction) {
				downPos = event.localX;
				stagePos = event.stageX;
			} else {
				downPos = event.localY;
				stagePos = event.stageY;
			}
			if (calculate()) {
				watingEventOff();
				if (downPos > _thumbPos && downPos < _thumbPosEnd) {
					_downStagePos = stagePos;
					_downThumbPos = _thumbPos;
					scrollEventOn();
				} else {
					var ratio : Number;
					var max : Number = (_trackSize - _thumbSize);
					if (downPos < _thumbPos) {
						ratio = _trackMode ? (downPos - 10) / max : (_thumbPos - (_thumbSize >> 1)) / max;
					} else {
						ratio = _trackMode ? (downPos - 10) / max : (_thumbPos + (_thumbSize >> 1)) / max;
					}
					if (ratio < 0) ratio = 0;
					if (ratio > 1) ratio = 1;
					_tween = BetweenAS3.to(this, {scrollPositionRatio:ratio}, 0.3, Quad.easeOut);
					_tween.addEventListener(TweenEvent.UPDATE, tweenUpdate);
					_tween.addEventListener(TweenEvent.COMPLETE, tweenComplete);
					_tween.play();
				}
				
				thumbSkinChange(SkinFlag.ACTION);
				trackSkinChange(SkinFlag.ACTION);
			}
		}
		private function scroll(event : MouseEvent) : void 
		{
			var stagePos : Number = _direction ? event.stageX : event.stageY;
			var t : Number = stagePos - _downStagePos;
			var pos : Number = _downThumbPos + t;
			if (pos < 0) pos = 0;
			if (pos > _thumbMaxPos) pos = _thumbMaxPos;
			scrollPositionRatio = pos / _thumbMaxPos;
			dispatchEvent(new Event(Event.SCROLL));
			event.updateAfterEvent();
		}
		private function tweenComplete(event : TweenEvent) : void 
		{
			_tween.removeEventListener(TweenEvent.UPDATE, tweenUpdate);
			_tween.removeEventListener(TweenEvent.COMPLETE, tweenComplete);
			
			thumbSkinChange(SkinFlag.DEFAULT);
			trackSkinChange(SkinFlag.DEFAULT);
			
			watingEventOn();
		}
		private function tweenUpdate(event : TweenEvent) : void 
		{
			dispatchEvent(new Event(Event.SCROLL));
		}
		private function mouseUp(event : MouseEvent) : void 
		{
			scrollEventOff();
			watingEventOn();
			
			thumbSkinChange(SkinFlag.DEFAULT);
			trackSkinChange(SkinFlag.DEFAULT);
		}
		private function mouseMove(event : MouseEvent) : void 
		{
			var downPos : Number = _direction ? event.localX : event.localY;
			if (calculate()) {
				if (downPos > _thumbPos && downPos < _thumbPosEnd) {
					thumbSkinChange(SkinFlag.OVER);
					trackSkinChange(SkinFlag.DEFAULT);
				} else {
					thumbSkinChange(SkinFlag.DEFAULT);
					trackSkinChange(SkinFlag.OVER);
				}
			}
		}
		private function thumbSkinChange(flag : String) : void
		{
			if (flag != _thumbSkinFlag) {
				_thumbSkinFlag = flag;
				_status["skinFlag"] = true;
				invalidate();
			}
		}
		private function trackSkinChange(flag : String) : void
		{
			if (flag != _trackSkinFlag) {
				_trackSkinFlag = flag;
				_status["skinFlag"] = true;
				invalidate();
			}
		}
		/* *********************************************************************
		 * original properties
		 ********************************************************************* */
		override public function set formWidth(width : Number) : void
		{
			_formWidth = width;
			_status["size"] = true;
			invalidate();
		}
		override public function set formHeight(height : Number) : void
		{
			_formHeight = height;
			_status["size"] = true;
			invalidate();
		}
		/** scroll 의 방향 */
		public function get direction() : String
		{
			return _direction ? ScrollDirection.HORIZONTAL : ScrollDirection.VERTICAL;
		}
		/** (value) scroll 될 수 있는 최대값 */
		public function get maxScrollPosition() : Number
		{
			return _maxValue;
		}
		public function set maxScrollPosition(maxScrollPosition : Number) : void
		{
			_maxValue = maxScrollPosition;
			_status["container"] = true;
			invalidate();
		}
		/** (value) scroll 될 수 있는 최소값 */ 
		public function get minScrollPosition() : Number
		{
			return _minValue;
		}
		public function set minScrollPosition(minScrollPosition : Number) : void
		{
			_minValue = minScrollPosition;
			_status["container"] = true;
			invalidate();
		}
		/** (value) 내용물의 최대값 */
		public function get pageSize() : Number
		{
			return _totalValue;
		}
		public function set pageSize(pageSize : Number) : void
		{
			_totalValue = pageSize;
			_status["container"] = true;
			invalidate();
		}
		/** (value) scroll 위치 */
		public function get scrollPosition() : Number
		{
			return _value;
		}
		public function set scrollPosition(scrollPosition : Number) : void
		{
			_value = scrollPosition;
			_status["position"] = true;
			invalidate();
		}
		/* *********************************************************************
		 * expansive properties 
		 ********************************************************************* */
		/** (ratio) scroll 위치 */
		public function get scrollPositionRatio() : Number
		{
			return calculate() ? _now / _total : 0;
		}
		public function set scrollPositionRatio(ratio : Number) : void
		{
			if (ratio < 0) ratio = 0;
			if (ratio > 1) ratio = 1;
			_value = (ratio * _max) + _minValue;
			_status["position"] = true;
			invalidate();
		}
		/** (ratio) 전체 대비 컨텐츠의 비율 - 스크롤썸의 크기 비율 */
		public function get scrollSightRatio() : Number
		{
			return calculate() ? _now / _total : 0;
		}
		public function get scrollEnable() : Boolean
		{
			return false;
		}
		/* *********************************************************************
		 * calculate 
		 ********************************************************************* */
		private function calculate() : Boolean
		{
			trace("scroll bar ", _value, _maxValue, _minValue);
			if (_value > _maxValue) {
				_value = _maxValue;
				dispatchEvent(new Event(Event.SCROLL));
			} else if (_value < _minValue) {
				_value = _minValue;
				dispatchEvent(new Event(Event.SCROLL));
			}
			// converted value
			_total = _totalValue - _minValue;
			_view = _totalValue - _maxValue;
			_now = _value - _minValue;
			_max = _total - _view;
			// enable check
			_thumbEnable = _total > _view;
			if (!_thumbEnable) return false;
			// pixel
			_trackSize = _direction ? _formWidth : _formHeight;
			_thumbSize = (_view / _total) * _trackSize;
			_thumbMaxPos = _trackSize - _thumbSize;
			_thumbPos = (_now / _max) * _thumbMaxPos;
			_thumbPosEnd = _thumbPos + _thumbSize;
			return true;
		}
		/* *********************************************************************
		 * implement ISSenForm 
		 ********************************************************************* */
		override public function kill() : void
		{
			watingEventOff();
		}
		override public function deconstruction() : void
		{
			graphics.clear();
		}
		override public function set enabled(enabled : Boolean) : void
		{
			if (_enabled != enabled) {
				_enabled = enabled;
				mouseEnabled = enabled;
				_thumbSkinFlag = SkinFlag.DISABLE;
				_trackSkinFlag = SkinFlag.DISABLE;
				_status["skinFlag"] = true;
				invalidate();
			}
		}
		override public function get data() : ISSenFormData
		{
			return null;
		}
		override public function set data(data : ISSenFormData) : void
		{
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
			calculate();
			graphics.clear();
			
			if (_thumbEnable || !_trackHide) drawTrack();
			if (_thumbEnable) drawThumb();
			
			_status.clear();
		}
		/* *********************************************************************
		 * draw 
		 ********************************************************************* */
		protected function drawTrack() : void 
		{
			var color : uint;
			if (directionIsHorizontal) {
				switch (trackSkinFlag) {
					case SkinFlag.OVER :
						color = 0xadadad;
						break;
					case SkinFlag.ACTION :
						color = 0xadadad;
						break;
					case SkinFlag.DISABLE :
						color = 0xc8c8c8;
						break;
					default : 
						color = 0xb3b3b3;
						break;
				}
			} else {
				switch (trackSkinFlag) {
					case SkinFlag.OVER :
						color = 0xd1d1d1;
						break;
					case SkinFlag.ACTION :
						color = 0xd1d1d1;
						break;
					case SkinFlag.DISABLE :
						color = 0xe3e3e3;
						break;
					default : 
						color = 0xd8d8d8;
						break;
				}
			}
			
			graphics.beginFill(color);
			graphics.drawRect(0, 0, formWidth, formHeight);
			graphics.endFill();
		}
		protected function drawThumb() : void
		{
			var color : uint;
			if (directionIsHorizontal) {
				switch (thumbSkinFlag) {
					case SkinFlag.OVER :
						color = 0xd8d8d8;
						break;
					case SkinFlag.ACTION :
						color = 0xffffff;
						break;
					case SkinFlag.DISABLE :
						color = 0xbcbcbc;
						break;
					default : 
						color = 0xd8d8d8;
						break;
				}
				graphics.beginFill(color);
				graphics.drawRect(thumbPos, 3, thumbSize, height - 5);
			} else {
				switch (thumbSkinFlag) {
					case SkinFlag.OVER :
						color = 0xb3b3b3;
						break;
					case SkinFlag.ACTION :
						color = 0xffffff;
						break;
					case SkinFlag.DISABLE :
						color = 0xd3d3d3;
						break;
					default : 
						color = 0xb3b3b3;
						break;
				}
				graphics.beginFill(color);
				graphics.drawRect(3, thumbPos, formWidth - 5, thumbSize);
			}
			graphics.endFill();
		}
		protected function get thumbPos() : Number
		{
			return _thumbPos;
		}
		protected function get thumbSize() : Number
		{
			return _thumbSize;
		}
		protected function get directionIsHorizontal() : Boolean
		{
			return _direction;
		}
		public function get thumbSkinFlag() : String
		{
			return _thumbSkinFlag;
		}
		public function get trackSkinFlag() : String
		{
			return _trackSkinFlag;
		}
	}
}
