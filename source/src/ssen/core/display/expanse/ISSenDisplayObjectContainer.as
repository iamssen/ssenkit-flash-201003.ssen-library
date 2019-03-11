package ssen.core.display.expanse 
{
	/**
	 * DisplayObjectContainer 확장 인터페이스
	 * @author SSen
	 */
	public interface ISSenDisplayObjectContainer extends ISSenInteractiveObject 
	{
		/** 복수의 자식을 addChild 시킨다 */
		function addChildren(...children : Array) : void;
		/** 복수의 자식을 removeChild 시킨다 */
		function removeChildren(...children : Array) : void;
	}
}
