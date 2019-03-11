package examples
{
	import ssen.core.display.expanse.SSenSprite;
	/**
	 * Description
	 * @author SSen
	 */
	public class Example extends SSenSprite
	{
		private var cnt : int = 1;

		public function Example()
		{
			super();
		}
		protected function tracer(title : String, ...args : Array) : void
		{
			trace(cnt + " : ", title);
			var str : String = args[0];
			for (var i : int = 1;i < args.length; i++) {
				str += " " + args[i];
			}
			trace(str);
			trace("-------------------------------------------------------------------------");
			cnt++;
		}
	}
}
 