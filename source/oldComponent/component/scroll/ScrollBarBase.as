package ssen.component.scroll 
{
	import ssen.component.buttons.IButton;
	import ssen.component.events.ScrollEvent;
	import ssen.core.display.expanse.SSenSprite;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;	
	/**
	 * @author SSen
	 */
	public class ScrollBarBase extends SSenSprite implements IScroller
	{
		private var _isVertical : Boolean;
		private var _isInitialized : Boolean;
		private var _moveSpeed : Number;
		/* *********************************************************************
		 * object
		 ********************************************************************* */
		private var _track : IScroller;
		private var _buttonsUpPosition : ScrollBarButtonGroup;
		private var _buttonsDownPosition : ScrollBarButtonGroup;
		/* *********************************************************************
		 * storage
		 ********************************************************************* */
		private var _width : Number;
		private var _height : Number;
		private var _move : IButton;
		private var _enable : Boolean;
		private var _isUp : Boolean;
		private var _timer : Timer;

		
		/* *********************************************************************
		 * setting
		 ********************************************************************* */
		protected function setting(track : IScroller, buttonGroupUpPosition : ScrollBarButtonGroup, buttonGroupDownPosition : ScrollBarButtonGroup, direction : String, width : Number, height : Number, moveSpeed : Number = 10) : void
		{
			_track = track;
			_buttonsUpPosition = buttonGroupUpPosition;
			_buttonsDownPosition = buttonGroupDownPosition;
			_isVertical = direction == DirectionMode.VERTICAL;
			_moveSpeed = moveSpeed;
			_width = width;
			_height = height;
			_enable = true;
		}
		/* *********************************************************************
		 * override public members
		 ********************************************************************* */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			align();
		}
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			align();
		}
		protected function align() : void
		{
			if (_isVertical) {
				_buttonsUpPosition.y = 0;
				_track.height = _height - _buttonsUpPosition.height - _buttonsDownPosition.height;
				_track.y = _buttonsUpPosition.nextY();
				_buttonsDownPosition.y = _track.nextY();
			} else {
				_buttonsUpPosition.x = 0;
				_track.width = _width - _buttonsUpPosition.width - _buttonsDownPosition.width;
				_track.x = _buttonsUpPosition.nextX();
				_buttonsDownPosition.x = _track.nextX();
			}
		}
		/* *********************************************************************
		 * implement IScroller
		 ********************************************************************* */
		public function init(container : IScrollContainer, sec : Number = 0, isTrackHide : Boolean = false, trackMode : String = "point", minValue : Number = 0, maxValue : Number = 0) : void
		{
			if (!_isInitialized) {
				_track.init(container, sec, isTrackHide, trackMode, minValue, maxValue);
				eventOn();
				align();
				thumbShowHide();
			}
		}
		public function page(delta : int) : void
		{
			_track.page(delta);
		}
		public function wheel(delta : int) : void
		{
			_track.wheel(delta);
		}
		public function moveContent(pixel : int) : void
		{
			_track.moveContent(pixel);
		}
		public function get container() : IScrollContainer
		{
			return _track.container;
		}
		public function set container(container : IScrollContainer) : void
		{
			_track.container = container;
		}
		public function get sight() : Number
		{
			return _track.sight;
		}
		public function get sec() : Number
		{
			return _track.sec;
		}
		public function set sec(sec : Number) : void
		{
			_track.sec = sec;
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function eventOn() : void
		{
			_track.addEventListener(ScrollEvent.SCROLL, trackScroll, false, 0, true);
			_track.addEventListener(ScrollEvent.THUMB_SHOW, thumbShowHide, false, 0, true);
			_track.addEventListener(ScrollEvent.THUMB_HIDE, thumbShowHide, false, 0, true);
			if (_buttonsUpPosition.up != null) _buttonsUpPosition.up.addEventListener(MouseEvent.MOUSE_DOWN, moveUp, false, 0, true);
			if (_buttonsUpPosition.down != null) _buttonsUpPosition.down.addEventListener(MouseEvent.MOUSE_DOWN, moveDown, false, 0, true);
			if (_buttonsUpPosition.pageUp != null) _buttonsUpPosition.pageUp.addEventListener(MouseEvent.CLICK, pageUp, false, 0, true);
			if (_buttonsUpPosition.pageDown != null) _buttonsUpPosition.pageDown.addEventListener(MouseEvent.CLICK, pageDown, false, 0, true);
			if (_buttonsDownPosition.up != null) _buttonsDownPosition.up.addEventListener(MouseEvent.MOUSE_DOWN, moveUp, false, 0, true);
			if (_buttonsDownPosition.down != null) _buttonsDownPosition.down.addEventListener(MouseEvent.MOUSE_DOWN, moveDown, false, 0, true);
			if (_buttonsDownPosition.pageUp != null) _buttonsDownPosition.pageUp.addEventListener(MouseEvent.CLICK, pageUp, false, 0, true);
			if (_buttonsDownPosition.pageDown != null) _buttonsDownPosition.pageDown.addEventListener(MouseEvent.CLICK, pageDown, false, 0, true);
		}
		private function thumbShowHide(event : ScrollEvent = null) : void
		{
			var enable : Boolean = event != null && event.type == ScrollEvent.THUMB_SHOW;
			_buttonsUpPosition.enable = enable;
			_buttonsDownPosition.enable = enable;
		}
		private function pageDown(event : MouseEvent) : void
		{
			page(1);
		}
		private function pageUp(event : MouseEvent) : void
		{
			page(-1);
		}
		private function moveDown(event : MouseEvent) : void
		{
			_move = event.target as IButton;
			_isUp = true;
			updownDown();
		}
		private function updownDown() : void
		{
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, updownTimer, false, 0, true);
			_timer.start();
			
			_move.addEventListener(MouseEvent.ROLL_OUT, updownOut, false, 0, true);
			_move.addEventListener(MouseEvent.ROLL_OVER, updownOver, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, updownUp, false, 0, true);
		}
		private function updownUp(event : MouseEvent) : void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, updownTimer);
			_move.removeEventListener(MouseEvent.ROLL_OUT, updownOut);
			_move.removeEventListener(MouseEvent.ROLL_OVER, updownOver);
			stage.removeEventListener(MouseEvent.MOUSE_UP, updownUp);
			_timer = null;
			_move = null;
		}
		private function updownOver(event : MouseEvent) : void
		{
			if (_move.isMousePress) {
				_timer.start();
			}
		}
		private function updownOut(event : MouseEvent) : void
		{
			_timer.stop();
		}
		private function updownTimer(event : TimerEvent) : void
		{
			var i : int = (_isUp) ? -1 : 1;
			moveContent(i * _moveSpeed);
		}
		private function moveUp(event : MouseEvent) : void
		{
			_move = event.target as IButton;
			_isUp = false;
			updownDown();
		}
		private function trackScroll(event : ScrollEvent) : void
		{
			dispatchEvent(new ScrollEvent(event.type, event.secX, event.secY));
		}
		private function eventOff() : void
		{
			_track.removeEventListener(ScrollEvent.SCROLL, trackScroll);
			if (_buttonsUpPosition.up != null) _buttonsUpPosition.up.removeEventListener(MouseEvent.MOUSE_DOWN, moveUp);
			if (_buttonsUpPosition.down != null) _buttonsUpPosition.down.removeEventListener(MouseEvent.MOUSE_DOWN, moveDown);
			if (_buttonsUpPosition.pageUp != null) _buttonsUpPosition.pageUp.removeEventListener(MouseEvent.CLICK, pageUp);
			if (_buttonsUpPosition.pageDown != null) _buttonsUpPosition.pageDown.removeEventListener(MouseEvent.CLICK, pageDown);
			if (_buttonsDownPosition.up != null) _buttonsDownPosition.up.removeEventListener(MouseEvent.MOUSE_DOWN, moveUp);
			if (_buttonsDownPosition.down != null) _buttonsDownPosition.down.removeEventListener(MouseEvent.MOUSE_DOWN, moveDown);
			if (_buttonsDownPosition.pageUp != null) _buttonsDownPosition.pageUp.removeEventListener(MouseEvent.CLICK, pageUp);
			if (_buttonsDownPosition.pageDown != null) _buttonsDownPosition.pageDown.removeEventListener(MouseEvent.CLICK, pageDown);
		}
		/* *********************************************************************
		 * implements ISSenComponent, IInput
		 ********************************************************************* */
		public function resourceKill() : void
		{
			eventOff();
			_track.resourceKill();
			_buttonsUpPosition.resourceKill();
			_buttonsDownPosition.resourceKill();
			_track = null;
			_buttonsUpPosition = null;
			_buttonsDownPosition = null;
		}
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable != _enable) {
				_track.enable = enable;
				_buttonsUpPosition.enable = enable;
				_buttonsDownPosition.enable = enable;
				mouseEnabled = enable;
				mouseChildren = enable;
				_enable = enable;
			}
		}
		public function get minValue() : Number
		{
			return _track.minValue;
		}
		public function set minValue(minValue : Number) : void
		{
			_track.minValue = minValue;
		}
		public function get maxValue() : Number
		{
			return _track.maxValue;
		}
		public function set maxValue(maxValue : Number) : void
		{
			_track.maxValue = maxValue;
		}
		public function get value() : Object
		{
			return _track.value;
		}
		public function set value(value : Object) : void
		{
			_track.value = value;
		}
		public function get valueType() : Class
		{
			return Number;
		}
		public function get scrollEnable() : Boolean
		{
			return _track.scrollEnable;
		}
	}
}
