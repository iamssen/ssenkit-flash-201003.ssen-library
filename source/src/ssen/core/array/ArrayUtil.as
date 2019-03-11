package ssen.core.array 
{
	import ssen.core.number.MathEx;		
	/**
	 * 배열을 다루는데 필요한 도구들 모음
	 * @author SSen
	 */
	public class ArrayUtil
	{
		/**
		 * 배열을 무작위로 섞는다.
		 * @param arr 원본 배열
		 */
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
		/**
		 * 배열안에 특정 요소가 있는지 확인한다.
		 * @param el 검색할 요소
		 * @param arr 대상 배열
		 */
		static public function findElement(el : *, arr : Array) : Boolean 
		{
			return arr.indexOf(el) > -1;
		}
		/**
		 * 배열안에 특정 요소를 삭제한다.
		 * @param el 삭제할 요소
		 * @param arr 대상 배열
		 * @includeExample IncludeTest.as
		 */
		public static function delElement(el : *, arr : Array) : Array 
		{
			var index : int = arr.indexOf(el);
			arr.splice(index, 1);
			return arr;
		}
	}
}