package ssen.data.selectGroup 
{
	import ssen.core.array.Values;
	import ssen.data.IDataModel;
	import ssen.data.selectGroup.ISelectItem;	
	/**
	 * List, ComboBox, SelectBoxGroup 에 사용되는 model
	 * @author SSen
	 */
	public interface ISelectGroup extends IDataModel 
	{
		/* *********************************************************************
		 * setting
		 ********************************************************************* */
		/** 아이템들 중 하나라도 선택된 게 있으면 true */
		function get selected() : Boolean
		/**
		 * 그룹의 선택방식 (하나만, 여러개)
		 * @see ssen.component.model.selectGroup.SelectType
		 */
		function get selectType() : String
		function set selectType(selectType : String) : void
		/* *********************************************************************
		 * items
		 ********************************************************************* */
		/** 선택된 아이템들 */
		function get selectedItems() : Vector.<ISelectItem>
		/** 모든 아이템들 */
		function get items() : Vector.<ISelectItem>
		/** 아이템의 갯수 */
		function get length() : int
		/** 특정 인덱스의 아이템을 가져온다 */
		function getItemAt(index : int) : ISelectItem
		/* *********************************************************************
		 * select interface
		 ********************************************************************* */
		/** 아이템을 선택한다 */
		function selectItem(item : ISelectItem) : void
		/** 아이템을 선택해제 한다 */
		function deselectItem(item : ISelectItem) : void
		/** 특정 인덱스의 아이템을 선택한다 */
		function selectItemAt(index : int) : void
		/** 특정 인덱스의 아이템을 선택해제 한다 */
		function deselectItemAt(index : int) : void
		/** 모든 아이템들을 선택한다 */
		function selectItemAll() : void
		/** 모든 아이템들을 선택해제 한다 */
		function deselectItemAll() : void
		/* *********************************************************************
		 * add, delete interface
		 ********************************************************************* */
		/** 새로운 아이템을 추가한다 */
		function addItem(labelText : String, thumbnail : String, selected : Boolean = false, values : Values = null) : ISelectItem
		/** 아이템을 제거한다 */
		function deleteItem(item : ISelectItem) : void
		/** 특정 인덱스의 아이템을 제거한다 */
		function deleteItemAt(index : int) : void
		/* *********************************************************************
		 * search, sort interface
		 ********************************************************************* */
		/** values 의 property 들 중 검색조건에 맞는 아이템들을 모은다 */
		function searchValuesProperty(propertyName : String, findText : String) : Vector.<ISelectItem>
		/** values 의 property 가 존재하는 아이템들을 모은다 */
		function hasValuesProperty(propertyName : String) : Vector.<ISelectItem>
		/** labelText 중 검색조건에 맞는 아이템들을 모은다 */
		function searchLabelText(findText : String) : Vector.<ISelectItem>
		/** values 의 proerty 를 기준으로 정렬시킨다 */
		function sortByValuesProperty(propertyName : String, asc : Boolean = true) : void
		/** labelText 를 기준으로 정렬시킨다 */
		function sortByLabelText(asc : Boolean = true) : void
	}
}
