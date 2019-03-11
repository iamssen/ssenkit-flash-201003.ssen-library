package test 
{
	import ssen.core.array.Values;
	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen
	 */
	public class ValuesTest extends SSenSprite 
	{
		public function ValuesTest()
		{
			var v1 : Values = new Values();
			var v2 : Values = new Values();
			
			v1["a"] = 1;
			v1["b"] = 2;
			v1["c"] = 3;
			v2["d"] = 4;
			
			v1.concat(v2);
			v2 = null;
			
			trace(v1);
		}
	}
}
