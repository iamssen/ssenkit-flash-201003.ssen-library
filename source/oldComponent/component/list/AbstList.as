package ssen.component.list
{
	import ssen.component.scroll.IScrollPane;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.errors.AbstractMemberError;
	import ssen.core.text.FontRender;
	import ssen.core.text.IFontRenderObject;
	import ssen.data.selectGroup.ISelectGroup;
	
	import flash.display.DisplayObject;
	import flash.events.Event;	
	/**
	 * @author SSen
	 */
	public class AbstList extends SSenSprite implements IFontRenderObject
	{
		private var _pane : IScrollPane;
		private var _items : AbstListItems;
		private var _enabled : Boolean;
		protected var _width : Number;
		protected var _height : Number;

		public function AbstList(width : int, height : int, data : ISelectGroup = null)
		{
			_width = width;
			_height = height;
			
			_items = createListItems(data);
			_pane = createScrollPane(width, height);
			_pane.content = _items;
			
			_items.addEventListener(Event.RESIZE, itemsResize, false, 0, true);
			_pane.wheelOn();
			if (data == null) {
				_pane.enable = false;
			}
			
			addChild(DisplayObject(_pane));
		}
		private function itemsResize(event : Event) : void
		{
			_pane.refresh();
		}
		/* *********************************************************************
		 * Factory
		 ********************************************************************* */
		/** Factory : scroll pane 을 만든다 */
		protected function createScrollPane(width : int, height : int) : IScrollPane
		{
			throw new AbstractMemberError();
		}
		/** Factory : list items 를 만든다 */
		protected function createListItems(data : ISelectGroup = null) : AbstListItems
		{
			throw new AbstractMemberError();
		}
		/* *********************************************************************
		 * art interface
		 ********************************************************************* */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_pane.width = value;
			_items.width = _pane.containerWidth;
			_pane.refresh();
			_width = value;
		}
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_pane.height = value;
		}
		public function moveToSelectedY() : void
		{
			_pane.contentY = -_items.selectedY;
		}
		public function refresh() : void
		{
			_items.refresh();
		}
		/* *********************************************************************
		 * data interface
		 ********************************************************************* */
		public function get data() : ISelectGroup
		{
			return _items.data;
		}
		public function set data(data : ISelectGroup) : void
		{
			_items.data = data;
		}
		/* *********************************************************************
		 * interaction interface
		 ********************************************************************* */
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		public function set enabled(enabled : Boolean) : void
		{
			if (_enabled != enabled) {
				_items.enabled = enabled;
				_pane.enable = enabled;
				mouseEnabled = enabled;
				mouseChildren = enabled;
				_enabled = enabled;
			}
		}
		/* *********************************************************************
		 * resource interface
		 ********************************************************************* */
		public function resourceKill() : void
		{
			_pane.wheelOff();
		}
		public function prevItem(item : IListItem) : IListItem
		{
			return _items.prevItem(item);
		}
		public function nextItem(item : IListItem) : IListItem
		{
			return _items.nextItem(item);
		}
		public function getItemAt(index : int) : IListItem
		{
			return _items.getItemAt(index);
		}
		/* *********************************************************************
		 * implement IFontRenderObject
		 ********************************************************************* */
		public function setFontRenderingStyle(embedFonts : Boolean = false, sharpness : Number = 0, thickness : Number = 0) : void
		{
			_items.setFontRenderingStyle(embedFonts, sharpness, thickness);
		}
		public function setFontRender(fontRender : FontRender = null) : void
		{
			_items.setFontRender(fontRender);
		}
	}
}
