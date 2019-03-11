package examples.math 
{
	import examples.Example;
	/**
	 * 수학공식 모음
	 * @author SSen
	 */
	public class MathExample extends Example 
	{
		public function MathExample()
		{
			super();
			
			tracer("일부값/전체값 퍼센트", "50(일부값)/1000(전체값)*100 =", 50 / 1000 * 100);
			tracer("전체값의 X 퍼센트", "1000(전체값)*50(퍼센트)/100 =", 1000 * 50 / 100);
			tracer("숫자를 X 퍼센트 증가시킴", "100(숫자)*(1+50(퍼센트)/100) =", 100 * (1 + 50 / 100));
			tracer("숫자를 X 퍼센트 감소시킴", "100(숫자)*(1-50(퍼센트)/100) =", 100 * (1 - 50 / 100));
			for (var i:int = 0; i<=15; i++) {
				trace(i%1, i);
			}
		}
	}
}
