package ssen.component.sliders 
{
	import gs.TweenLite;
	
	import ssen.component.base.InputUtil;
	import ssen.component.events.SlideEvent;
	import ssen.component.scroll.DirectionMode;
	import ssen.component.sliders.ISlider;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	
	import mx.effects.easing.Quadratic;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.MouseEvent;	
	/**
	 * SliderBase : 
	 * @author SSen
	 */
	public class SliderBase extends SSenSprite implements ISlider
	{
		/** easing 으로 움직이는 thumb 의 속도 */
		public var thumbMoveSpeed : Number = 0.3;
		/* *********************************************************************
		 * object
		 ********************************************************************* */
		private var _track : ISkinDisplayObject;
		private var _thumb : ISkinDisplayObject;
		/* *********************************************************************
		 * setting
		 ********************************************************************* */
		private var _isVertical : Boolean;
		private var _trackStartXY : Number;
		private var _trackEndXY : Number;
		private var _trackStep : Object;
		private var _trackSegment : BitmapData;
		private var _trackSegmentXY : int;
		private var _thumbSegmentStep : Boolean;
		private var _minValue : Number;
		private var _maxValue : Number;
		/* *********************************************************************
		 * storage
		 ********************************************************************* */
		private var _trackStepValues : Vector.<Number>;
		private var _width : Number;
		private var _height : Number;
		private var _enable : Boolean;
		private var _downStageMouseXY : Number;
		private var _downThumbXY : Number;
		private var _thumbSkinFlag : String;
		private var _trackSkinFlag : String;
		private var _isSkinDisabled : Boolean;
		private var _sec : Number;

		/* *********************************************************************
		 * setting
		 ********************************************************************* */
		/**
		 * @param track track skin object
		 * @param thumb thumb skin object
		 * @param direction thumb 이 움직일 방향
		 * @param minValue 최소값
		 * @param maxValue 최대값
		 * @param value 최초값
		 * @param paddingFront thumb 이 minValue 로 취급할 track 의 x 또는 y 지점이 될 padding
		 * @param paddingBack thumb 이 maxValue 로 취급할 track 의 x 또는 y 지점이 될 padding
		 * @param trackStep int 형이면 일정 숫자간격 별로 배치되고, Array, Vector 형이면 입력된 포인트 별로 들어간다
		 * @param trackSegment trackStep 의 skin object
		 * @param trackSegmentXY segment 가 배치될 xy 위치, direction 에 따라 틀려진다
		 * @param thumbSegmentStep trackStep 에 맞춰서만 thumb 이 움직이게 된다 
		 */
		protected function setting(track : ISkinDisplayObject, thumb : ISkinDisplayObject, direction : String, 
									minValue : Number, maxValue : Number, value : Number, 
									paddingFront : int = 0, paddingBack : int = 0,
									trackStep : Object = null, trackSegment : BitmapData = null, trackSegmentXY : int = 0, thumbSegmentStep : Boolean = false) : void
		{
			// object
			_track = track;
			_thumb = thumb;
			// ui info
			_isVertical = direction == DirectionMode.VERTICAL;
			_trackStartXY = paddingFront;
			_trackEndXY = (_isVertical) ? track.height - paddingBack : track.width - paddingBack;
			var wh : Number;
			if (_isVertical) {
				_width = track.x + track.width;
				_height = track.height;
				wh = thumb.x + thumb.width;
				if (wh > _width) _width = wh;
				wh = track.x + track.width + trackSegmentXY + trackSegment.width;
				if (trackStep != null && wh > _width) _width = wh;
			} else {
				_width = track.width;
				_height = track.y + track.height;
				wh = thumb.y + thumb.height;
				if (wh > _height) _height = wh;
				wh = track.y + track.height + trackSegmentXY + trackSegment.height;
				if (trackStep != null && wh > _height) _height = wh;
			}
			// values
			_minValue = minValue;
			_maxValue = maxValue;
			value = valueFix(value);
			// segment setting
			if (trackStep != null && trackSegment != null) {
				_trackStep = trackStep;
				_trackSegment = trackSegment;
				_trackSegmentXY = trackSegmentXY;
				_thumbSegmentStep = thumbSegmentStep;
				_trackStepValues = trackStepParse(_trackStep);
				drawSegments();
			} else {
				drawTransparent();
			}
			_thumbSkinFlag = SkinFlag.DEFAULT;
			_trackSkinFlag = SkinFlag.DEFAULT;
			skinDraw();
			
			thumbPos = valueToXY(value);
			if (_thumbSegmentStep) thumbPos = stepXY(thumbPos);
			//trace(value, valueToXY(value), thumbPos, xyToValue(valueToXY(value)));
			eventOn();
		}
		private function trackStepParse(trackStep : Object) : Vector.<Number>
		{
			var steps : Vector.<Number>;
			var isVectorNumber : Boolean = trackStep is Vector.<Number>;
			
			if (!isVectorNumber) {
				steps = new Vector.<Number>();
				var f : Number;
				if (!isNaN(Number(trackStep))) {
					for (f = _minValue;f <= _maxValue; f += Number(trackStep)) {
						steps.push(f);
					}
				} else {
					for (f = 0;f < trackStep.length; f++) {
						steps.push(trackStep[f]);
					}
				} 
			} else {
				steps = trackStep as Vector.<Number>;
			}
			
			return steps;
		}
		/* *********************************************************************
		 * public interface overriding
		 ********************************************************************* */
		public override function get width() : Number
		{
			return _width;
		}
		public override function set width(width : Number) : void
		{
			if (!_isVertical) {
				var paddingBack : int = _track.width - _trackEndXY;
				var tempValue : Number = Number(value);
				
				_width = width;
				_track.width = _width;
				_trackEndXY = _track.width - paddingBack;
				
				if (_trackStep != null) {
					drawSegments();
				} else {
					drawTransparent();
				}
				
				var xy : Number = valueToXY(valueFix(tempValue));
				if (_thumbSegmentStep) xy = stepXY(xy);
				_thumb.x = xy - (_thumb.width >> 1);
			} else {
				trace("SSEN// Slider 세로형은 width 조절이 금지됩니다.");
			}
		}
		public override function get height() : Number
		{
			return _height;
		}
		public override function set height(height : Number) : void
		{
			if(_isVertical) {
				var paddingBack : int = _track.height - _trackEndXY;
				var tempValue : Number = Number(value);
			
				_height = height;
				_track.height = _height;
				_trackEndXY = _track.height - paddingBack;
			
				if (_trackStep != null) {
					drawSegments();
				} else {
					drawTransparent();
				}
			
				var xy : Number = valueToXY(valueFix(tempValue));
				if (_thumbSegmentStep) xy = stepXY(xy);
				_thumb.y = xy - (_thumb.height >> 1);
			} else {
				trace("SSEN// Slider 가로형은 height 조절이 금지됩니다.");
			}
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function eventOn() : void
		{
			_thumb.addEventListener(MouseEvent.MOUSE_OVER, thumbMouseOver, false, 0, true);
			_thumb.addEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut, false, 0, true);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbMouseDown, false, 0, true);
			_track.addEventListener(MouseEvent.CLICK, trackClick, false, 0, true);
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
		}
		private function eventOff() : void
		{
			_thumb.removeEventListener(MouseEvent.MOUSE_OVER, thumbMouseOver);
			_thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut);
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, thumbMouseDown);
			_track.removeEventListener(MouseEvent.CLICK, trackClick);
			removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		}
		private function mouseWheel(event : MouseEvent) : void
		{
			if (_thumbSegmentStep) {
				var direction : int = (event.delta > 0) ? 1 : -1;
				var xy : Number = thumbPos;
				var f : int;
				var next : Number;
				var p : Number;
				if (direction > 0) {
					for (f = 0;f < _trackStepValues.length; f++) {
						p = valueToXY(_trackStepValues[f]);
						if (p > xy) {
							next = p;
							break;
						}
						next = _trackEndXY;
					}
				} else if (direction < 0) {
					for (f = _trackStepValues.length - 1;f >= 0; f--) {
						p = valueToXY(_trackStepValues[f]);
						if (p < xy) {
							next = p;
							break;
						}
						next = _trackStartXY; 
					}
				}
				trackOnEasing(next);
			} else {
				wheel(event.delta);
			}
		}
		private function trackClick(event : MouseEvent) : void
		{
			var xy : Number = (_isVertical) ? mouseY : mouseX;
			trackOnEasing(xy);
		}
		private function thumbMouseDown(event : MouseEvent) : void
		{
			if (_isVertical) {
				_downStageMouseXY = stage.mouseY;
				_downThumbXY = _thumb.y + (_thumb.height >> 1);
			} else {
				_downStageMouseXY = stage.mouseX;
				_downThumbXY = _thumb.x + (_thumb.width >> 1);
			}
			
			thumbDown();
			_thumb.removeEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut);
			
			stage.mouseChildren = false;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
		}
		private function mouseUp(event : MouseEvent) : void
		{
			thumbUp();
			_thumb.addEventListener(MouseEvent.MOUSE_OUT, thumbMouseOut, false, 0, true);
			
			stage.mouseChildren = true;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			if (_thumbSegmentStep) {
				trackOnEasing(thumbPos);
			} else {
				dispatchSlide(true);
			} 
		}
		private function mouseMove(event : MouseEvent) : void
		{
			var xy : Number = (_isVertical) ? _downThumbXY - (_downStageMouseXY - stage.mouseY) : _downThumbXY - (_downStageMouseXY - stage.mouseX);
			thumbPos = xy;
			dispatchSlide();
		}
		private function thumbMouseOut(event : MouseEvent) : void
		{
			thumbOut();
		}
		private function thumbMouseOver(event : MouseEvent) : void
		{
			thumbOver();
		}
		/* *********************************************************************
		 * easing
		 ********************************************************************* */
		private function trackOnEasing(xy : Number) : void
		{
			stage.mouseChildren = false;
			trackStart();
			if (_thumbSegmentStep) xy = stepXY(xy);
			xy -= (_isVertical) ? _thumb.height >> 1 : _thumb.width >> 1;
			if (_isVertical) {
				TweenLite.to(_thumb, thumbMoveSpeed, {y:xy, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			} else {
				TweenLite.to(_thumb, thumbMoveSpeed, {x:xy, ease:Quadratic.easeInOut, onUpdate:trackClickUpdate, onComplete:trackClickComplete});
			}
		}
		// easing update
		private function trackClickUpdate() : void
		{
			dispatchSlide();
		}
		// easing complete
		private function trackClickComplete() : void
		{
			trackComplete();
			stage.mouseChildren = true;
			dispatchSlide(true);
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
		 * implement ISlider
		 ********************************************************************* */
		public function wheel(delta : int) : void
		{
			if (delta == 0) return;
			
			delta <<= 1;
			var xy : Number = (_isVertical) ? _thumb.y - delta : _thumb.x - delta;
			thumbPos = xy;
			dispatchSlide(true);
		}
		public function get minValue() : Number
		{
			return _minValue;
		}
		public function get maxValue() : Number
		{
			return _maxValue;
		}
		public function minMaxValuesReset(minValue : Number, maxValue : Number, value : Number, trackStep : Object = null, thumbSegmentStep : Boolean = false) : void
		{
			_thumbSegmentStep = false;
			_minValue = minValue;
			_maxValue = maxValue;
			
			if (trackStep != null && _trackSegment != null) {
				_trackStep = trackStep;
				_thumbSegmentStep = thumbSegmentStep;
				_trackStepValues = trackStepParse(_trackStep);
				drawSegments();
			} else {
				drawTransparent();
			}
			thumbPos = valueToXY(valueFix(value));
			if (_thumbSegmentStep) thumbPos = stepXY(thumbPos);
		}
		public function get sec() : Number
		{
			return _sec;
		}
		public function set sec(sec : Number) : void
		{
			_sec = sec;
			var trackSize : Number = _trackEndXY - _trackStartXY;
			var xy : Number = (sec * trackSize) + _trackStartXY;
			trackOnEasing(xy);
		}
		/* *********************************************************************
		 * implements ISSenComponent, IInput
		 ********************************************************************* */
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			_enable = enable;
			if (enable) {
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
		public function get value() : Object
		{
			return valueFix(xyToValue(thumbPos));
		}
		public function set value(value : Object) : void
		{
			if (InputUtil.valueTypeCheck(this, value, valueType)) {
				var v : Number = Number(value);
				value = valueFix(v);
				var xy : Number = valueToXY(v);
				trackOnEasing(xy);
			}
		}
		public function get valueType() : Class
		{
			return Number;
		}
		public function resourceKill() : void
		{
			eventOff();
			_track = null;
			_thumb = null;
			_trackSegment = null;
			graphics.clear();
		}
		/* *********************************************************************
		 * Slider interface --> ISlider 에 추가?
		 ********************************************************************* */
		public function get paddingFront() : Number
		{
			return _trackStartXY;
		}
		public function get paddingBack() : Number
		{
			return _track.width - _trackEndXY;
		}
		public function get trackStartXY() : Number
		{
			return _trackStartXY;
		}
		public function get trackEndXY() : Number
		{
			return _trackEndXY;
		}
		public function get trackSize() : Number
		{
			return _trackEndXY - _trackStartXY;
		}
		public function get trackStep() : Object
		{
			return _trackStep;
		}
		public function set trackStep(trackStep : Object) : void
		{
			_trackStep = trackStep;
			_trackStepValues = trackStepParse(_trackStep);
			drawSegments();
			if (_thumbSegmentStep) trackOnEasing(thumbPos);
		}
		public function get thumbSegmentStep() : Boolean
		{
			return _thumbSegmentStep;
		}
		public function set thumbSegmentStep(thumbSegmentStep : Boolean) : void
		{
			_thumbSegmentStep = thumbSegmentStep;
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function drawSegments() : void
		{
			var w : int = _trackSegment.width;
			var h : int = _trackSegment.height;
			var f : Number;
			
			var g : Graphics = graphics;
			g.clear();
			g.beginFill(0x000000, 0);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
			g.beginBitmapFill(_trackSegment, null, true, false);
			
			var x : int;
			var y : int;
			var half : Number;
			if (_isVertical) {
				x = _track.x + _track.width + _trackSegmentXY;
				half = h >> 1;
			} else {
				y = _track.y + _track.height + _trackSegmentXY;
				half = w >> 1;
			}
			
			for (f = 0;f < _trackStepValues.length; f++) {
				if (_isVertical) {
					y = valueToXY(_trackStepValues[f]) - half;
				} else {
					x = valueToXY(_trackStepValues[f]) - half;
				}
				g.drawRect(x, y, w, h);	
			}
			g.endFill();
		}
		private function drawTransparent() : void
		{
			var g : Graphics = graphics;
			g.beginFill(0x000000, 0);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
		}
		private function stepXY(xy : Number) : Number
		{
			xy = xyFix(xy);
			var step : Number;
			var p1 : Number;
			var p2 : Number;
			var f : int;
			var size : Number = (_isVertical) ? _track.height : _track.width;
			for (f = -1;f < _trackStepValues.length;f++) {
				p1 = (f >= 0) ? valueToXY(_trackStepValues[f]) : 0;
				p2 = (f < _trackStepValues.length - 1) ? valueToXY(_trackStepValues[f + 1]) : size;
				if (xy > p1 && xy < p2) {
					step = p2 - p1;
					if (xy < p1 + (step >> 1)) {
						return p1;
					} else {
						return p2;
					}
				}
			}
			return xy;
		}
		private function valueToXY(value : Number) : Number
		{
			value = value - _minValue;
			var maxValue : Number = _maxValue - _minValue;
			var valuePercent : Number = value / maxValue;
			var trackSize : Number = _trackEndXY - _trackStartXY;
			
			return (valuePercent * trackSize) + _trackStartXY;
		}
		private function xyToValue(xy : Number) : Number
		{
			xy = xy - _trackStartXY;
			var trackSize : Number = _trackEndXY - _trackStartXY;
			var xyPercent : Number = xy / trackSize;
			var valueStandard : Number = _maxValue - _minValue;
			
			return (xyPercent * valueStandard) + _minValue;
		}
		// tnumb 의 x or y
		private function get thumbPos() : Number
		{
			if (_isVertical) {
				return _thumb.y + (_thumb.height >> 1);
			} else {
				return _thumb.x + (_thumb.width >> 1);
			}
		}
		private function set thumbPos(xy : Number) : void
		{
			xy = xyFix(xy);
			if (_isVertical) {
				_thumb.y = xy - (_thumb.height >> 1);
			} else {
				_thumb.x = xy - (_thumb.width >> 1);
			}
		}
		private function xyFix(n : Number) : Number
		{
			if (n <= _trackStartXY) {
				n = 0;
			} else if (n >= _trackEndXY) {
				n = _trackEndXY;
			}
			return n;
		}
		// sec 를 저장하고, SlideEvent 를 dispatch 시킨다
		private function dispatchSlide(valueChanged : Boolean = false) : void
		{
			var sec : Number = getSec();
			dispatchEvent(new SlideEvent(SlideEvent.SLIDE, Number(value), _minValue, _maxValue, sec));
			if (valueChanged) dispatchEvent(new SlideEvent(SlideEvent.VALUE_CHANGED, Number(value), _minValue, _maxValue, sec));
			_sec = sec;
		}
		// thumb 의 y 위치를 기준으로 sec 를 계산해서 가져온다
		private function getSec() : Number
		{
			var xy : Number = (_isVertical) ? _thumb.y + (_thumb.height >> 1) : _thumb.x + (_thumb.width >> 1);
			xy = xy - _trackStartXY;
			var trackSize : Number = _trackEndXY - _trackStartXY;
			var sec : Number = xy / trackSize;
			
			return sec;
		}
		private function valueFix(n : Number) : Number
		{
			if (_minValue > _maxValue) {
				var temp : Number = _minValue;
				_minValue = _maxValue;
				_maxValue = temp;
			}
			
			if (n <= _minValue) {
				n = _minValue;
			} else if (n >= _maxValue) { 
				n = _maxValue;
			}
			return n;
		}
	}
}
