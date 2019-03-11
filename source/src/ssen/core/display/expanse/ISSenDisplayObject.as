package ssen.core.display.expanse 
{
	import flash.display.Sprite;
	import flash.geom.Point;	
	/**
	 * DisplayObject 확장 인터페이스
	 * @author SSen
	 */
	public interface ISSenDisplayObject
	{
		/** Stage 기준 position point */
		function get globalPosition() : Point
		function set globalPosition(point : Point) : void
		/** Stage 기준 X position */
		function get globalX() : Number
		function set globalX(value : Number) : void
		/** Stage 기준 Y position */
		function get globalY() : Number
		function set globalY(value : Number) : void
		/** x, y 위치 */
		function get position() : Point
		function set position(point : Point) : void
		/** 다음 X 위치 */
		function nextX(spaceX : int = 0) : Number
		/** 다음 Y 위치 */
		function nextY(spaceY : int = 0) : Number
		/** index */
		function get index() : int
		function set index(index : int) : void
		/** 오른쪽 다음 위치 */
		function nextPosition(spaceX : int = 5) : Point
		/** 아랫 라인 다음 위치 */
		function nextPositionBr(spaceY : int = 5) : Point
		/** 위치를 Stage 위로 올리거나 내린다 */
		function get hover() : Boolean
		function set hover(hover : Boolean) : void
		/** stage 아래의 최상단 root 를 가져온다 */
		function get canvas() : Sprite
		/** x, y 위치 */
		function moveXY(x : Number, y : Number) : void
		/** width, height 편집 */
		function setSize(width : Number, height : Number) : void
	}
}
