package ssen.component.scroll 
{
	import gs.TweenLite;
	
	import ssen.component.base.InputUtil;
	import ssen.component.events.ScrollEvent;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.events.SSenEvent;
	
	import mx.effects.easing.Quadratic;
	
	import flash.events.Event;
	import flash.events.MouseEvent;	
	/**
	 * @author SSen
	 */
	public class ScrollTrackBase extends SSenSprite implements IScroller
	{
		private var _isInitialized : Boolean = false;
		/* *********************************************************************
		 * object
		 ********************************************************************* */
		private var _track : ISkinDisplayObject;
		private var _thumb : ISkinDisplayObject;
		private var _container : IScrollContainer;
		/* *********************************************************************
		 * setting
		 ********************************************************************* */
		// track 이 숨겨질 것인지를 체크
		private var _isTrackHide : Boolean;
		// 현재 위치의 0~1 값 
		private var _sec : Number = 0;
		// 방향을 설정한다
		private var _isVertical : Boolean;
		private var _trackMode : String;
		// value
		private var _minValue : Number;
		private var _maxValue : Number;
		/* *********************************************************************
		 * storage
		 ********************************************************************* */
		private var _enable : Boolean;
		// width, height
		private var _width : Number;
		private var _height : Number;
		// skin 이 disable 상태인지 확인
		private var _isSkinDisabled : Boolean = false;
		// thumb 을 누르는 순간의 Stage 의 MouseY 위치
		private var _downStageMouseXY : Number;
		// thumb 를 누르는 순간의 thumb 의 y 위치 
		private var _downThumbXY : Number;
		// thumb 이 내려가서는 안되는 x, y 위치
		private var _thumbMaxXY : Number;
		// skin file
		private var _thumbSkinFlag : String;
		private var _trackSkinFlag : String;

		
		/* *********************************************************************
		 * setting
		 ********************************************************************* */
		protected function setting(track : ISkinDisplayObject, thumb : ISkinDisplayObject, direction : String, width : Number, height : Number) : void
		{
			_track = track;
			_thumb = thumb;
			// default information
			_width = width;
			_height = height;
			
			// 기본 비활성 상태로 정렬 시킨다
			_track.width = width;
			_track.height = height;
			_thumb.x = 0;
			_thumb.y = 0;
			_isVertical = direction == DirectionMode.VERTICAL;
			if (!_isVertical) {
				_thumb.width = width >> 2;
				_thumb.height = height;
			} else {
				_thumb.width = width;
				_thumb.height = height >> 2;
			}
			
			// 기본 비활성 스킨 입히기
			_track.skinDraw(SkinFlag.DISABLE);
			_thumb.skinDraw(SkinFlag.DISABLE);
			
			_enable = false;
		}
		/* *********************************************************************
		 * implement IScroller
		 ********************************************************************* */
		public function init(container : IScrollContainer, sec : Number = 0, isTrackHide : Boolean = false, trackMode : String = "point", minValue : Number = 0, maxValue : Number = 0) : void
		{
			if (!_isInitialized) {
				_trackSkinFlag = SkinFlag.DEFAULT;
				_thumbSkinFlag = SkinFlag.DEFAULT;
				_enable = true;
			
				_container = container;
				_sec = sec;
				_isTrackHide = isTrackHide;
				_trackMode = trackMode;
				_minValue = minValue;
				_maxValue = maxValue;
			
				thumbSize(thumbWH);
				eventOn();
			
				if (_minValue == 0 && _maxValue == 0) {
					_minValue = 0;
					_maxValue = _thumbMaxXY; 
				}
				_isInitialized = true;
			}
		}
		/** @copy ssen.component.scroll.IScroller#container */
		public function get container() : IScrollContainer
		{
			return _container;
		}
		public function set container(container : IScrollContainer) : void
		{
			_container = container;
			thumbSize(thumbWH);
			thumbPos(thumbXY);
		}
		/** @copy ssen.component.scroll.IScroller#sight */
		public function get sight() : Number
		{
			return (_isVertical) ? _thumb.height / _track.height : _thumb.width / _track.width;
		}
		/** @copy ssen.component.scroll.IScroller#page() */
		public function page(delta : int) : void
		{
			if (delta == 0) return;
			
			trackStart();
			stage.mouseChildren = false;
			var speed : Number = 0.2;
			var page : int = (delta > 0) ? delta : delta * -1;
			
			if (_isVertical) {
				var oy : Number;
				if (delta < 0) {
					oy = _thumb.y - (_thumb.height * page) + (_thumb.height >> 3);
				} else {
					oy = _thumb.y + (_thumb.height * page) - (_thumb.height >> 3);
				}
				TweenLite.to(_thumb, speed, {y:oy, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			} else {
				var ox : Number;
				if (delta < 0) {
					ox = _thumb.x - (_thumb.width * page) + (_thumb.width >> 3);
				} else if (mouseX > _thumb.x + _thumb.width) {
					ox = _thumb.x + (_thumb.width * page) - (_thumb.width >> 3);
				}
				TweenLite.to(_thumb, speed, {x:ox, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			}
		}
		/* *********************************************************************
		 * implement ISlider 
		 ********************************************************************* */
		/** @copy lance.component.parts.ISlider#minValue */
		public function get minValue() : Number
		{
			return _minValue;
		}
		public function set minValue(minValue : Number) : void
		{
			_minValue = minValue;
		}
		/** @copy lance.component.parts.ISlider#maxValue */
		public function get maxValue() : Number
		{
			return _maxValue;
		}
		public function set maxValue(maxValue : Number) : void
		{
			_maxValue = maxValue;
		}
		/** @copy lance.component.parts.ISlider#sec */
		public function get sec() : Number
		{
			return _sec;
		}
		public function set sec(sec : Number) : void
		{
			_sec = sec;
			thumbPos(thumbXY);
			dispatchScroll();
		}
		/** @copy lance.component.parts.ISlider#wheel() */
		public function wheel(delta : int) : void
		{
			if (delta == 0) return;
			
			if(_thumb.visible) {
				delta <<= 1;
				var xy : Number = (_isVertical) ? _thumb.y - delta : _thumb.x - delta;
				thumbPos(xyFix(xy));
				dispatchScroll();
			}
		}
		/** @copy lance.component.parts.ISlider#move() */
		public function moveContent(pixel : int) : void
		{
			if (pixel == 0) return;
			
			if (_isVertical) {
				_container.contentY += pixel;
			} else {
				_container.contentX += pixel;
			}
		}
		/* *********************************************************************
		 * implements ISSenComponent, IInput
		 ********************************************************************* */
		/** @private */
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			_enable = enable;
			if (enable && isTallContenThanContainer) {
				mouseEnabled = true;
				mouseChildren = true;
				_isSkinDisabled = false;
				thumbOut();
				trackComplete();
			} else {
				mouseEnabled = false;
				mouseChildren = false;
				_isSkinDisabled = true;
				disableTrack();
			}
		}
		public function resourceKill() : void
		{
			eventOff();
			_thumb = null;
			_track = null;
			_container = null;
		}
		/** @copy lance.component.parts.IInput#value */
		public function get value() : Object
		{
			return ((_maxValue - _minValue) * _sec) + _minValue;
		}
		public function set value(value : Object) : void
		{
			if (InputUtil.valueTypeCheck(this, value, valueType)) {
				if (value > _maxValue) {
					value = _maxValue;
				} else if (value < _minValue) {
					value = _minValue;
				}
			
				sec = (Number(value) - _minValue) / (_maxValue - _minValue);
			}
		}
		public function get valueType() : Class
		{
			return Number;
		}
		/* *********************************************************************
		 * override public members
		 ********************************************************************* */
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			_track.width = value;
			var w : Number = (!_isVertical) ? thumbWH : value;
			if (_thumb.visible) { 
				_thumb.width = w;
			}
			thumbPos(thumbXY);
		}
		/** @private */
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			_track.height = value;
			var h : Number = (_isVertical) ? thumbWH : value;
			if (_thumb.visible) {
				_thumb.height = h;
			}
			thumbPos(thumbXY);
		}
		/* *********************************************************************
		 * Private event handlers 
		 ********************************************************************* */
		private function eventOnControl() : void
		{
			_thumb.addEventListener(MouseEvent.MOUSE_OVER, thumbMouseOver, false, 0, true);
			_thumb.addEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut, false, 0, true);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbMouseDown, false, 0, true);
			_track.addEventListener(MouseEvent.CLICK, trackClick, false, 0, true);
		}
		private function eventOffControl() : void
		{
			_thumb.removeEventListener(MouseEvent.MOUSE_OVER, thumbMouseOver);
			_thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut);
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbMouseDown);
			_track.removeEventListener(MouseEvent.CLICK, trackClick);
		}
		private function eventOn() : void
		{
			eventOnControl();
			_container.addEventListener(SSenEvent.RESIZE, containerRefresh, false, 0, true);
			_container.addEventListener(SSenEvent.ENABLE, containerEnabled, false, 0, true);
			_container.addEventListener(SSenEvent.DISABLE, containerDisabled, false, 0, true);
			_container.addEventListener(ScrollEvent.CONTENT_CHANGE, containerRefresh, false, 0, true);
			_container.addEventListener(ScrollEvent.CONTENT_DELETED, containerRefresh, false, 0, true);
			_container.addEventListener(ScrollEvent.SCROLL, containerScroll, false, 0, true);
		}
		private function eventOff() : void
		{
			eventOffControl();
			_container.removeEventListener(SSenEvent.RESIZE, containerRefresh);
			_container.removeEventListener(SSenEvent.ENABLE, containerEnabled);
			_container.removeEventListener(SSenEvent.DISABLE, containerDisabled);
			_container.removeEventListener(ScrollEvent.CONTENT_CHANGE, containerRefresh);
			_container.removeEventListener(ScrollEvent.CONTENT_DELETED, containerRefresh);
			_container.removeEventListener(ScrollEvent.SCROLL, containerScroll);
		}
		// container 가 스크롤될때
		private function containerScroll(event : ScrollEvent) : void
		{
			sec = (_isVertical) ? event.secY : event.secX;
		}
		// 컨테이너가 비활성 될때
		private function containerDisabled(event : SSenEvent) : void
		{
			enable = false;
		}
		// 컨테이너가 활성 될때
		private function containerEnabled(event : SSenEvent) : void
		{
			enable = true;
		}
		// 컨테이너가 모양적으로 변화가 있을때
		private function containerRefresh(event : Event) : void
		{
			thumbSize(thumbWH);
			thumbPos(thumbXY);
		}
		// mouse down event handler
		private function thumbMouseDown(event : MouseEvent) : void
		{
			if (_isVertical) {
				_downStageMouseXY = stage.mouseY;
				_downThumbXY = _thumb.y;
			} else {
				_downStageMouseXY = stage.mouseX;
				_downThumbXY = _thumb.x;
			}
			
			thumbDown();
			
			_thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut);
			
			stage.mouseChildren = false;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
		}
		// mouse out event handler
		private function thumbMouseOut(event : MouseEvent) : void
		{
			thumbOut();
		}
		// mouse over event handler
		private function thumbMouseOver(event : MouseEvent) : void
		{
			thumbOver();
		}
		// stage 의 mouse down event handler
		private function mouseUp(event : MouseEvent) : void
		{
			thumbUp();
			
			_thumb.addEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut, false, 0, true);
			
			stage.mouseChildren = true;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		// stage 의 mouse move event handler
		private function mouseMove(event : MouseEvent) : void
		{
			var xy : Number = (_isVertical) ? _downThumbXY - (_downStageMouseXY - stage.mouseY) : _downThumbXY - (_downStageMouseXY - stage.mouseX);
			thumbPos(xyFix(xy));
			dispatchScroll();
		}
		// track 을 클릭했을때 움직임
		private function trackClick(event : MouseEvent) : void
		{
			trackStart();
			stage.mouseChildren = false;
			
			var speed : Number;
			
			if (_isVertical) {
				var oy : Number;
				switch (_trackMode) {
					case TrackMode.POINT :
						speed = 0.4; 
						oy = mouseY - (_thumb.height >> 1);
						break;
					case TrackMode.PAGE :
						speed = 0.2;
						if (mouseY < _thumb.y) {
							oy = _thumb.y - _thumb.height + (_thumb.height >> 3);
						} else if (mouseY > _thumb.y + _thumb.height) {
							oy = _thumb.y + _thumb.height - (_thumb.height >> 3);
						}
				}
				TweenLite.to(_thumb, speed, {y:oy, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			} else {
				var ox : Number;
				switch (_trackMode) {
					case TrackMode.POINT :
						speed = 0.4; 
						ox = mouseX - (_thumb.width >> 1);
						break;
					case TrackMode.PAGE :
						speed = 0.2;
						if (mouseX < _thumb.x) {
							ox = _thumb.x - _thumb.width + (_thumb.width >> 3);
						} else if (mouseX > _thumb.x + _thumb.width) {
							ox = _thumb.x + _thumb.width - (_thumb.width >> 3);
						}
				}
				TweenLite.to(_thumb, speed, {x:ox, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			}
		}
		// easing update
		private function trackClickUpdate() : void
		{
			var xy : Number = (_isVertical) ? _thumb.y : _thumb.x;
			thumbPos(xyFix(xy));
			dispatchScroll();
		}
		// easing complete
		private function trackClickComplete() : void
		{
			trackComplete();
			
			stage.mouseChildren = true;
			dispatchScroll();
		}
		/* *********************************************************************
		 * Skinning Methods
		 ********************************************************************* */
		// thumb 의 MouseOut 시점에 호출됨
		private function thumbOut() : void
		{
			_thumbSkinFlag = SkinFlag.DEFAULT;
			skinDraw();
		}
		// thumb 의 MouseOver 시점에 호출됨
		private function thumbOver() : void
		{
			_thumbSkinFlag = SkinFlag.OVER;
			skinDraw();
		}
		// thumb 의 MouseDown 시점에 호출됨
		private function thumbDown() : void
		{
			_thumbSkinFlag = SkinFlag.ACTION;
			_trackSkinFlag = SkinFlag.ACTION;
			skinDraw();
		}
		// thumb 의 MouseUp 시점에 호출됨
		private function thumbUp() : void
		{
			_thumbSkinFlag = SkinFlag.DEFAULT;
			_trackSkinFlag = SkinFlag.DEFAULT;
			skinDraw();
		}
		// track 의 EasingStart 시점에 호출됨
		private function trackStart() : void
		{
			_trackSkinFlag = SkinFlag.ACTION;
			skinDraw();
		}
		// track 의 EasingComplete 시점에 호출됨
		private function trackComplete() : void
		{
			_trackSkinFlag = SkinFlag.DEFAULT;
			skinDraw();
		}
		// disable 시의 스키닝
		private function disableTrack() : void
		{	
			_thumbSkinFlag = SkinFlag.DISABLE;
			_trackSkinFlag = SkinFlag.DISABLE;
			skinDraw();
		}
		// 스킨을 입힌다
		private function skinDraw() : void
		{
			var thumbMode : String = (_isSkinDisabled) ? SkinFlag.DISABLE : _thumbSkinFlag;
			var trackMode : String = (_isSkinDisabled) ? SkinFlag.DISABLE : _trackSkinFlag;
			_thumb.skinDraw(thumbMode);
			_track.skinDraw(trackMode);
		}
		/* *********************************************************************
		 * Private Util functions
		 ********************************************************************* */
		// thumb 의 높이를 계산해서 반환한다
		private function get thumbWH() : Number
		{
			var showHide : Boolean = showHideThumb();
			var wh : int;
			if (showHide) { 
				if (_isVertical) {
					wh = (_container.containerHeight / _container.contentHeight) * _height;
					wh = (wh < 5) ? 5 : wh;
					_thumbMaxXY = _height - wh;
				} else {
					wh = (_container.containerWidth / _container.contentWidth) * _width;
					wh = (wh < 5) ? 5 : wh;
					_thumbMaxXY = _width - wh;
				}
			} else {
				wh = 0;
			}
			return wh;
		}
		// thumb 의 y 위치를 계산해서 반환한다
		private function get thumbXY() : Number
		{
			return (_isVertical) ? (_track.height - _thumb.height) * _sec : (_track.width - _thumb.width) * _sec;
		}
		// thumb 의 y 위치를 기준으로 sec 를 계산해서 가져온다
		private function getSec() : Number
		{
			var sec : Number = (_isVertical) ? _thumb.y / (_track.height - _thumb.height) : _thumb.x / (_track.width - _thumb.width);
			if (sec <= 0) {
				sec = 0; 
			} else if (sec >= 1) {
				sec = 1;
			}
			return sec;
		}
		// thumb 의 show, hide 처리를 하고, dispatch 시킨다.
		private function showHideThumb() : Boolean
		{
			var bool : Boolean;
			if (isTallContenThanContainer && _container.content != null) {
				if (!_thumb.visible) {
					dispatchEvent(new ScrollEvent(ScrollEvent.THUMB_SHOW)); 
				}
				_thumb.visible = true;
				eventOnControl();
				if (enable) {
					_isSkinDisabled = false;
					thumbOut();
					trackComplete();
				} else {
					disableTrack();
				}
				bool = true;
			} else {
				if (_thumb.visible) { 
					dispatchEvent(new ScrollEvent(ScrollEvent.THUMB_HIDE));
				}
				_thumb.visible = false;
				eventOffControl();
				disableTrack();
				_isSkinDisabled = true;
				bool = false;
			}
			return bool;
		}
		public function get scrollEnable() : Boolean
		{
			return _thumb.visible;
		}
		// container 보다 content 가 더 큰지... 스크롤이 필요없는지 확인한다.
		private function get isTallContenThanContainer() : Boolean
		{
			var bool : Boolean;
			if (_isVertical) {
				bool = _container.containerHeight < _container.contentHeight;
			} else {
				bool = _container.containerWidth < _container.contentWidth;
			}
			return bool;
		}
		// y 위치를 설정값 내부에서 고정시킨다
		private function xyFix(n : Number) : Number
		{
			if (n <= 0) {
				n = 0;
			} else if (n >= _thumbMaxXY) {
				n = _thumbMaxXY;
			}
			return n;
		}
		// sec 를 저장하고, ScrollEvent 를 dispatch 시킨다
		private function dispatchScroll() : void
		{
			var sec : Number = getSec();
			if (_isVertical) {
				_container.secY = sec;
				dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, 0, sec));
			} else {
				_container.secX = sec;
				dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, sec));
			}
			 
			_sec = sec;
		}
		// thumb 의 width or height 
		private function thumbSize(value : Number) : void
		{
			if (value > 0) {
				if (_isVertical) {
					_thumb.height = value;
				} else {
					_thumb.width = value;
				}
			}
		}
		// thumb 의 x or y
		private function thumbPos(value : Number) : void
		{
			if (_isVertical) {
				_thumb.y = value;
			} else {
				_thumb.x = value;
			}
		}
	}
}
