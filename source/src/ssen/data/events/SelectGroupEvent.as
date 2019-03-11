package ssen.data.events 
{
	import ssen.data.selectGroup.ISelectItem;
	
	import flash.events.Event;	
	/**
	 * SelectGroup 의 이벤트
	 * @author SSen
	 */
	public class SelectGroupEvent extends Event 
	{
		/** 아이템 추가 */
		public static const ADD_ITEM : String = "addItem";
		/** 아이템 삭제 */
		public static const DELETE_ITEM : String = "deleteItem";
		/** 모두 선택 */
		public static const SELECT_ALL : String = "selectAll";
		/** 모두 선택 해제 */
		public static const DESELECT_ALL : String = "deselectAll";
		/** 아이템 선택 */
		public static const SELECT_ITEM : String = "selectItem";
		/** 아이템 선택 해제 */
		public static const DESELECT_ITEM : String = "deselectItem";
		/** 아이템 정렬 됨 */
		public static const SORT_ITEMS : String = "sortItems";
		private var _item : ISelectItem;
		private var _multiSelect : Boolean;

		
		/** 생성자 */
		public function SelectGroupEvent(type : String, item : ISelectItem = null, multiSelect : Boolean = false, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			_item = item;
			_multiSelect = multiSelect;
		}
		/** 다중 선택 여부 */
		public function get multiSelect() : Boolean
		{
			return _multiSelect;
		}
		/** 아이템 */
		public function get item() : ISelectItem
		{
			return _item;
		}
		/** clone */
		override public function clone() : Event
		{
			return new SelectGroupEvent(type, item, multiSelect, bubbles, cancelable);
		}
		/** toString */
		override public function toString() : String
		{
			return formatToString("SelectGroupEvent", "type", "multiSelect", "item");
		}
	}
}
