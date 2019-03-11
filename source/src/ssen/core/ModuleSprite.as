package ssen.core 
{
	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ModuleSprite extends SSenSprite
	{
		private var _initialized : Boolean;
		private var _setted : Boolean;
		private var _registed : Boolean;
		protected function get initialized() : Boolean
		{
			return _initialized;
		}
		public function initialze(config : IModuleConfig = null) : Boolean
		{
			if (_initialized) return false;
			_initialized = true;
			return true;
		}
		public function setting(config : IModuleConfig = null) : Boolean
		{
			if (!_initialized && _setted) return false;
			_setted = true;
			return true;
		}
		public function register(config : IModuleConfig = null) : Boolean
		{
			if (!_initialized && !_setted && _registed) return false;
			_registed = true;
			return true;
		}
		public function unregister() : Boolean
		{
			if (!_registed) return false;
			_registed = false;
			return true;
		}
		public function kill() : Boolean
		{
			if (_registed && !_setted) return false;
			_setted = false;
			return true;
		}
		public function destroy() : Boolean
		{
			if (_registed && _setted) return false;
			return true;
		}
		protected function get setted() : Boolean
		{
			return _setted;
		}
		protected function get registed() : Boolean
		{
			return _registed;
		}
	}
}
