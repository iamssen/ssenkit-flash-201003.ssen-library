package ssen.component.interaction 
{
	import ssen.component.buttons.ButtonType;
	import ssen.core.display.PositionTester;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.events.OnOffEvent;
	import ssen.core.events.SSenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;	
	/**
	 * @author SSen
	 */
	public class ButtonInteraction extends EventDispatcher implements IInteraction
	{
		// target object
		private var _button : Sprite;
		private var _enabled : Boolean;
		private var _buttonType : String;
		private var _skinMode : String;
		private var _toggleOn : Boolean;
		private var _mousePress : Boolean;

		public function ButtonInteraction(button : Sprite, buttonType : String = "normal")
		{
			_button = button;
			_buttonType = buttonType;
			_button.mouseChildren = false;
			_skinMode = SkinFlag.DISABLE;
		}
		/** @copy ssen.component.buttons.IButton#toggleOn */
		public function get toggleOn() : Boolean
		{
			return (_buttonType == ButtonType.TOGGLE) ? _toggleOn : false;
		}
		public function set toggleOn(toggleOn : Boolean) : void
		{
			_toggleOn = (_buttonType == ButtonType.TOGGLE) ? toggleOn : false;
			skinDefault();
		}
		/** @copy ssen.component.buttons.IButton#buttonType */
		public function get buttonType() : String
		{
			return _buttonType;
		}
		public function set buttonType(buttonType : String) : void
		{
			_buttonType = buttonType;
			_toggleOn = false;
			if (_skinMode == SkinFlag.SELECTED) _skinMode = SkinFlag.DEFAULT;
			if (_buttonType == ButtonType.TOGGLE) {
				_button.addEventListener(MouseEvent.CLICK, mouseClick, false, 0, true);
			} else {
				_button.removeEventListener(MouseEvent.CLICK, mouseClick);
			}
			skinning();
		}
		/** @copy ssen.component.buttons.IButton#isMousePress */
		public function get isMousePress() : Boolean
		{
			return _mousePress;
		}
		/* *********************************************************************
		 * implement IInteraction
		 ********************************************************************* */
		public function start() : void
		{
			if (!_enabled) {
				_button.tabEnabled = true;
				_button.buttonMode = true;
				_button.mouseEnabled = true;
				skinDefault();
				eventOn();
				_enabled = true;
			}
		}
		public function stop() : void
		{
			if (_enabled) {
				_button.tabEnabled = false;
				_button.buttonMode = false;
				_button.mouseEnabled = false;
				skinDisabled();
				eventOff();
				_enabled = false;
			}
		}
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		/** @copy ssen.component.base.ISSenComponent#resourceKill() */
		public function resourceKill() : void
		{
			eventOff();
			_button = null;
		}
		/* *********************************************************************
		 * Event 
		 ********************************************************************* */
		private function eventOn() : void
		{
			_button.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			_button.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
			_button.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0, true);
			if (_buttonType == ButtonType.TOGGLE) _button.addEventListener(MouseEvent.CLICK, mouseClick, false, 0, true);
			_button.addEventListener(FocusEvent.FOCUS_IN, focusIn, false, 0, true);
			_button.addEventListener(FocusEvent.FOCUS_OUT, focusOut, false, 0, true);
		}
		private function eventOff() : void
		{
			_button.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			_button.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			_button.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			if (_buttonType == ButtonType.TOGGLE) _button.removeEventListener(MouseEvent.CLICK, mouseClick);
			_button.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			_button.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			if (_button.stage != null && _button.stage.hasEventListener(MouseEvent.MOUSE_UP)) _button.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		private function focusOut(event : FocusEvent) : void
		{
			if (_enabled) {
				skinDefault();
				_button.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				_button.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			}
		}
		private function focusIn(event : FocusEvent) : void
		{
			if (_enabled) {
				skinOver();
				_button.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 0, true);
				_button.addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 0, true);
			}
		}
		private function keyUp(event : KeyboardEvent) : void
		{
			if (event.keyCode == 32 || event.keyCode == 13) {
				_button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				skinOver();
			}
		}
		private function keyDown(event : KeyboardEvent) : void
		{
			if (event.keyCode == 32 || event.keyCode == 13) {
				skinDown();
			}
		}
		// 토글 클릭
		private function mouseClick(event : MouseEvent) : void
		{
			_toggleOn = (_toggleOn) ? false : true;
			_button.dispatchEvent(new OnOffEvent(OnOffEvent.ONOFF, _toggleOn));
			skinOver();
		}
		// 마우스 눌렀다 뗌
		private function mouseUp(event : MouseEvent) : void
		{
			_button.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_mousePress = false;
			if (PositionTester.isPointerInRect(DisplayObject(_button), _button.getRect(DisplayObject(_button)))) {
				skinOver();
			} else {
				skinDefault();
			}
		}
		// 마우스 누름
		private function mouseDown(event : MouseEvent) : void
		{
			_button.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
			_mousePress = true;
			skinDown();
		}
		// 마우스 벗어남
		private function mouseOut(event : MouseEvent) : void
		{
			skinDefault();
		}
		// 마우스 오버
		private function mouseOver(event : MouseEvent) : void
		{
			if (_mousePress) {
				skinDown();
			} else {
				skinOver();
			}
		}
		/* *********************************************************************
		 * Skinning Methods
		 ********************************************************************* */
		// 스킨 #기본 상태
		private function skinDefault() : void
		{
			if (_toggleOn) {
				_skinMode = SkinFlag.SELECTED;
			} else {
				_skinMode = SkinFlag.DEFAULT;
			}
			skinning();
		}
		// 스킨 #비활성화 상태
		private function skinDisabled() : void
		{
			_skinMode = SkinFlag.DISABLE;
			skinning();
		}
		// 스킨 #오버되어 있는 모습
		private function skinOver() : void
		{
			if (_toggleOn) {
				_skinMode = SkinFlag.SELECTED;
			} else {
				_skinMode = SkinFlag.OVER;
			}
			skinning();
		}
		// 스킨 #누르는 순간
		private function skinDown() : void
		{
			_skinMode = SkinFlag.ACTION;
			skinning();
		}
		private function skinning() : void
		{
			dispatchEvent(new SSenEvent(SSenEvent.SKINNING));
		}
		/** 현재의 skin mode */
		public function get skinMode() : String
		{
			return _skinMode;
		}
	}
}
