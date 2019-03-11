package ssen.component.scroll 
{
	import flash.display.DisplayObject;	
	
	import ssen.component.base.ISSenComponent;	
	import ssen.component.buttons.IButton;
	import ssen.core.display.expanse.SSenSprite;		
	/**
	 * @author SSen
	 */
	public class ScrollBarButtonGroup extends SSenSprite implements ISSenComponent
	{
		private var _up : IButton;
		private var _down : IButton;
		private var _pageUp : IButton;
		private var _pageDown : IButton;
		private var _enable : Boolean;

		public function ScrollBarButtonGroup(up : IButton = null, down : IButton = null, pageUp : IButton = null, pageDown : IButton = null)
		{
			_up = up;
			_down = down;
			_pageUp = pageUp;
			_pageDown = pageDown;
			
			if (_up != null) addChild(DisplayObject(_up));
			if (_down != null) addChild(DisplayObject(_down));
			if (_pageUp != null) addChild(DisplayObject(_pageUp));
			if (_pageDown != null) addChild(DisplayObject(_pageDown));
			
			_enable = true;
		}
		public function get up() : IButton
		{
			return _up;
		}
		public function get down() : IButton
		{
			return _down;
		}
		public function get pageUp() : IButton
		{
			return _pageUp;
		}
		public function get pageDown() : IButton
		{
			return _pageDown;
		}
		public function align(directionMode : String, btns : Array) : void
		{
			var isVertical : Boolean = directionMode == DirectionMode.VERTICAL;
			var f : int;
			var btn : IButton;
			var next : Number = 0;
			for (f = 0;f < btns.length; f++) {
				btn = this[btns[f]];
				if (btn != null) {
					if (isVertical) {
						btn.y = next;
						next += btn.height;
					} else {
						btn.x = next;
						next += btn.width;
					}
				}
			}
		}
		/* *********************************************************************
		 * implement ISSenComponent
		 ********************************************************************* */
		public function resourceKill() : void
		{
			if (_up != null) {
				_up.resourceKill();
				_up = null;
			}
			if (_down != null) {
				_down.resourceKill();
				_down = null;
			}
			if (_pageUp != null) {
				_pageUp.resourceKill();
				_pageUp = null;
			}
			if (_pageDown != null) {
				_pageDown.resourceKill();
				_pageDown = null;
			}
		}
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable != _enable) {
				if (_up != null) _up.enable = enable;
				if (_down != null) _down.enable = enable;
				if (_pageUp != null) _pageUp.enable = enable;
				if (_pageDown != null) _pageDown.enable = enable;
				_enable = enable; 
			}
		}
	}
}
