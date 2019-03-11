package ssen.forms.scroll 
{
	import ssen.forms.base.ISSenForm;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface ISSenScrollbar extends ISSenForm
	{
		function get maxScrollPosition() : Number
		function set maxScrollPosition(maxScrollPosition : Number) : void
		function get minScrollPosition() : Number
		function set minScrollPosition(minScrollPosition : Number) : void
		function get pageSize() : Number
		function set pageSize(pageSize : Number) : void
		function get scrollPosition() : Number
		function set scrollPosition(scrollPosition : Number) : void
		/** 현재 위치의 0~1 값 */
		function get scrollPositionRatio() : Number
		function set scrollPositionRatio(ratio : Number) : void
		/** thumb / track 의 비율값 */
		function get scrollSightRatio() : Number
		/** scroll 이 가능한 상태인지 확인 */
		function get scrollEnable() : Boolean
		function get direction() : String
	}
}
