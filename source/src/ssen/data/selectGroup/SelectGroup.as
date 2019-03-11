package ssen.data.selectGroup 
{
	import ssen.core.array.Values;
	import ssen.core.events.ValueEvent;
	import ssen.core.utils.FormatToString;
	import ssen.data.IDataModel;
	import ssen.data.events.SelectGroupEvent;
	import ssen.data.selectGroup.ISelectItem;

	import flash.events.EventDispatcher;	
	/**
	 * SelectGroup
	 * @author SSen
	 */
	public class SelectGroup extends EventDispatcher implements ISelectGroup
	{
		private var _items : Vector.<ISelectItem>;
		private var _multiSelect : Boolean;
		private var _prevSelect : ISelectItem;

		
		/**
		 * 생성자
		 * @param selectType 선택 방식
		 */
		public function SelectGroup(selectType : String = "singleSelect")
		{
			_items = new Vector.<ISelectItem>();
			this.selectType = selectType;
		}
		/* *********************************************************************
		 * implement IDataModel
		 ********************************************************************* */
		/** @copy ssen.data.IDataModel#resourceKill() */
		public function resourceKill() : void
		{
			clearAll();
		}
		/** @copy ssen.data.IDataModel#valueXML */
		public function get valueXML() : XML
		{
			var xml : XML = <group />;
			xml["@selectType"] = (_multiSelect) ? SelectType.MULTI_SELECT : SelectType.SINGLE_SELECT;
			for (var f : int = 0;f < _items.length;f++) {
				xml["item"] += _items[f].valueXML;
			}
			return xml;
		}
		/** @copy ssen.data.IDataModel#toString() */
		override public function toString() : String
		{
			return FormatToString.toString(this, "selectType");
		}
		/** @copy ssen.data.IDataModel#clone() */
		public function clone() : IDataModel
		{
			var clone : SelectGroup = new SelectGroup();
			var items : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			var f : int;
			for (f = 0;f < _items.length; f++) {
				items.push(_items[f].clone());
			}
			clone._items = items;
			clone._multiSelect = _multiSelect;
			return clone;
		}
		/* *********************************************************************
		 * default interface
		 ********************************************************************* */
		/** @copy ssen.data.selectGroup.ISelectGroup#selected */
		public function get selected() : Boolean
		{
			var f : int;
			for (f = 0;f < _items.length; f++) {
				if (_items[f].selected) return true;
			}
			return false;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#selectType */
		public function get selectType() : String
		{
			return (_multiSelect) ? SelectType.MULTI_SELECT : SelectType.SINGLE_SELECT;
		}
		public function set selectType(selectType : String) : void
		{
			var multiSelect : Boolean = selectType == SelectType.MULTI_SELECT;
			if (_multiSelect != multiSelect && !multiSelect) {
				for (var f : int = 0;f < _items.length; f++) {
					_items[f].selected = false;
				}
			}
			_multiSelect = multiSelect;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#selectedItems */
		public function get selectedItems() : Vector.<ISelectItem>
		{
			var vec : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			for (var f : int = 0;f < _items.length; f++) {
				if (_items[f].selected) {
					vec.push(_items[f]);
					if (!_multiSelect) return vec;
				}
			}
			return vec;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#items */
		public function get items() : Vector.<ISelectItem>
		{
			return _items;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#length */
		public function get length() : int
		{
			return _items.length;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#getItemAt */
		public function getItemAt(index : int) : ISelectItem
		{
			return _items[index];
		}
		/* *********************************************************************
		 * select interface
		 ********************************************************************* */
		/** @copy ssen.data.selectGroup.ISelectGroup#selectItem() */
		public function selectItem(item : ISelectItem) : void
		{
			if (!item.selected) {
				if (_prevSelect == null || _prevSelect != item || !_prevSelect.selected) {
					if (!_multiSelect && _prevSelect != null && _prevSelect.selected) {
						deselectItem(_prevSelect);
					}
					item.selected = true;
					_prevSelect = item;
					dispatchEvent(new SelectGroupEvent(SelectGroupEvent.SELECT_ITEM, item, _multiSelect));
				}
			}
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#deselectItem() */
		public function deselectItem(item : ISelectItem) : void
		{
			if (item.selected) {
				item.selected = false;
				dispatchEvent(new SelectGroupEvent(SelectGroupEvent.DESELECT_ITEM, item, _multiSelect));
			}
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#selectItemAt() */
		public function selectItemAt(index : int) : void
		{
			selectItem(_items[index]);
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#deselectItemAt() */
		public function deselectItemAt(index : int) : void
		{
			deselectItem(_items[index]);
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#selectItemAll() */
		public function selectItemAll() : void
		{
			if (_multiSelect) {
				for (var f : int = 0;f < _items.length; f++) {
					_items[f].selected = true;
				}
				dispatchEvent(new SelectGroupEvent(SelectGroupEvent.SELECT_ALL));
			} else {
				trace("SSEN// selectItemAll 은 SelectType.NULTI_SELECT 에서만 가능합니다.");
			}
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#deselectItemAll() */
		public function deselectItemAll() : void
		{
			for (var f : int = 0;f < _items.length; f++) {
				_items[f].selected = false;
			}
			dispatchEvent(new SelectGroupEvent(SelectGroupEvent.DESELECT_ALL));
		}
		/* *********************************************************************
		 * add, delete interface
		 ********************************************************************* */
		/** @copy ssen.data.selectGroup.ISelectGroup#addItem() */
		public function addItem(labelText : String, thumbnail : String, selected : Boolean = false, values : Values = null) : ISelectItem
		{
			var item : ISelectItem = new SelectItem(_items.length, labelText, thumbnail, selected, values);
			add(item);
			return item;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#deleteItem() */
		public function deleteItem(item : ISelectItem) : void
		{
			_items.splice(item.id, 1);
			cleanupID();
			dispatchEvent(new SelectGroupEvent(SelectGroupEvent.DELETE_ITEM, item));
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#deleteItemAt() */
		public function deleteItemAt(index : int) : void
		{
			deleteItem(_items[index]);
		}
		/* *********************************************************************
		 * search, sort interface
		 ********************************************************************* */
		/** @copy ssen.data.selectGroup.ISelectGroup#searchValuesProperty() */
		public function searchValuesProperty(propertyName : String, findText : String) : Vector.<ISelectItem>
		{
			var vec : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			for (var f : int = 0;f < _items.length; f++) {
				if (_items[f].values && _items[f].values[propertyName] && String(_items[f].values[propertyName]).search(new RegExp(findText, "g")) > 0) {
					vec.push(_items[f]);
				}
			}
			return vec;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#hasValuesProperty() */
		public function hasValuesProperty(propertyName : String) : Vector.<ISelectItem>
		{
			var vec : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			for (var f : int = 0;f < _items.length; f++) {
				if (_items[f].values && _items[f].values[propertyName]) {
					vec.push(_items[f]);
				}
			}
			return vec;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#sortByValuesProperty() */
		public function sortByValuesProperty(propertyName : String, asc : Boolean = true) : void
		{
			var valueSort : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			var valueNull : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			for (var f : int = 0;f < _items.length; f++) {
				if (_items[f].values != null && _items[f].values[propertyName] != undefined) {
					valueSort.push(_items[f]);
				} else {
					valueNull.push(_items[f]);
				}
			}
			if (valueSort.length > 0) {
				valueSort.sort(sortItems(asc, false, propertyName));
				if (valueNull.length > 0) valueSort = Vector.<ISelectItem>(valueSort.concat(valueNull));
				_items = valueSort;
				dispatchEvent(new SelectGroupEvent(SelectGroupEvent.SORT_ITEMS));
			} else {
				FormatToString.ssenErrorTrace("없는 property name 입니다.");
			}
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#searchLabelText() */
		public function searchLabelText(findText : String) : Vector.<ISelectItem>
		{
			var vec : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			for (var f : int = 0;f < _items.length; f++) {
				if (_items[f].labelText.search(new RegExp(findText, "g")) > 0) {
					vec.push(_items[f]);
				}
			}
			return vec;
		}
		/** @copy ssen.data.selectGroup.ISelectGroup#sortByLabelText() */
		public function sortByLabelText(asc : Boolean = true) : void
		{
			_items.sort(sortItems(asc));
			dispatchEvent(new SelectGroupEvent(SelectGroupEvent.SORT_ITEMS));
		}
		private function sortItems(asc : Boolean, isLabelText : Boolean = true, propertyName : String = null) : Function
		{
			function sortAsc(a : ISelectItem, b : ISelectItem) : Number {
				var a1 : int;
				var b1 : int;
				var i : int = 0;
				var a2 : String;
				var b2 : String;
				if (isLabelText) {
					a2 = a.labelText;
					b2 = b.labelText;
				} else {
					a2 = a.values[propertyName];
					b2 = b.values[propertyName];
				}
				while (true) {
					a1 = String(a2).charCodeAt(i);
					b1 = String(b2).charCodeAt(i);
					if (a1 - b1 != 0) {
						return a1 - b1;
					} else if (a1 + b1 > 0) {
						i++;
					} else {
						return 0;
					}
				}
				return 0;
			}
			function sortDesc(a : ISelectItem, b : ISelectItem) : Number {
				var a1 : int;
				var b1 : int;
				var i : int = 0;
				var a2 : String;
				var b2 : String;
				if (isLabelText) {
					a2 = a.labelText;
					b2 = b.labelText;
				} else {
					a2 = a.values[propertyName];
					b2 = b.values[propertyName];
				}
				while (true) {
					a1 = String(a2).charCodeAt(i);
					b1 = String(b2).charCodeAt(i);
					if (b1 - a1 != 0) {
						return b1 - a1;
					} else if (a1 + b1 > 0) {
						i++;
					} else {
						return 0;
					}
				}
				return 0;
			}
			return (asc) ? sortAsc : sortDesc;
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function add(item : ISelectItem) : void
		{
			item.group = this;
			_items.push(item);
			eventOnItem(item);
			dispatchEvent(new SelectGroupEvent(SelectGroupEvent.ADD_ITEM, item, _multiSelect));
		}
		private function clearAll() : void
		{
			for (var f : int = 0;f < _items.length; f++) {
				eventOffItem(_items[f]);
				_items[f].resourceKill();
			}
			_items = null;
		}
		private function cleanupID() : void
		{
			for (var f : Number = 0;f < _items.length; f++) {
				_items[f].id = f;
			}
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function eventOnItem(item : ISelectItem) : void
		{
			item.addEventListener(ValueEvent.VALUE_CHANGED, valueChange, false, 0, true);
		}
		private function eventOffItem(item : ISelectItem) : void
		{
			item.removeEventListener(ValueEvent.VALUE_CHANGED, valueChange);
		}
		private function valueChange(event : ValueEvent) : void
		{
			if (event.valueName == "selected") {
				if (event.value) {
					selectItem(event.target as ISelectItem);
				} else {
					deselectItem(event.target as ISelectItem);
				}
			}
		}
	}
}
