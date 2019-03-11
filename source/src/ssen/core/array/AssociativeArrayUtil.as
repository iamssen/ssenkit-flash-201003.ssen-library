package ssen.core.array 
{
	/**
	 * 연관배열을 다루는데 필요한 도구들 모음
	 * @author SSen
	 */
	public class AssociativeArrayUtil 
	{
		/**
		 * 배열의 요소의 갯수를 센다.
		 * @param arr 대상 배열
		 */
		public static function n(arr : Array) : int 
		{
			var f : *;
			var cnt : int = 0;

			for each (f in arr) {
				cnt++;
			}

			return cnt;
		}
	}
}
