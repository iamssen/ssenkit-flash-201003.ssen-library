package examples.math.trigonometry 
{
	import ssen.core.number.MathEx;	
	
	import examples.Example;
	/**
	 * @author SSen
	 */
	public class TrigonometryChapter03 extends Example 
	{
		public function TrigonometryChapter03()
		{
			/* *********************************************************************
			 * title
			 ********************************************************************* */
			var a : int = 5;
			var b : int = 5;
			var c : Number = Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2));
			
			var s : Number = b / c;
			var t : Number = b / a;
			
			tracer("조건들 a, b, c, s, t", a, b, c, s, t);
			
			tracer("밑변 a 의 길이로 높이 b 찾기", t * b);
			tracer("높이 b 의 길이로 밑변 a 찾기", b / t);
			tracer("높이 b 의 길이로 빗변 c 찾기", b / s);
			tracer("빗변 c 의 길이로 높이 b 찾기", s * c);
			tracer("밑변 a 와 높이 b 로 빗변 c 찾기", Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2)));
			trace(Math.sin(MathEx.RADIAN[45]), b/c);
		}
	}
}
