package ssen.flour.text 
{
	import ssen.component.events.SlideEvent;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;
	import ssen.flour.sliders.FlourSimpleSliderH;	
	/**
	 * @author SSen
	 */
	public class FlourFontRenderingTuner extends SSenSprite 
	{
		private var _content1 : SSenTextField;
		private var _contentSharpness : FlourSimpleSliderH;
		private var _contentThickness : FlourSimpleSliderH;
		private var _title1 : SSenTextField;
		private var _titleSharpness : FlourSimpleSliderH;
		private var _titleThickness : FlourSimpleSliderH;

		public function FlourFontRenderingTuner(contentSharpness : int, contentThickness : int, titleSharpness : int, titleThickness : int)
		{
			var contentStyle : TextStyle = FlourFont.getTextStyle();
			var titleStyle : TextStyle = FlourFont.getTextStyle();
			contentStyle.sharpness = contentSharpness;
			contentStyle.thickness = contentThickness;
			titleStyle.sharpness = titleSharpness;
			titleStyle.thickness = titleThickness;
			
			_content1 = new SSenTextField();
			_content1.defaultTextFormat = contentStyle;
			_content1.selectable = false;
			_content1.border = true;
			_content1.borderColor = 0xbbbbbb;
			_content1.multiline = true;
			_content1.htmlText = '<font size="15">15px 본문 내용의 폰트 렌더링 입니다.</font><br><font size="12">12px 하단의 슬라이더를 조절해서 보기에 편한</font><br><font size="10">10px sharpness 와 thickness 로 조절해주세요.</font>';
			_content1.width = 250;
			_content1.autoSizeHeight();
			_contentSharpness = new FlourSimpleSliderH(250, -400, 400, contentStyle.sharpness, 40);
			_contentSharpness.position = _content1.nextPositionBr();
			_contentSharpness.addEventListener(SlideEvent.VALUE_CHANGED, contentSharpnessChanged, false, 0, true);
			_contentThickness = new FlourSimpleSliderH(250, -200, 200, contentStyle.thickness, 40);
			_contentThickness.position = _contentSharpness.nextPositionBr();
			_contentThickness.addEventListener(SlideEvent.VALUE_CHANGED, contentThicknessChanged, false, 0, true);
			
			_title1 = new SSenTextField();
			_title1.defaultTextFormat = titleStyle;
			_title1.selectable = false;
			_title1.border = true;
			_title1.borderColor = 0xbbbbbb;
			_title1.multiline = true;
			_title1.htmlText = '<font size="15">15px 제목의 폰트 렌더링 입니다.</font><br><font size="12">12px 하단의 슬라이더를 조절해서 보기에 편한</font><br><font size="10">10px sharpness 와 thickness 로 조절해주세요.</font>';
			_title1.width = 250;
			_title1.autoSizeHeight();
			_title1.position = _contentThickness.nextPositionBr(15);
			_titleSharpness = new FlourSimpleSliderH(250, -400, 400, titleStyle.sharpness, 40);
			_titleSharpness.position = _title1.nextPositionBr();
			_titleSharpness.addEventListener(SlideEvent.VALUE_CHANGED, titleSharpnessChanged, false, 0, true);
			_titleThickness = new FlourSimpleSliderH(250, -200, 200, titleStyle.thickness, 40);
			_titleThickness.position = _titleSharpness.nextPositionBr();
			_titleThickness.addEventListener(SlideEvent.VALUE_CHANGED, titleThicknessChanged, false, 0, true);
			
			addChildren(_content1, _contentSharpness, _contentThickness, _title1, _titleSharpness, _titleThickness);
		}
		public override function get width() : Number
		{
			return 250;
		}
		private function titleThicknessChanged(event : SlideEvent) : void
		{
			_title1.thickness = event.value;
		}
		private function titleSharpnessChanged(event : SlideEvent) : void
		{
			_title1.sharpness = event.value;
		}
		private function contentThicknessChanged(event : SlideEvent) : void
		{
			_content1.thickness = event.value;
		}
		private function contentSharpnessChanged(event : SlideEvent) : void
		{
			_content1.sharpness = event.value;
		}
		/** title sharness */
		public function get titleSharpness() : int
		{
			return Number(_titleSharpness.value);
		}
		public function set titleSharpness(sharpness : int) : void
		{
			_titleSharpness.value = sharpness;
		}
		/** title thickness */
		public function get titleThickness() : int
		{
			return Number(_titleThickness.value);
		}
		public function set titleThickness(thickness : int) : void
		{
			_titleThickness.value = thickness;
		}
		/** content sharness */
		public function get contentSharpness() : int
		{
			return Number(_contentSharpness.value);
		}
		public function set contentSharpness(sharpness : int) : void
		{
			_contentSharpness.value = sharpness;
		}
		/** content thickness */
		public function get contentThickness() : int
		{
			return Number(_contentThickness.value);
		}
		public function set contentThickness(thickness : int) : void
		{
			_contentThickness.value = thickness;
		}
	}
}
