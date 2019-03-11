package ssen.core.display.expanse 
{
	import ssen.core.display.expanse.SSenDisplayObjectContainerExpansion;
	
	import flash.display.Sprite;	
	/**
	 * ISSenSprite 인터페이스 구현
	 * @private
	 * @author SSen
	 */
	public class SSenSpriteExpansion extends SSenDisplayObjectContainerExpansion
	{
		/**
		 * 생성자 
		 * @param object 구현시킬 대상
		 */
		public function SSenSpriteExpansion(object : Sprite)
		{
			super(object);
		}
	}
}
