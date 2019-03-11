package test.net 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * @author ssen
	 */
	public class ExtLoadTestA extends Sprite
	{
		private var loader : Loader;

		
		public function ExtLoadTestA()
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.load(new URLRequest("ExtLoadTestB.swf"));
			addChild(loader);
		}
		private function complete(event : Event) : void
		{
			addEventListener("fire", catchFire, true);
		}
		private function catchFire(event : Event) : void
		{
			trace(event);
		}
	}
}
