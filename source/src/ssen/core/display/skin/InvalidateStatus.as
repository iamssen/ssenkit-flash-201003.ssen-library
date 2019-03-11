package ssen.core.display.skin 
{
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	/**
	 * @author ssen
	 */
	public dynamic class InvalidateStatus extends Proxy
	{
		private var _status : Dictionary;
		private var _names : Vector.<String>;
		public dynamic function InvalidateStatus()
		{
			_status = new Dictionary();
			_names = new Vector.<String>();
		}
		public function get invalidate() : Boolean
		{
			var name : String;
			for (name in _status) {
				if (_status[name] == true) return true;
			}
			return false;
		}
		public function clear() : void
		{
			var name : String;
			for (name in _status) {
				delete _status[name];
			}
			_names.splice(0, _names.length);
		}
		/* *********************************************************************
		 * override proxy
		 ********************************************************************* */
		/** @private */
		override flash_proxy function deleteProperty(name : *) : Boolean
		{
			var n : String = String(name);
			if (_status[n] != undefined) {
				var i : int = _names.indexOf(n);
				_names.splice(i, 1);
				delete _status[n];
				return true;
			}
			return false;
		}
		/** @private */
		override flash_proxy function getProperty(name : *) : *
		{
			var n : String = String(name);
			return _status[n];
		}
		/** @private */
		override flash_proxy function hasProperty(name : *) : Boolean
		{
			var id : String = String(name);
			return _status[id] != undefined;
		}
		/** @private */
		override flash_proxy function setProperty(name : *, value : *) : void
		{
			var n : String = String(name);
			if (_status[n] == undefined) {
				_status[n] = value;
				_names.push(n);
			} else {
				_status[n] = value;
			}
		}
		/** @private */
		override flash_proxy function nextName(index : int) : String
		{
			return _names[index - 1];
		}
		/** @private */ 
		override flash_proxy function nextNameIndex(index : int) : int
		{
			return (index >= _names.length) ? 0 : index + 1;
		}
		/** @private */
		override flash_proxy function nextValue(index : int) : *
		{
			return _status[nextName(index)];
		}
	}
}
