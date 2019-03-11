package ssen.data.selectGroup 
{
	import ssen.core.array.Values;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.events.ValueEvent;
	import ssen.core.utils.FormatToString;
	import ssen.data.IDataModel;
	import ssen.data.selectGroup.ISelectItem;	
	/**
	 * SelectItem
	 * @author SSen
	 */
	public class SelectItem extends SSenSprite implements ISelectItem
	{
		private var _id : int;
		private var _labelText : String;
		private var _thumbnail : String;
		private var _selected : Boolean;
		private var _group : ISelectGroup;
		private var _values : Values;

		
		/**
		 * 생성자
		 * @param id 아이디
		 * @param labelText 기본 제목
		 * @param thumbnail 썸네일 아이디
		 * @param selected 선택 상태
		 * @param values 추가 정보들
		 */
		public function SelectItem(id : int, labelText : String, thumbnail : String, selected : Boolean = false, values : Values = null)
		{
			this.id = id;
			this.labelText = labelText;
			this.thumbnail = thumbnail;
			this.selected = selected;
			this.values = values;
		}
		/* *********************************************************************
		 * implement ISelectItemModel
		 ********************************************************************* */
		/** @copy ssen.data.selectGroup.ISelectItem#id */
		public function get id() : int
		{
			return _id;
		}
		public function set id(id : int) : void
		{
			_id = id;
			dispatchEvent(new ValueEvent(ValueEvent.VALUE_CHANGED, "id", _id));
		}
		/** @copy ssen.data.selectGroup.ISelectItem#labelText */
		public function get labelText() : String
		{
			return _labelText;
		}
		public function set labelText(text : String) : void
		{
			_labelText = text;
			dispatchEvent(new ValueEvent(ValueEvent.VALUE_CHANGED, "labelText", _labelText));
		}
		/** @copy ssen.data.selectGroup.ISelectItem#thumbnail */
		public function get thumbnail() : String
		{
			return _thumbnail;
		}
		public function set thumbnail(name : String) : void
		{
			_thumbnail = name;
			dispatchEvent(new ValueEvent(ValueEvent.VALUE_CHANGED, "thumbnail", _thumbnail));
		}
		/** @copy ssen.data.selectGroup.ISelectItem#selected */
		public function get selected() : Boolean
		{
			return _selected;
		}
		public function set selected(selected : Boolean) : void
		{
			if (_selected != selected) {
				_selected = selected;
				dispatchEvent(new ValueEvent(ValueEvent.VALUE_CHANGED, "selected", _selected));
			}
		}
		/** @copy ssen.data.selectGroup.ISelectItem#values */
		public function get values() : Values
		{
			return _values;
		}
		public function set values(values : Values) : void
		{
			_values = values;
		}
		/** @copy ssen.data.selectGroup.ISelectItem#group */
		public function get group() : ISelectGroup
		{
			return _group;
		}
		public function set group(group : ISelectGroup) : void
		{
			_group = group;
			dispatchEvent(new ValueEvent(ValueEvent.VALUE_CHANGED, "parentGroup", _group));
		}
		/* *********************************************************************
		 * implement IDataModel
		 ********************************************************************* */
		/** @copy ssen.data.IDataModel#valueXML() */
		public function get valueXML() : XML
		{
			var item : XML = <item />;
			item["@labelText"] = labelText;
			item["@thumbnail"] = thumbnail;
			item["@selected"] = selected;
			
			if (values != null) {
				item.appendChild(values.getXML());
			}
			
			return item;
		}
		/** @copy ssen.data.IDataModel#resourceKill() */
		public function resourceKill() : void
		{
			_group = null;
			_values = null;
		}
		/** @copy ssen.data.IDataModel#clone() */
		public function clone() : IDataModel
		{
			return new SelectItem(id, labelText, thumbnail, selected, values);
		}
		/** @copy ssen.data.IDataModel#toString() */
		override public function toString() : String
		{
			return FormatToString.toString(this, "id", "labelText", "thumbnail", "selected");
		}
	}
}
