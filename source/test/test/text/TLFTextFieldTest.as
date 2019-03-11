package test.text 
{
	import flash.text.TextFieldType;
	import flashx.textLayout.controls.TLFTextField;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.events.RespondEvent;
	import ssen.core.net.ResourceLoader;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TLFTextFieldTest extends SSenSprite 
	{
		private var _loader : ResourceLoader;
		private var _tf : TLFTextField;

		
		public function TLFTextFieldTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_loader = new ResourceLoader();
			_loader.addEventListener(RespondEvent.RESPOND, respond, false, 0, true);
			_loader.load(new URLRequest("NanumGothic.swf"), new LoaderContext(false, loaderInfo.applicationDomain));
		}
		private function respond(event : RespondEvent) : void
		{
			if (event.success) {
				var nanumGothic : Class = _loader.contentLoaderInfo.applicationDomain.getDefinition("ssen.library.fonts.NanumGothic") as Class;
				nanumGothic["initialize"]();
				
				start();
			}
		}
		private function start() : void
		{
			_tf = new TLFTextField();
			_tf.x = 10;
			_tf.y = 10;
			_tf.type = TextFieldType.INPUT;
			_tf.width = 300;
			_tf.height = 200;
			_tf.border = true;
			
			addChildren(_tf);
		}
	}
}
