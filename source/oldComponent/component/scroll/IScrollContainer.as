package ssen.component.scroll 
{
	import ssen.component.base.ISSenComponent;

	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;		
	/**
	 * @author SSen
	 */
	public interface IScrollContainer extends IEventDispatcher, ISSenComponent
	{
		/** container 의 가로크기 */
		function get containerWidth() : Number;
		/** container 의 세로크기 */
		function get containerHeight() : Number;
		/** content 의 가로크기 */
		function get contentWidth() : Number;
		/** content 의 세로크기 */
		function get contentHeight() : Number;
		/** scroll content displayObject */
		function get content() : DisplayObject;
		function set content(content : DisplayObject) : void;
		/** content 를 삭제한다 */
		function deleteContent() : void;
		/** content 의 size 가 변경되거나 할 경우 호출해서, 사이즈를 재정렬 시켜준다 */
		function refresh() : void;
		/** secX */
		function get secX() : Number;
		function set secX(sec : Number) : void;
		/** secY */
		function get secY() : Number;
		function set secY(sec : Number) : void;
		/** content 의 가로위치 */
		function get contentX() : Number;
		function set contentX(value : Number) : void;
		/** content 의 세로위치 */
		function get contentY() : Number;
		function set contentY(value : Number) : void;
		/** disable 시에 content 에 filter 적용 여부 */
		function get disableFilter() : Boolean
		function set disableFilter(bool : Boolean) : void
	}
}
