package ssen.forms.base 
{
	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface ISSenForm 
	{
		/** 활성화 상태 */
		function get enabled() : Boolean
		function set enabled(enabled : Boolean) : void
		/** 데이터 */
		function get data() : ISSenFormData
		function set data(data : ISSenFormData) : void
		/** 비사용 상태로 초기화 한다 */
		function kill() : void
		/** 사용된 리소스들을 모두 제거한다 */
		function deconstruction() : void
		/** 초기화 되어있는지 확인한다 */
		function get initialized() : Boolean
		function get formWidth() : Number
		function set formWidth(width : Number) : void
		function get formHeight() : Number
		function set formHeight(height : Number) : void
		function setFormSize(width : Number, height : Number) : void
	}
}
