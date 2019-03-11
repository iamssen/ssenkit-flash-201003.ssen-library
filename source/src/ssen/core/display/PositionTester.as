package ssen.core.display 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;	
	/**
	 * 위치정보들을 분석해주는 기능들의 모음
	 * @author SSen
	 */
	public class PositionTester 
	{
		/**
		 * mousePointer 가 Rectangle 안에 위치하는지를 확인
		 * @param where 영역체크의 기준이 될 DisplayObject
		 * @param rect 영역체크에 사용될 Rectangle
		 */
		public static function isPointerInRect(where : DisplayObject, rect : Rectangle) : Boolean
		{
			var sx : Number = where.mouseX;
			var sy : Number = where.mouseY;
			if (sx > rect.x && sx < rect.x + rect.width && sy > rect.y && sy < rect.y + rect.height) {
				return true;
			} 
			return false;
		}
		/** 위치값들로 계산했을때 스테이지 밖으로 벗어나는지를 확인 X */
		public static function isObjectBehindX(stageX : int, width : int, stageWidth : int) : Boolean
		{
			if (stageX < 0 || stageX + width > stageWidth) {
				return true;
			}
			return false;
		}
		/** 위치값들로 계산했을때 스테이지 밖으로 벗어나는지를 확인 Y */
		public static function isObjectBehindY(stageY : int, height : int, stageHeight : int) : Boolean
		{
			if (stageY < 0 || stageY + height > stageHeight) {
				return true;
			}
			return false;
		}
	}
}
