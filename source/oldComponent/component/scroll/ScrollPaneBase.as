package ssen.component.scroll 
{
	import flash.events.MouseEvent;	

	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.geom.Padding;

	import flash.display.DisplayObject;		
	/**
	 * @author SSen
	 */
	public class ScrollPaneBase extends SSenSprite implements IScrollPane
	{
		protected var _container : ScrollContainer;
		protected var _scrollerH : IScroller;
		protected var _scrollerV : IScroller;
		protected var _enable : Boolean;
		protected var _width : Number;
		protected var _height : Number;
		protected var _directionMode : String;
		protected var _background : DisplayObject;
		protected var _padding : Padding;
		
		public function ScrollPaneBase()
		{
			_enable = true;
		}
		/* *********************************************************************
		 * override size
		 ********************************************************************* */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = width;
			align();
		}
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = height;
			align();
		}
		/* *********************************************************************
		 * implement IScrollPane
		 ********************************************************************* */
		public function deleteContent() : void
		{
			_container.deleteContent();
		}
		public function get content() : DisplayObject
		{
			return _container.content;
		}
		public function set content(content : DisplayObject) : void
		{
			_container.content = content;
		}
		public function get secX() : Number
		{
			return _container.contentX;
		}
		public function set secX(sec : Number) : void
		{
			_container.contentX = sec;
		}
		public function get secY() : Number
		{
			return _container.contentY;
		}
		public function set secY(sec : Number) : void
		{
			_container.secY = sec;
		}
		public function get contentX() : Number
		{
			return _container.contentX;
		}
		public function set contentX(value : Number) : void
		{
			_container.contentX = value;
		}
		public function get contentY() : Number
		{
			return _container.contentY;
		}
		public function set contentY(value : Number) : void
		{
			_container.contentY = value;
		}
		public function refresh() : void
		{
			_container.refresh();
		}
		public function get containerWidth() : Number
		{
			return _container.containerWidth;
		}
		public function get containerHeight() : Number
		{
			return _container.containerHeight;
		}
		public function get contentWidth() : Number
		{
			return _container.contentWidth;
		}
		public function get contentHeight() : Number
		{
			return _container.contentHeight;
		}
		public function resourceKill() : void
		{
			wheelOff();
			_container.resourceKill();
			if (_scrollerH != null) _scrollerH.resourceKill();
			if (_scrollerV != null) _scrollerV.resourceKill();
			_container = null;
			_scrollerH = null;
			_scrollerV = null;
		}
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable != _enable) {
				_container.enable = enable;
				if (_scrollerH != null) _scrollerH.enable = enable;
				if (_scrollerV != null) _scrollerV.enable = enable;
				mouseChildren = enable;
				mouseEnabled = enable;
				_enable = enable;
			}
		}
		public function get directionMode() : String
		{
			return _directionMode;
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		protected function align() : void
		{
			if (_background != null) {
				_background.width = _width;
				_background.height = _height;
			}
			
			switch (_directionMode) {
				case DirectionMode.VERTICAL_AND_HORIZONTAL :
					_container.x = _padding.left;
					_container.y = _padding.top;
					_container.width = _width - _scrollerV.width - _padding.left - _padding.right;
					_container.height = _height - _scrollerH.height - _padding.top - _padding.bottom;
					_scrollerV.height = _container.height;
					_scrollerV.x = _container.width + _padding.left;
					_scrollerV.y = _padding.top;
					_scrollerH.width = _container.width;
					_scrollerH.x = _padding.left;
					_scrollerH.y = _container.height + _padding.top;
					break; 
				case DirectionMode.VERTICAL :
					_container.x = _padding.left;
					_container.y = _padding.top;
					_container.width = _width - _scrollerV.width - _padding.left - _padding.right;
					_container.height = _height - _padding.top - _padding.bottom;
					_scrollerV.height = _container.height;
					_scrollerV.x = _container.width + _padding.left;
					_scrollerV.y = _padding.top;
					break; 
				case DirectionMode.HORIZONTAL :
					_container.x = _padding.left;
					_container.y = _padding.top;
					_container.width = _width - _padding.left - _padding.right;
					_container.height = _height - _scrollerH.height - _padding.top - _padding.bottom;
					_scrollerH.width = _container.width;
					_scrollerH.x = _padding.left;
					_scrollerH.y = _container.height + _padding.top;
					break;
			}
		}
		public function wheelOn() : void
		{
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel, false, 0, true);
		}
		public function wheelOff() : void
		{
			if (hasEventListener(MouseEvent.MOUSE_WHEEL)) removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		}
		private function mouseWheel(event : MouseEvent) : void
		{
			if (_scrollerV != null) {
				_scrollerV.wheel(event.delta);
			} else {
				_scrollerH.wheel(event.delta);
			}
		}
		public function get disableFilter() : Boolean
		{
			return _container.disableFilter;
		}
		public function set disableFilter(bool : Boolean) : void
		{
			_container.disableFilter = bool;
		}
	}
}
