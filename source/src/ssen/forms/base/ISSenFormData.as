package ssen.forms.base 
{
	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface ISSenFormData 
	{
		/** 컴포넌트의 데이터들을 xml 형태로 정리해서 리턴한다 */
		function get valueXML() : XML;
		/** 컴포넌트의 리소스들을 제거해준다 */
		function kill() : void
		/** toString */
		function toString() : String
		/** clone */
		function clone() : ISSenFormData
	}
}
