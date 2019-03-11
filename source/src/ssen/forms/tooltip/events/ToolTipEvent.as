package ssen.forms.tooltip.events 
{
	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ToolTipEvent extends Event 
	{
		public static const CLOSED : String = "tooltipClosed";
		public function ToolTipEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
