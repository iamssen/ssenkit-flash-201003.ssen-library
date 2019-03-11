package ssen.data.selectGroup 
{
	import ssen.core.array.Values;
	import ssen.data.IDataModel;	
	/**
	 * List, ComboBox, SelectBoxGroup 에 사용되는 item 의 model
	 * @author SSen
	 */
	public interface ISelectItem extends IDataModel
	{
		/* *********************************************************************
		 * data
		 ********************************************************************* */
		/** 아이템의 아이디 == ISelectGroupModel 의 Vector length */
		function get id() : int
		function set id(id : int) : void
		/** 제목 */
		function get labelText() : String
		function set labelText(labelText : String) : void
		/** 대표 그림의 이름 */
		function get thumbnail() : String
		function set thumbnail(name : String) : void
		/** 선택됨 */
		function get selected() : Boolean
		function set selected(selected : Boolean) : void
		/** 추가 정보가 필요할 경우 생성한다 */
		function get values() : Values
		function set values(values : Values) : void
		/* *********************************************************************
		 * setting
		 ********************************************************************* */
		/** 아이템이 속해있는 ISelectGroupModel */
		function get group() : ISelectGroup
		function set group(group : ISelectGroup) : void
	}
}
