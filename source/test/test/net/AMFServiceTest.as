package test.net 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.events.RespondEvent;
	import ssen.core.net.AMFService;
	import ssen.core.net.AMFServiceResponder;
	/**
	 * @author ssen
	 */
	public class AMFServiceTest extends SSenSprite 
	{
		public function AMFServiceTest()
		{
			var service2 : AMFService = new AMFService("http://localhost:8080/blazeds/messagebroker/amf", "my-amf", "HelloWorld", "SessionTest");
			service2.call("getUserInfo", new AMFServiceResponder(testRespond));
			service2.call("sessionInfo", new AMFServiceResponder(testRespond));
			service2.call("sessionInfoaaa", new AMFServiceResponder(testRespond));
		}
		private function testRespond(event : RespondEvent) : void
		{
			trace(event);
			if (event.success) {
				for (var name : String in event.data) {
					trace(name, event.data[name]);
				}
			}
		}
	}
}
