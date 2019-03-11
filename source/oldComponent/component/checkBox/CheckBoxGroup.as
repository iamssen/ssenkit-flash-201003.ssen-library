package ssen.component.checkBox 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFillRect;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.geom.VerticalAlign;
	import ssen.core.text.FontRender;
	import ssen.core.text.IFontRenderObject;
	import ssen.core.text.TextStyle;
	import ssen.core.utils.FormatToString;
	import ssen.data.events.SelectGroupEvent;
	import ssen.data.selectGroup.ISelectGroup;

	import flash.display.DisplayObject;
	import flash.display.GraphicsSolidFill;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * @author SSen
	 */
	public class CheckBoxGroup extends SSenSprite implements IFontRenderObject
	{
		private var _width : Number;
		private var _enabled : Boolean;
		private var _items : Vector.<ICheckBoxItem>;
		private var _data : ISelectGroup;
		private var _lineHeight : int;
		private var _space : int;

		
		public function CheckBoxGroup(width : int, space : int, lineHeight : int, data : ISelectGroup = null)
		{
			_width = width;
			_space = space;
			_lineHeight = lineHeight;
			
			_items = new Vector.<ICheckBoxItem>();
			
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
			align();
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
			_width = value;
			align();
		}
		override public function set height(value : Number) : void
		{
			FormatToString.ssenErrorTrace("height=" + value + "는 자동으로 결정됩니다.");
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
				align();
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
		public function getItemAt(index : int) : ICheckBoxItem
		{
			return _items[index];
		}
		/* *********************************************************************
		 * factory
		 ********************************************************************* */
		/** Factory : check box item 을 만든다 */
		protected function createCheckBoxItem(enabled : Boolean) : ICheckBoxItem
		{
			//throw new AbstractMemberError();
			var rect : SkinFillRect = new SkinFillRect(true, 10, 10);
			rect.addFill(SkinFlag.DEFAULT, new GraphicsSolidFill(0xeeeeee));
			rect.addFill(SkinFlag.SELECTED, new GraphicsSolidFill(0x000000));
			rect.addFill(SkinFlag.OVER, new GraphicsSolidFill(0xaaaaaa));
			rect.addFill(SkinFlag.ACTION, new GraphicsSolidFill(0x999999));
			rect.addFill(SkinFlag.DISABLE, new GraphicsSolidFill(0xeeeeee));
			var checkBox : ISkinDisplayObject = rect;
			return new CheckBoxItem(checkBox, 100, true, getFontColors(0), new TextStyle(), enabled, VerticalAlign.MIDDLE);
		}
		private function getFontColors(type : int) : Dictionary
		{
			var fontColors : Dictionary = new Dictionary(true);
			switch (type) {
				case 1: 
					fontColors[SkinFlag.DEFAULT] = 0x666666;
					fontColors[SkinFlag.SELECTED] = 0x555555;
					fontColors[SkinFlag.OVER] = 0x444444;
					fontColors[SkinFlag.ACTION] = 0x222222;
					fontColors[SkinFlag.DISABLE] = 0xaaaaaa;
					break;
				default : 
					fontColors[SkinFlag.DEFAULT] = 0xaaaaaa;
					fontColors[SkinFlag.SELECTED] = 0x555555;
					fontColors[SkinFlag.OVER] = 0x000000;
					fontColors[SkinFlag.ACTION] = 0x222222;
					fontColors[SkinFlag.DISABLE] = 0xaaaaaa;
					break;
			}
			return fontColors;
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
			var f : int;
			var pre : ICheckBoxItem;
			var item : ICheckBoxItem;
			
			for (f = 1;f < _items.length;f++) {
				pre = _items[f - 1];
				item = _items[f];
				
				if (pre.nextX(_space) + item.width > _width) {
					item.x = 0;
					item.y = pre.nextY(_lineHeight);
				} else {
					item.position = pre.nextPosition(_space);
				}
			}
			
			dispatchEvent(new Event(Event.RESIZE));
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
			align();
		}
		private function addItem(event : SelectGroupEvent) : void
		{
			var id : int = event.item.id;
			if (id == _items.length) {
				setItems();
				var item : ICheckBoxItem = _items[id];
				item.data = _data.getItemAt(id);
			} else {
				setItems();
				setDataToItems();
			}
			align();
		}
		private function setDataToItems() : void
		{
			var item : ICheckBoxItem;
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
				var item : ICheckBoxItem;
			
				var f : int;
				
				if (prevLength > nextLength) {
					for (f = prevLength - 1;f > nextLength - 1; f--) {
						item = _items[f];
						item.resourceKill();
						removeChild(DisplayObject(item));
					}
					_items.length = nextLength;
				} else {
					for (f = prevLength;f < nextLength; f++) {
						item = createCheckBoxItem(_enabled);
						addChild(DisplayObject(item));
						_items.push(item);
					}
				}
			}
		}
	}
}
