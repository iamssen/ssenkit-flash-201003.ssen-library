package ssen.component.panels 
{
	import gs.TweenLite;
	
	import mx.effects.easing.Quadratic;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;	
	/**
	 * Alert, Confirm, Prompt 등을 관리한다
	 * @author SSen
	 */
	public class Panel 
	{
		/** [사용전 필수 셋팅] stage 를 입력해준다 */
		public static var stage : Stage;
		/** [사용전 필수 셋팅] addChild 될 canvas 들 */
		public static var canvases : Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		/** canvasFilter 미입력시 기초 작동할 필터 */
		public static var defaultCanvasFilters : Array;

		
		/**
		 * Panel 을 연다
		 * @param panel 띄울 panelObject
		 * @param canvasFilters 차단효과를 대신할 bitmapFilters
		 * @param panelX 패널의 X 위치 (기본 중앙정렬)
		 * @param panelY 패널의 Y 위치 (기본 중앙정렬)
		 */
		public static function open(panel : IPanelObject, stageLevel : int = 0, canvasFilters : Array = null, panelX : int = -1, panelY : int = -1) : IPanelObject
		{
			var stage : DisplayObjectContainer = canvases[stageLevel];
			var canvas : DisplayObjectContainer = canvases[stageLevel + 1];
			
			// canvas event, filter 처리 
			canvas.filters = (canvasFilters != null) ? canvasFilters : defaultCanvasFilters;
			canvas.mouseEnabled = false;
			canvas.mouseChildren = false;
			
			align(panel, panelX, panelY);
			stage.addChild(DisplayObject(panel));
			panel.alpha = 0;
			panel.y += 10;
			TweenLite.to(panel, 0.2, {alpha:1, y:(panel.y - 10), ease:Quadratic.easeInOut});
			
			return panel;
		}
		/** Panel 을 닫는다 */
		public static function close(panel : IPanelObject, stageLevel : int = 0) : void
		{
			var stage : DisplayObjectContainer = canvases[stageLevel];
			var canvas : DisplayObjectContainer = canvases[stageLevel + 1];
			
			stage.removeChild(DisplayObject(panel));
			canvas.filters = null;
			canvas.mouseEnabled = true;
			canvas.mouseChildren = true;
		}
		/* *********************************************************************
		 * Utils
		 ********************************************************************* */
		// 패널을 정렬한다
		private static function align(panel : IPanelObject, x : int = -1, y : int = -1) : void
		{
			if (x < 0 || y < 0) {
				x = (stage.stageWidth >> 1) - (panel.width >> 1);
				var h : int = stage.stageHeight >> 3;
				y = (h * 3) - (panel.height >> 1);
			}
			if (x < 0) x = 0;
			if (y < 0) y = 0;
			panel.x = x;
			panel.y = y;
		}
	}
}
