package ssen.forms.textInput 
{
	import ssen.core.number.NumberUtil;
	import ssen.forms.base.ISSenFormData;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextInputData implements ISSenFormData
	{
		private var _text : String;
		private var _type : String;
		private var _frontMark : String;
		private var _backMark : String;
		public function TextInputData(text : String, type : String = "all", frontMark : String = "", backMark : String = "") 
		{
			_text = text;
			_type = type;
			_frontMark = frontMark;
			_backMark = backMark;
		}
		public function get formatedText() : String
		{
			var text : String;
			switch (_type) {
				case TextInputType.NUMBER :
					text = NumberUtil.comma(_text, null, "-");
					if (text != "-") text = _frontMark + text + _backMark;
					break;
				case TextInputType.PASSWORD :
					text = "****";
					break;
				default :
					text = _text;
					if (text != "") text = _frontMark + text + _backMark;
					break;
			}
			return text;
		}
		public function kill() : void
		{
		}
		public function toString() : String
		{
			return _text;
		}
		public function clone() : ISSenFormData
		{
			return new TextInputData(_text, type);
		}
		public function get valueXML() : XML
		{
			return new XML("<TextInputData type=\"" + _type + "\">" + _text + "</TextInputData>");
		}
		public function get text() : String
		{
			return _text;
		}
		public function set text(text : String) : void
		{
			_text = text;
		}
		public function get frontMark() : String
		{
			return _frontMark;
		}
		public function set frontMark(frontMark : String) : void
		{
			_frontMark = frontMark;
		}
		public function get backMark() : String
		{
			return _backMark;
		}
		public function set backMark(backMark : String) : void
		{
			_backMark = backMark;
		}
		public function get type() : String
		{
			return _type;
		}
		public function set type(type : String) : void
		{
			_type = type;
		}
	}
}
