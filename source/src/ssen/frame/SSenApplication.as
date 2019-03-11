package ssen.frame 
{
	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class SSenApplication extends SSenSprite 
	{
		private var _wait : Boolean;
		public function get wait() : Boolean
		{
			return _wait;
		}
		public function set wait(wait : Boolean) : void
		{
			_wait = wait;
		}
	}
}
