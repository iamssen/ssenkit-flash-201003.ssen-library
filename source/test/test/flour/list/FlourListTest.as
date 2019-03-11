package test.flour.list 
{
	import ssen.component.checkBox.CheckBoxGroup;
	import ssen.data.events.SelectGroupEvent;
	import ssen.data.selectGroup.ISelectGroup;
	import ssen.data.selectGroup.SelectGroup;
	import ssen.data.selectGroup.SelectType;
	import ssen.flour.input.FlourComboBox;
	import ssen.flour.list.FlourLabelList;
	
	import test.flour.FlourTest;
	
	import flash.geom.Point;	
	/**
	 * @author SSen
	 */
	public class FlourListTest extends FlourTest 
	{
		private var _model : ISelectGroup;
		private var _list : FlourLabelList;
		private var _group : CheckBoxGroup;
		private var _combo : FlourComboBox;

		override protected function initialize() : void
		{
			_model = new SelectGroup(SelectType.SINGLE_SELECT);
			_model.addItem("ActionScript 3.0", "page");
			_model.addItem("PHP", "page");
			_model.addItem("C++", "folder");
			_model.addItem("C#", "folder");
			_model.addItem("JavaScript", "page");
			_model.addItem("XBAP", "page");
			_model.addItem("MXML", "folder");
			_model.addItem("Lua", "folder");
			_model.addItem("Python", "page");
			_model.addItem("쎈과 서연", "page");
			_model.addItem("한글테스트", "folder");
			
			_model.addEventListener(SelectGroupEvent.ADD_ITEM, selectGroupEventHandle);
			_model.addEventListener(SelectGroupEvent.DELETE_ITEM, selectGroupEventHandle);
			_model.addEventListener(SelectGroupEvent.DESELECT_ALL, selectGroupEventHandle);
			_model.addEventListener(SelectGroupEvent.DESELECT_ITEM, selectGroupEventHandle);
			_model.addEventListener(SelectGroupEvent.SELECT_ALL, selectGroupEventHandle);
			_model.addEventListener(SelectGroupEvent.SELECT_ITEM, selectGroupEventHandle);
			_model.addEventListener(SelectGroupEvent.SORT_ITEMS, selectGroupEventHandle);
			
			_list = new FlourLabelList(110, 150, 17, _model);
			_list.position = new Point(10, 10);
			
			_group = new CheckBoxGroup(300, 5, 5, _model);
			_group.position = _list.nextPosition(25);
			
			_combo = new FlourComboBox(120, _model);
			_combo.position = _group.nextPositionBr(10);
			
			addChildren(_list, _group, _combo);
		}
		private function selectGroupEventHandle(event : SelectGroupEvent) : void
		{
			trace(event);
			
			if (event.type == SelectGroupEvent.SELECT_ITEM) {
				_list.moveToSelectedY();
			}
		}
	}
}
