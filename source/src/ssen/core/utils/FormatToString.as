package ssen.core.utils 
{
	import flash.utils.getQualifiedClassName;				
	/**
	 * trace 시킬때 사용하는 도구들
	 * @author SSen
	 */
	public class FormatToString 
	{
		/** toString 포맷 */
		public static function toString(cl : Object, ...properties) : String
		{
			var c : String = "[" + getQualifiedClassName(cl).split("::")[1];
			var f : int = -1;
			while(++f < properties.length) {
				c += ' ' + properties[f] + '="' + cl[properties[f]] + '"';
			}
			return c + "]";
		}
		public static function toXML(object : Object, ...properties) : XML
		{
			var xml : XML = new XML("<" + getQualifiedClassName(object) + " />");
			var f : int = -1;
			while(++f < properties.length) {
				xml["@" + properties[f]] = object[properties[f]];
			}
			return xml;
		}
		/** 에러 메세지를 보내준다 */
		public static function ssenErrorTrace(...messages) : void
		{
			messages.unshift("SSEN//");
			trace.apply(null, messages);
		}
	}
}
