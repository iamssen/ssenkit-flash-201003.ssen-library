package ssen.forms.scroll 
{
	import de.polygonal.core.ObjectPool;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ScrollBarPool 
	{
		private static var _pool : ObjectPool;
		public static function get scroll() : ScrollBar
		{
			if (!_pool) {
				_pool = new ObjectPool();
				_pool.allocate(10, ScrollBar);
			}
			return _pool.object;
		}
		public static function set scroll(scroll : ScrollBar) : void
		{
			if (_pool) _pool.object = scroll;
		}
	}
}
