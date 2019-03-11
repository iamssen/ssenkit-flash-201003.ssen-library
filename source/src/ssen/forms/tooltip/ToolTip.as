package ssen.forms.tooltip 
{
	import ssen.forms.tooltip.events.ToolTipEvent;

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ToolTip
	{
		public static var stage : Stage;
		public static var bank : Dictionary = new Dictionary();
		public static function open(tooltip : IToolTipObject, id : String) : void
		{
			if (bank[id] == undefined) stage.addChild(DisplayObject(tooltip));
			tooltip.open();
			tooltip.addEventListener(ToolTipEvent.CLOSED, tooltipclosed);
			tooltip.id = id;
			bank[id] = tooltip;
		}
		public static function close(id : String) : void
		{
			var tooltip : IToolTipObject = bank[id];
			tooltip.close();
		}
		private static function tooltipclosed(event : ToolTipEvent) : void 
		{
			var tooltip : IToolTipObject = IToolTipObject(event.target);
			tooltip.removeEventListener(ToolTipEvent.CLOSED, tooltipclosed);
			stage.removeChild(DisplayObject(tooltip));
			bank[tooltip.id] = null;
		}
	}
}
