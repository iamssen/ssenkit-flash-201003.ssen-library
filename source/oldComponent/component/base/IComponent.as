package ssen.component.base 
{
	import ssen.core.display.expanse.ISSenSprite;
	import ssen.core.display.base.ISprite;	
	/**
	 * @author SSen
	 */
	public interface IComponent extends ISprite, ISSenSprite
	{
		/** 활성화 상태 */
		function get enabled() : Boolean;
		function set enabled(enabled : Boolean) : void;
		/** 사용된 리소스들을 모두 제거한다 */
		function componentResourceKill() : void;
		/** 최하 사이즈 */
		function get minHeight() : Number;
		function get minWidth() : Number;
		/** 최대 사이즈 */
		function get maxHeight() : Number;
		function get maxWidth() : Number;
	}
}
