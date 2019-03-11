package test.net 
{
	import ssen.debug.TestButtonGroup;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author ssen
	 */
	public class ExtLoadTestB extends Sprite 
	{
		public function ExtLoadTestB()
		{
			var tg : TestButtonGroup = new TestButtonGroup("fire event", fireEvent);
			tg.moveXY(10, 10);
			addChild(tg);
		}
		private function fireEvent() : void
		{
			dispatchEvent(new Event("fire", true));
		}
	}
}
