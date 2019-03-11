package ssen.component.scroll 
{
	import ssen.component.base.IInput;
	import ssen.component.base.ISSenComponent;
	import ssen.core.display.expanse.ISSenSprite;
	import ssen.core.display.base.ISprite;		
	/**
	 * @author SSen
	 */
	public interface IScroller extends ISprite, ISSenComponent, IInput, ISSenSprite
	{
		/** 최소값 */
		function get minValue() : Number;
		function set minValue(minValue : Number) : void;
		/** 최대값 */
		function get maxValue() : Number;
		function set maxValue(maxValue : Number) : void;
		/** 현재 위치의 0~1 값 */
		function get sec() : Number
		function set sec(sec : Number) : void
		/**
		 * wheel 이벤트에 대한 수신
		 * @param delta event.delta Mouse 이벤트 객체의 delta 값
		 */
		function wheel(delta : int) : void
		function init(container : IScrollContainer, sec : Number = 0, isTrackHide : Boolean = false, trackMode : String = "point", minValue : Number = 0, maxValue : Number = 0) : void;
		/** scroll container */
		function get container() : IScrollContainer
		function set container(container : IScrollContainer) : void
		/** thumb / track 의 비율값 */
		function get sight() : Number
		/** 
		 * page (화면의 보여지는 영역이 한페이지) 단위로 이동합니다
		 * @param delta 몇 페이지를 어느 방향으로 이동시킬지 지정합니다, 상방향 이동은 -1 등으로 지정
		 */
		function page(delta : int) : void
		/**
		 * content 의 x (혹은 y) 위치를 직접적으로 컨트롤 합니다
		 */
		function moveContent(pixel : int) : void
		/** scroll 이 가능한 상태인지 확인 */
		function get scrollEnable() : Boolean;
	}
}
