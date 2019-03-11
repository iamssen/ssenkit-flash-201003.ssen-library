package ssen.component.list 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.errors.AbstractMemberError;
	import ssen.core.text.FontRender;
	import ssen.core.text.IFontRenderObject;
	import ssen.data.events.SelectGroupEvent;
	import ssen.data.selectGroup.ISelectGroup;
	import ssen.data.selectGroup.ISelectItem;
	
	import flash.display.DisplayObject;
	import flash.events.Event;		
	/**
	 * @author SSen
	 */
	public class AbstListItems extends SSenSprite implements IFontRenderObject
	{
		/* *********************************************************************
		 * model
		 ********************************************************************* */
		private var _data : ISelectGroup;
		/* *********************************************************************
		 * art
		 ********************************************************************* */
		protected var _itemWidth : Number;
		protected var _itemHeight : Number;
		protected var _styleLength : int;
		/* *********************************************************************
		 * interaction
		 ********************************************************************* */
		private var _enabled : Boolean;
		/* *********************************************************************
		 * object
		 ********************************************************************* */
		private var _items : Vector.<IListItem>;

		public function AbstListItems(itemWidth : int, itemHeight : int, data : ISelectGroup = null)
		{
			_itemWidth = itemWidth;
			_itemHeight = itemHeight;
			
			_items = new Vector.<IListItem>();
			
			if (data != null) {
				_enabled = true;
				initialize(data);
			} else {
				_enabled = false;
				setItems();
			}
		}
		private function initialize(data : ISelectGroup) : void
		{
			_data = data;
			setItems();
			setDataToItems();
			eventOn();
		}
		/* *********************************************************************
		 * factory
		 ********************************************************************* */
		/** Factory : list item 을 만든다 */
		protected function createListItem(styleID : int, enabled : Boolean) : IListItem
		{
			throw new AbstractMemberError();
		}
		/* *********************************************************************
		 * art interface
		 ********************************************************************* */
		override public function get width() : Number
		{
			return _itemWidth;
		}
		override public function set width(value : Number) : void
		{
			var f : int;
			for (f = 0;f < _items.length; f++) {
				_items[f].width = value;
			}
			_itemWidth = value;
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get height() : Number
		{
			return _itemHeight * _items.length;
		}
		override public function set height(value : Number) : void
		{
			var itemHeight : int = value / _items.length;
			if (itemHeight < _items[0].minHeight) itemHeight = _items[0].minHeight;
			var f : int;
			for (f = 0;f < _items.length; f++) {
				_items[f].height = itemHeight;
			}
			_itemHeight = itemHeight;
			align();
		}
		public function get selectedY() : Number
		{
			if (_data.selected) {
				var item : ISelectItem = _data.selectedItems[0];
				return item.id * _itemHeight;
			}
			return 0;
		}
		public function refresh() : void
		{
			setItems();
			setDataToItems();
		}
		/* *********************************************************************
		 * data interface
		 ********************************************************************* */
		public function get data() : ISelectGroup
		{
			return _data;
		}
		public function set data(data : ISelectGroup) : void
		{
			if (_data == null) {
				initialize(data);
			} else {
				eventOffData(_data);
				_data = data;
				setItems();
				setDataToItems();
				eventOnData(_data);
			}
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
				var f : int;
				for (f = 0;f < _items.length; f++) {
					_items[f].enabled = enabled;
				}
				mouseChildren = enabled;
				mouseEnabled = enabled;
				_enabled = enabled;
			}
		}
		/* *********************************************************************
		 * resource interface
		 ********************************************************************* */
		public function resourceKill() : void
		{
			eventOff();
			var f : int;
			for (f = 0;f < _items.length; f++) {
				_items[f].resourceKill();
			}
			_items = null;
			_data = null;
		}
		public function prevItem(item : IListItem) : IListItem
		{
			var id : int = ISelectItem(item.data).id;
			if (id > 0) {
				var data : ISelectItem = _data.getItemAt(id - 1);
				var f : int;
				for (f = 0;f < _items.length; f++) {
					if (_items[f].data == data) {
						return _items[f];
					}
				}
			} 
			return null;
		}
		public function nextItem(item : IListItem) : IListItem
		{
			var id : int = ISelectItem(item.data).id;
			if (id < _data.length[0]) {
				var data : ISelectItem = _data.getItemAt(id + 1);
				var f : int;
				for (f = 0;f < _items.length; f++) {
					if (_items[f].data == data) {
						return _items[f];
					}
				}
			} 
			return null;
		}
		public function getItemAt(index : int) : IListItem
		{
			return _items[index];
		}
		/* *********************************************************************
		 * implement IFontRenderObject
		 ********************************************************************* */
		public function setFontRenderingStyle(embedFonts : Boolean = false, sharpness : Number = 0, thickness : Number = 0) : void
		{
			var f : int;
			for (f = 0;f < _items.length; f++) {
				IFontRenderObject(_items[f]).setFontRenderingStyle(embedFonts, sharpness, thickness);
			}
		}
		public function setFontRender(fontRender : FontRender = null) : void
		{
			var f : int;
			for (f = 0;f < _items.length; f++) {
				IFontRenderObject(_items[f]).setFontRender(fontRender); 
			}
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function align() : void
		{
			var item : IListItem;
			var f : int;
			
			for (f = 0;f < _items.length; f++) {
				item = _items[f];
				item.y = _itemHeight * f;
			}
		}
		private function eventOn() : void
		{
			eventOnData(_data);
		}
		private function eventOff() : void
		{
			eventOffData(_data);
		}
		private function eventOnData(data : ISelectGroup) : void
		{
			data.addEventListener(SelectGroupEvent.ADD_ITEM, addItem, false, 0, true);
			data.addEventListener(SelectGroupEvent.DELETE_ITEM, deleteItem, false, 0, true);
			data.addEventListener(SelectGroupEvent.SORT_ITEMS, sortItems, false, 0, true);
		}
		private function eventOffData(data : ISelectGroup) : void
		{
			data.removeEventListener(SelectGroupEvent.ADD_ITEM, addItem);
			data.removeEventListener(SelectGroupEvent.DELETE_ITEM, deleteItem);
			data.removeEventListener(SelectGroupEvent.SORT_ITEMS, sortItems);
		}
		private function sortItems(event : SelectGroupEvent) : void
		{
			setDataToItems();
			align();
		}
		private function deleteItem(event : SelectGroupEvent) : void
		{
			setItems();
			setDataToItems();
		}
		private function addItem(event : SelectGroupEvent) : void
		{
			var id : int = event.item.id;
			if (id == _items.length) {
				setItems();
				var item : IListItem = _items[id];
				item.data = _data.getItemAt(id);
			} else {
				setItems();
				setDataToItems();
			}
		}
		private function setDataToItems() : void
		{
			var item : IListItem;
			var f : int;
			
			for (f = 0;f < _items.length; f++) {
				item = _items[f];
				item.data = _data.getItemAt(f);
			}
		}
		private function setItems() : void
		{
			var prevLength : int = (_items != null) ? _items.length : 0;
			var nextLength : int = (_data != null) ? _data.length : 2;
			
			if (prevLength != nextLength) {
				var item : IListItem;
			
				var f : int;
				var s : int;
				
				if (prevLength > nextLength) {
					for (f = prevLength - 1;f > nextLength - 1; f--) {
						item = _items[f];
						item.resourceKill();
						removeChild(DisplayObject(item));
					}
					_items.length = nextLength;
				} else {
					for (f = prevLength;f < nextLength; f++) {
						s = f % _styleLength;
						item = createListItem(s, _enabled);
						addChild(DisplayObject(item));
						_items.push(item);
					}
					align();
				}
				
				dispatchEvent(new Event(Event.RESIZE));
			}
		}
	}
}
