package ssen.flour.panels 
{
	import ssen.component.buttons.IButton;
	import ssen.component.interaction.PanelObjectInteraction;
	import ssen.component.panels.IPanelObject;
	import ssen.core.array.Values;
	import ssen.core.display.CreateBoxes;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.geom.Padding;
	import ssen.core.text.SSenTextField;
	import ssen.flour.buttons.FlourButtonXClose;
	import ssen.flour.buttons.FlourLabelButtonGray;
	import ssen.flour.text.FlourFont;
	import ssen.flour.text.FlourFontRenderingTuner;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;	
	/**
	 * @author SSen
	 */
	public class FlourFontSetting extends SSenSprite implements IPanelObject
	{
		[Embed(source="asset/panelBackground/gray.png", scaleGridLeft="10", scaleGridTop="27", scaleGridRight="42", scaleGridBottom="39")]
		private static var backgroundImage : Class;
		
		// controller
		private var _interaction : PanelObjectInteraction;
		/* *********************************************************************
		 * display object
		 ********************************************************************* */
		private var _okButton : IButton;
		private var _xButton : IButton;
		private var _background : DisplayObject;
		private var _title : SSenTextField;
		private var _move : Sprite;
		private var _fontRenderingTuner : FlourFontRenderingTuner;
		private var _cancelButton : FlourLabelButtonGray;

		public function FlourFontSetting(contentSharpness : int, contentThickness : int, titleSharpness : int, titleThickness : int)
		{
			_interaction = new PanelObjectInteraction(this);
			var padding : Padding = new Padding(42, 39, 24, 39);
			
			_fontRenderingTuner = new FlourFontRenderingTuner(contentSharpness, contentThickness, titleSharpness, titleThickness);
			_fontRenderingTuner.x = padding.left;
			_fontRenderingTuner.y = padding.top;
			
			// window setting
			var content : DisplayObject = _fontRenderingTuner;
			var marginBottomMessage : int = 10;
			var titleX : int = 7;
			var titleY : int = 2;
			var xX : int = 5;
			var xY : int = 4;
			
			_title = new SSenTextField();
			_title.defaultTextFormat = FlourFont.getTextStyle(11, 0x686868, null, -400, 120);
			_title.setFontRender(FlourFont.titleFontRender);
			_title.text = "글꼴 보기 설정";
			_title.selectable = false;
			_xButton = new FlourButtonXClose();
			_background = new backgroundImage();
			_move = CreateBoxes.createTransparentSpriteBox(10, 10);
			
			_okButton = new FlourLabelButtonGray("확인");
			_cancelButton = new FlourLabelButtonGray("취소");
			_cancelButton.position = _okButton.nextPosition();
			var defaultButton : IButton = new FlourLabelButtonGray("기본값으로 되돌립니다");
			defaultButton.position = _cancelButton.nextPosition();
			defaultButton.addEventListener(MouseEvent.CLICK, defaultSetting, false, 0, true);
			var buttons : SSenSprite = new SSenSprite();
			buttons.addChildren(_okButton, _cancelButton, defaultButton);
			
			_title.autoSizeHeight();
			_background.width = content.width + padding.left + padding.right;
			_background.height = content.height + padding.top + padding.bottom + buttons.height + marginBottomMessage;
			_title.x = titleX;
			_title.y = titleY;
			_title.width = _background.width - titleX - xX - _xButton.width;
			_xButton.x = _background.width - _xButton.width - xX;
			_xButton.y = xY;
			
			buttons.x = (_background.width >> 1) - (buttons.width >> 1);
			buttons.y = content.y + content.height + marginBottomMessage;
			
			_move.width = _title.width;
			_move.height = _title.height;
			_move.x = _title.x;
			_move.y = _title.y;
			
			filters = [new DropShadowFilter(6, 45, 0x000000, 0.1, 1, 1)];
			
			addChildren(_background, _xButton, _title, _move, content, buttons);
			setMoveObjects(_move);
			setOkButtons(_okButton);
			setCancelButtons(_xButton, _cancelButton);
		}
		private function defaultSetting(event : MouseEvent) : void
		{
			_fontRenderingTuner.contentSharpness = FlourFont.DEFAULT_CONTENT_SHARPNESS;
			_fontRenderingTuner.contentThickness = FlourFont.DEFAULT_CONTENT_THICKNESS;
			_fontRenderingTuner.titleSharpness = FlourFont.DEFAULT_TITLE_SHARPNESS;
			_fontRenderingTuner.titleThickness = FlourFont.DEFAULT_TITLE_THICKNESS;
		}
		/* *********************************************************************
		 * implement IPanelObject
		 ********************************************************************* */
		public function topIndex() : void
		{
			_interaction.topIndex();
		}
		public function getValues() : Values
		{
			var values : Values = new Values();
			values[FlourFont.CONTENT_SHARPNESS] = _fontRenderingTuner.contentSharpness;
			values[FlourFont.CONTENT_THICKNESS] = _fontRenderingTuner.contentThickness;
			values[FlourFont.TITLE_SHARPNESS] = _fontRenderingTuner.titleSharpness;
			values[FlourFont.TITLE_THICKNESS] = _fontRenderingTuner.titleThickness; 
			return values;
		}
		public function setMoveObjects(...objs) : void
		{
			_interaction.setMoveObjects(objs);
		}
		public function setCancelButtons(...btns) : void
		{
			_interaction.setCancelButtons(btns);
		}
		public function setOkButtons(...btns) : void
		{
			_interaction.setOkButtons(btns);
		}
		public function resourceKill() : void
		{
			_interaction.resourceKill();
			_fontRenderingTuner = null;
			_interaction = null;
		}
		public function get enable() : Boolean
		{
			return _interaction.enable;
		}
		public function set enable(enable : Boolean) : void
		{
			_interaction.enable;
		}
	}
}
