package ssen.core.display.expanse 
{
	import ssen.core.display.expanse.SSenDisplayObjectExpansion;
	
	import flash.display.InteractiveObject;	
	/**
	 * ISSenInteractiveObject 인터페이스 구현
	 * @private
	 * @author SSen
	 */
	public class SSenInteractiveObjectExpansion extends SSenDisplayObjectExpansion
	{
		/**
		 * 생성자 
		 * @param object 구현시킬 대상
		 */
		public function SSenInteractiveObjectExpansion(object : InteractiveObject)
		{
			super(object);
		}
	}
}
