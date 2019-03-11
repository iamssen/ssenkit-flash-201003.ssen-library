package ssen.forms.panel.events 
{
	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class PanelEvent extends Event 
	{
		public static const CLOSE_ANIMATION_END : String = "panelClose";
		public function PanelEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
