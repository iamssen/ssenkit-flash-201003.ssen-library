package ssen.forms.buttons.events 
{
	import ssen.core.utils.FormatToString;
	import ssen.forms.buttons.ISSenButton;

	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ToggleMenuEvent extends Event 
	{
		public static const CHANGE : String = "toggleChange";
		private var _id : String;
		private var _button : ISSenButton;
		public function ToggleMenuEvent(type : String, id : String, button : ISSenButton = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			trace('bubbles: ' + (bubbles));
			super(type, bubbles, cancelable);
			_id = id;
			_button = button;
		}
		public function get id() : String
		{
			return _id;
		}
		override public function toString() : String 
		{
			return FormatToString.toString(this, "type", "id", "button");
		}
		public function get button() : ISSenButton
		{
			return _button;
		}
	}
}
