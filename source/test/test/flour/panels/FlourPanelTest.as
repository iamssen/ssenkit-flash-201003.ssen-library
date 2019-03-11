package test.flour.panels 
{
	import ssen.component.buttons.IButton;
	import ssen.component.events.PanelEvent;
	import ssen.component.panels.IPanelObject;
	import ssen.component.panels.Panel;
	import ssen.core.array.Values;
	import ssen.core.text.FontRender;
	import ssen.core.text.SSenTextField;
	import ssen.flour.buttons.FlourLabelButtonGray;
	import ssen.flour.panels.FlourAlert;
	import ssen.flour.panels.FlourFontSetting;
	import ssen.flour.text.FlourFont;

	import test.flour.FlourTest;

	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;		
	/**
	 * @author SSen
	 */
	public class FlourPanelTest extends FlourTest 
	{
		override protected function initialize() : void
		{
			Panel.stage = stage;
			Panel.canvases.push(stage, this);
			Panel.defaultCanvasFilters = [new BlurFilter()];
			
			var btnAlert : IButton = new FlourLabelButtonGray("Open Alert");
			btnAlert.position = new Point(10, 10);
			btnAlert.addEventListener(MouseEvent.CLICK, openAlert);
			
			var btnFontSetting : IButton = new FlourLabelButtonGray("Open Font Setter");
			btnFontSetting.position = btnAlert.nextPosition();
			btnFontSetting.addEventListener(MouseEvent.CLICK, openFontTuner);
			
			var testFS : SSenTextField = new SSenTextField();
			testFS.defaultTextFormat = FlourFont.getTextStyle();
			testFS.setFontRender(FlourFont.contentFontRender);
			testFS.selectable = false;
			testFS.border = true;
			testFS.borderColor = 0xbbbbbb;
			testFS.multiline = true;
			testFS.wordWrap = true;
			testFS.htmlText = '<font size="12">Font Setter 를 통해서 텍스트의 렌더링 옵션을 조절할 수 있습니다.</font>';
			testFS.width = 250;
			testFS.autoSizeHeight();
			testFS.position = btnAlert.nextPositionBr();
			
			addChildren(btnAlert, btnFontSetting, testFS);
		}
		private function openFontTuner(event : MouseEvent) : void
		{
			var cr : FontRender = FlourFont.contentFontRender;
			var tr : FontRender = FlourFont.titleFontRender;
			var panel : IPanelObject = new FlourFontSetting(cr.sharpness, cr.thickness, tr.sharpness, tr.thickness);
			panel.addEventListener(PanelEvent.PANEL_CANCEL, panelClose);
			panel.addEventListener(PanelEvent.PANEL_OK, fontSettingResult);
			Panel.open(panel);
		}
		private function fontSettingResult(event : PanelEvent) : void
		{
			var cr : FontRender = FlourFont.contentFontRender;
			var tr : FontRender = FlourFont.titleFontRender;
			var values : Values = event.values;
			cr.sharpness = values[FlourFont.CONTENT_SHARPNESS];
			cr.thickness = values[FlourFont.CONTENT_THICKNESS];
			tr.sharpness = values[FlourFont.TITLE_SHARPNESS];
			tr.thickness = values[FlourFont.TITLE_THICKNESS];
			
			var panel : IPanelObject = IPanelObject(event.target);
			panel.removeEventListener(PanelEvent.PANEL_CANCEL, panelClose);
			panel.removeEventListener(PanelEvent.PANEL_OK, fontSettingResult);
			Panel.close(panel);
		}
		private function openAlert(event : MouseEvent) : void
		{
			var panel : IPanelObject = new FlourAlert("치명적인 에러 808080 이 발생하여\n<b>어플리케이션을</b> 임시적으로 종료합니다.\n자세한 문의사항은 080-1134-5858 로 문의바랍니다.", true);
			panel.addEventListener(PanelEvent.PANEL_CANCEL, panelClose);
			Panel.open(panel);
		}
		private function panelClose(event : PanelEvent) : void
		{
			var panel : IPanelObject = IPanelObject(event.target);
			panel.removeEventListener(PanelEvent.PANEL_CANCEL, panelClose);
			Panel.close(panel);
		}
	}
}
