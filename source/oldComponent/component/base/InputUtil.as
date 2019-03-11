package ssen.component.base 
{
	import flash.utils.getQualifiedClassName;		
	/**
	 * @author SSen
	 */
	public class InputUtil 
	{
		public static function valueTypeCheck(object : IInput, value : Object, valueType : Class) : Boolean 
		{
			if (value is valueType) {
				return true;
			} else {
				trace("SSEN//", getQualifiedClassName(object) + ".value 에 입력된 값이 " + valueType + " 이(가) 아닙니다.");
				return false;
			}
		}
	}
}
