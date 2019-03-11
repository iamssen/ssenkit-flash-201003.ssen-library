package ssen.core.array 
{
	/**
	 * 집합을 다루는데 필요한 도구들 모음
	 * @author SSen
	 */
	public class SetUtil 
	{
		/**
		 * 교집합, 두 집합간의 공통항목을 반환한다.
		 */
		public static function setsIntersection(...sets) : Array 
		{
			var f : *;
			var s : *;
			var cnt : int;
			var setX : Array = sets[0];
			var target : Array;
			var temp : Array;
			
			for (cnt = 1;cnt <= sets.length - 1; cnt++) {
				target = sets[cnt];
				temp = new Array();
				for each (f in target) {
					for each (s in setX) {
						if (f === s && !ArrayUtil.findElement(s, temp)) {
							temp.push(s);
							break;
						}
					}
				}
				setX = temp;
			}
			
			return setX;
		}
		/**
		 * 합집합, 두 집합의 요소를 합해서 반환한다 (공통항목은 병합)
		 */
		public static function setsSum(...sets) : Array 
		{
			var f : *;
			var s : *;
			var cnt : int;
			var same : Boolean;
			var setX : Array = sets[0];
			var target : Array;
			
			for (cnt = 1;cnt <= sets.length - 1; cnt++) {
				target = sets[cnt];
				for each (f in target) {
					same = false;
					for each (s in setX) {
						if (f === s) {
							same = true;
						}
					}
					if (!same) {
						setX.push(f);
					}
				}
			}
			
			return setX;
		}
		/**
		 * 차집합, 집합A 에서 집합B 를 뺀 후 반환한다.
		 * @param setA 기준 집합체
		 * @param setB 삭제할 대상들의 집합
		 */
		public static function setsDifference(setA : Array, setB : Array) : Array 
		{
			var f : *;
			var s : *;
			var setX : Array = new Array();

			for each (f in setA) {
				var same : Boolean = false;

				for each (s in setB) {
					if (f === s) {
						same = true;
					}
				}

				if (!same) {
					setX.push(f);
				}
			}

			return setX;
		}
		/**
		 * 여집합, 전체가 될 유한집합에서 부분집합B 를 제외한 부분을 반환한다.
		 * @param setU 기준이 되는 전체집합
		 * @param setB 제외될 부분집합
		 */
		public static function setsComplementary(setU : Array, setB : Array) : Array 
		{
			setB = setsIntersection(setU, setB);

			var f : *;
			var s : *;
			var setX : Array = new Array();

			for each (f in setU) {
				var same : Boolean = false;

				for each (s in setB) {
					if (f === s) {
						same = true;
					}
				}

				if (!same) {
					setX.push(f);
				}
			}

			return setX;
		}
	}
}
