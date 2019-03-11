package ssen.core.events 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	/**
	 * @author ssen
	 */
	public class InteractionSwitcher 
	{
		private var _mouseEnabled : Boolean;
		private var _tabEnabled : Boolean;
		private var _target : InteractiveObject;
		private var _mouseChildren : Boolean;
		private var _tabChildren : Boolean;
		private var _buttonMode : Boolean;
		private var _useHandCursor : Boolean;

		
		public function InteractionSwitcher(target : InteractiveObject)
		{
			_target = target;
			readOriginalStatus();
		}
		/** 원상태의 인터렉션 설정들을 읽어들여 저장합니다. */
		public function readOriginalStatus() : void
		{
			if (_target is InteractiveObject) {
				_mouseEnabled = _target.mouseEnabled;
				_tabEnabled = _target.tabEnabled;
			}
			if (_target is DisplayObjectContainer) {
				var container : DisplayObjectContainer = DisplayObjectContainer(_target);
				_mouseChildren = container.mouseChildren;
				_tabChildren = container.tabChildren;
			}
			if (_target is Sprite) {
				var sprite : Sprite = Sprite(_target);
				_buttonMode = sprite.buttonMode;
				_useHandCursor = sprite.useHandCursor;
			}
		}
		/** 인터렉션을 모두 정지 */
		public function off() : void
		{
			if (_target is InteractiveObject) {
				_target.mouseEnabled = false;
				_target.tabEnabled = false;
			}
			if (_target is DisplayObjectContainer) {
				var container : DisplayObjectContainer = DisplayObjectContainer(_target);
				container.mouseChildren = false;
				container.tabChildren = false;
			}
			if (_target is Sprite) {
				var sprite : Sprite = Sprite(_target);
				sprite.buttonMode = false;
				sprite.useHandCursor = false;
			}
		}
		/** 인터렉션을 모두 원상복구 */
		public function on() : void
		{
			if (_target is InteractiveObject) {
				_target.mouseEnabled = _mouseEnabled;
				_target.tabEnabled = _tabEnabled;
			}
			if (_target is DisplayObjectContainer) {
				var container : DisplayObjectContainer = DisplayObjectContainer(_target);
				container.mouseChildren = _mouseChildren;
				container.tabChildren = _tabChildren;
			}
			if (_target is Sprite) {
				var sprite : Sprite = Sprite(_target);
				sprite.buttonMode = _buttonMode;
				sprite.useHandCursor = _useHandCursor;
			}
		}
	}
}
