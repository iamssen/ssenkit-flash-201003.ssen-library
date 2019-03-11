package test.flour.display 
{
	import ssen.component.buttons.IButton;
	import ssen.component.buttons.LabelButton;
	import ssen.component.events.PanelEvent;
	import ssen.component.panels.IPanelObject;
	import ssen.component.panels.Panel;
	import ssen.core.display.SSenSprite;
	import ssen.core.number.MathEx;
	import ssen.debug.TestButtonGroup;
	import ssen.flour.buttons.FlourButtonXClose;
	import ssen.flour.buttons.FlourLabelButtonGray;
	import ssen.flour.panels.FlourAlert;
	import ssen.flour.text.FlourFont;
	
	import test.flour.FlourTest;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;	
	/**
	 * @author SSen
	 */
	public class FlourDisplayTest extends FlourTest 
	{
		private var alert : FlourAlert;
		private var labelButtonGray1 : FlourLabelButtonGray;

		override protected function initialize() : void
		{
			var xCloseButton : IButton = new FlourButtonXClose();
			xCloseButton.x = 10;
			xCloseButton.y = 10;
			
			labelButtonGray1 = new FlourLabelButtonGray("확인");
			labelButtonGray1.position = xCloseButton.nextPosition();
			labelButtonGray1.addEventListener(MouseEvent.CLICK, labelButtonGrayClick);
			labelButtonGray1.autoWidth = true;
			
			Panel.stage = stage;
			alert = new FlourAlert("치명적인 에러 808080 이 발생하여\n<b>어플리케이션을</b> 임시적으로 종료합니다.\n자세한 문의사항은 080-1134-5858 로 문의바랍니다.", true);
			var test : TestButtonGroup = new TestButtonGroup("label button title change", labelButtonTitleChange, "content thickness change", contentThicknessChange);
			test.position = xCloseButton.nextPositionBr(100);
			
			addChildren(test, xCloseButton, labelButtonGray1);
		}
		
		private function contentThicknessChange() : void
		{
			FlourFont.contentFontRender.thickness = MathEx.rand(-200, 200);
		}
		private function labelButtonTitleChange() : void
		{
			labelButtonGray1.text = "changed text";
		}
		private function labelButtonGrayClick(event : MouseEvent) : void
		{
			Panel.open(alert, [new BlurFilter()]);
			alert.addEventListener(PanelEvent.PANEL_CANCEL, panelClose);
		}
		private function panelClose(event : PanelEvent) : void
		{
			log(event.target);
			Panel.close(IPanelObject(event.target));
		}
	}
}
