package examples.math.trigonometry 
{
	import examples.Example;			
	/**
	 * @author SSen
	 */
	public class TrigonometryChapter01 extends Example 
	{
		public function TrigonometryChapter01()
		{
			trace(1, pythagorasGetAB(5, 3));
			trace(2, pythagorasGetC(6, 8));
			trace(4, pythagorasGetC(7, 24));
			trace(5, pythagorasGetC(1, 1), Math.sqrt(2));
			trace(6, pythagorasGetC(1, 3), Math.sqrt(10));
			trace(7, pythagorasGetAB(65.27, 41.955));
			trace(8, pythagorasGetAB(3, 2.9544));
			
			trace(31, convertToMinuteAndSecond(16.5));
			trace(32, convertToMinuteAndSecond(22.333));
			trace(34, convertToMinuteAndSecond(0.202));
			
			trace(35, convertToDegree(12, 15, 0));
			trace(36, convertToDegree(34, 50, 0));
			trace(37, convertToDegree(0, 0, 4), convertToDegree(0, 0, 4).toExponential());
			trace(38, convertToDegree(5, 14, 4.8));
		}
		/* *********************************************************************
		 * 도, 분, 초 단위변환
		 * 1도 = 60분, 1분 = 60초
		 ********************************************************************* */
		private function convertToDegree(degree : Number, minute : Number, second : Number) : Number
		{
			return degree + (minute / 60) + (second / 60 / 60);
		}
		private function convertToMinuteAndSecond(degree : Number) : Vector.<Number>
		{
			var vec : Vector.<Number> = new Vector.<Number>(3, true);
			var division : Number = 1 / 60;
			
			var i : int = int(degree);
			vec[0] = i;
			
			var m : Number = (degree - i) / division;
			vec[1] = m;
			
			i = int(m);
			var s : Number = (m - i) / division;
			vec[2] = s;
			
			return vec;
		}
		/* *********************************************************************
		 * 피타고라스의 정리 - 직각삼각형에서
		 * c^2 = a^2 + b^2
		 * c^2 - a^2 = b^2
		 * 
		 * Math.sqrt --> sqare root (제곱근 구하기)
		 * Math.pow --> pow (거듭제곱 구하기)
		 ********************************************************************* */
		private function pythagorasGetAB(c : Number = 0, ab : Number = 0) : Number
		{
			return Math.sqrt(Math.pow(c, 2) - Math.pow(ab, 2));
		}
		private function pythagorasGetC(a : Number = 0, b : Number = 0) : Number
		{
			return Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2));
		}
	}
}
