package test.flour.scroll 
{
	import ssen.flour.scroll.FlourScrollPaneNormal;
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
			_pane = new FlourScrollPaneNormal(content, 550, 400);
			_pane.x = 0;
			_pane.y = 0;
			
			addChildren(_pane);
		}
	}
}
