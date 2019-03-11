package ssen.forms.base 
{
	import flashx.textLayout.formats.TextLayoutFormat;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class DefaultTextFormat 
	{
		private static var _lable : TextLayoutFormat;
		public static function lable(size : int = 12, color : uint = 0x000000, textAlign : String = "center", verticalAlign : String = "middle") : TextLayoutFormat
		{
			if (!_lable) {
				_lable = new TextLayoutFormat();
				_lable.fontFamily = "dotum, Arial, Verdana, _sans"; 
				_lable.textAlpha = 1;
			}
			_lable.fontSize = size;
			_lable.color = color;
			_lable.textAlign = textAlign;
			_lable.verticalAlign = verticalAlign;
			return _lable;
		}
	}
}
