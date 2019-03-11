package ssen.forms.labels 
{
	import ssen.core.utils.FormatToString;
	import ssen.forms.base.ISSenFormData;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextLableData implements ISSenFormData
	{
		private var _title : String;
		private var _comment : String;
		public function TextLableData(title : String, comment : String = null) 
		{
			_title = title;
			_comment = comment ? comment : title;
		}
		public function kill() : void
		{
		}
		public function toString() : String
		{
			return FormatToString.toString(this, "title", "comment");
		}
		public function clone() : ISSenFormData
		{
			return new TextLableData(_title, _comment);
		}
		public function get valueXML() : XML
		{
			return FormatToString.toXML(this, "title", "comment");
		}
		public function get title() : String
		{
			return _title;
		}
		public function set title(title : String) : void
		{
			_title = title;
		}
		public function get comment() : String
		{
			return _comment;
		}
		public function set comment(comment : String) : void
		{
			_comment = comment;
		}
	}
}
