package test.flour.scroll 
{
	import ssen.component.scroll.IScrollPane;
	import ssen.debug.TestBoxes;
	import ssen.flour.scroll.FlourScrollPaneThin;
	
	import test.flour.FlourTest;
	
	import flash.display.DisplayObject;		
	/**
	 * @author SSen
	 */
	public class FlourScrollTest extends FlourTest 
	{
		private var _pane : IScrollPane;

		override protected function initialize() : void
		{
			var content : DisplayObject = TestBoxes.getLineBox();
			_pane = new FlourScrollPaneThin(content);
			_pane.x = 10;
			_pane.y = 10;
			
			addChildren(_pane);
		}
	}
}
