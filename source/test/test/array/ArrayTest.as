package test.array 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.number.MathEx;
	/**
	 * @author ssen
	 */
	public class ArrayTest extends SSenSprite 
	{
		public function ArrayTest()
		{
			var arr1 : Array = [1, 2, 3, 4, 5];
			trace(shake(arr1));
		}
		static public function shake(arr : Array) : Array 
		{
			var out : Array = new Array();
			while(true) {
				out.push(arr.splice(MathEx.rand(0, arr.length - 1), 1));
				if (arr.length <= 0) {
					return out;
				}
			}
			return out;
		}
	}
}
