package ssen.component.events 
{
	import ssen.core.array.Values;

	import flash.events.Event;		
	/**
	 * @author SSen
	 */
	public class PanelEvent extends Event 
	{
		/** confirm 에서 ok 클릭시 */
		public static const PANEL_OK : String = "panelOk";
		/** confirm 에서 cancel 클릭시 */
		public static const PANEL_CANCEL : String = "panelCancel";
		// prompt data
		private var _values : Values;

		
		/**
		 * Panel 이 IPanelObject 로 부터 수신하는 Event
		 * @param values prompt 일때 작성된 데이터 그룹
		 */
		public function PanelEvent(type : String, values : Values = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_values = values;
		}
		/** prompt 일때 작성된 데이터 그룹 */
		public function get values() : Values
		{
			return _values;
		}
		override public function clone() : Event
		{
			return new PanelEvent(type, values, bubbles, cancelable);
		}
		/** @private */
		override public function toString() : String
		{
			return '[PanelEvent type="' + type + '"]';
		}
	}
}
