package test.flour.text 
{
	import ssen.flour.text.FlourTextAreaNormal;

	import test.flour.FlourTest;

	import flash.display.Sprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourTextAreaTest extends FlourTest 
	{
		private var _textarea : FlourTextAreaNormal;
		public function FlourTextAreaTest()
		{	
		}
		override protected function initialize() : void 
		{
			_textarea = new FlourTextAreaNormal();
			_textarea.width = stage.stageWidth;
			//, stage.stageHeight);
			addChild(_textarea);
			
			var sp : Vector.<Object> = new Vector.<Object>(5, true);
			sp[0] = new Sprite();
			trace(sp, sp.length, sp.indexOf(null));
		}
	}
}
