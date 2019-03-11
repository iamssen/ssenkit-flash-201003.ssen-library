package test.text 
{
	import flash.text.TextField;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.net.URLLoader;

	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class XMLSelectTest extends SSenSprite 
	{
		private var _txt : TextField;

		
		public function XMLSelectTest()
		{
			_txt = new TextField();
			_txt.border = true;
			_txt.width = 400;
			_txt.height = 300;
			_txt.x = 10;
			_txt.y = 10;
			
			addChild(_txt);
			
			testXML("../test1.xml");
			testXML("../test2.xml");
		}
		private function testXML(url : String) : void
		{
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, complete);
			loader.load(new URLRequest(url));
		}
		private function complete(event : Event) : void
		{
			var xml : XML = new XML(event.target["data"]);
			for each (var x:XML in xml.l.i.e.(@id == "cccm1Cd")) {
				trace("$ : " + x.toXMLString());
				if (Number(x) == 7) {
					trace(x.parent().@id);
				}
			}
		}
	}
}
