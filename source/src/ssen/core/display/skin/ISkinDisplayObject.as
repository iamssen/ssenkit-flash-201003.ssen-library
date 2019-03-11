package ssen.core.display.skin 
{
	import ssen.core.display.base.IDisplayObject;
	import ssen.core.display.expanse.ISSenDisplayObject;
	/**
	 * 스킨 인터페이스
	 * @author SSen
	 */
	public interface ISkinDisplayObject extends IDisplayObject, ISSenDisplayObject
	{
		/**
		 * 스킨을 그린다
		 * @param flag 그릴 스킨의 상태 이름
		 */
		function skinDraw(flag : String) : void
		/** 현재 스킨의 상태 이름 */
		function get skinFlag() : String
		/** 사용된 리소스들을 제거해준다 */
		function kill() : void
	}
}
