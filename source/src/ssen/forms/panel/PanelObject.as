package ssen.forms.panel 
{
	import flash.display.DisplayObjectContainer;

	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class PanelObject extends SSenSprite implements IPanelObject
	{
		private var _id : int;
		private var _rise : Boolean;
		public function get id() : int
		{
			return _id;
		}
		public function set id(id : int) : void
		{
			_id = id;
		}
		public function get rise() : Boolean
		{
			return _rise;
		}
		public function set rise(rise : Boolean) : void
		{
			_rise = rise;
			mouseChildren = rise;
			mouseEnabled = rise;
		}
		public function register(parent : DisplayObjectContainer = null, index : int = -1) : Boolean
		{
			// TODO: Auto-generated method stub
			return null;
		}
		public function deregister() : Boolean
		{
			// TODO: Auto-generated method stub
			return null;
		}
	}
}
