package ssen.debug 
{
	/**
	 * 여러가지 trace 기능 모음
	 * @author SSen
	 */
	public class Tracer 
	{
		/**
		 * for in 을 돌릴수 있는 object 를 string 으로 해석해준다 
		 */
		public static function objectToString(object : Object) : String
		{
			var str : String = "";
			var name : String;
			for (name in object) {
				if (str != "") str += " ";
				str += name + "=" + object[name];
			}
			return str;
		}
	}
}
