package ssen.flour.panels 
{
	import bmds.panels.panelGrayBG;
	
	import ssen.component.buttons.IButton;
	import ssen.component.interaction.PanelObjectInteraction;
	import ssen.component.panels.IPanelObject;
	import ssen.core.array.Values;
	import ssen.core.display.DisplayObjectEx;
	import ssen.core.display.GridBitmap;
	import ssen.core.display.SSenSprite;
	import ssen.core.geom.Padding;
	import ssen.core.text.SSenTextField;
	import ssen.flour.buttons.FlourButtonXClose;
	import ssen.flour.buttons.FlourLabelButtonGray;
	import ssen.flour.text.FlourFont;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;		
	/**
	 * @author SSen
	 */
	public class FlourAlert extends SSenSprite implements IPanelObject 
	{
		// controller
		private var _interaction : PanelObjectInteraction;
		/* *********************************************************************
		 * display object
		 ********************************************************************* */
		private var _okButton : IButton;
		private var _xButton : IButton;
		private var _background : GridBitmap;
		private var _title : SSenTextField;
		private var _message : SSenTextField;
		private var _move : Sprite;

		public function FlourAlert(message : String, html : Boolean = false)
		{
			_interaction = new PanelObjectInteraction(this);
			var padding : Padding = new Padding(42, 39, 24, 39);
			
			// message setting
			var regexp : RegExp;
			
			_message = new SSenTextField();
			_message.defaultTextFormat = FlourFont.getTextStyle(11, 0x282828, TextFormatAlign.CENTER);
			_message.setFontRender(FlourFont.contentFontRender);
			if (html) {
				regexp = new RegExp("<br", "g");
				_message.htmlText = message;
			} else {
				regexp = new RegExp("\n", "g");
				_message.text = message;
			}
			_message.multiline = regexp.test(message);
			_message.selectable = false;
			_message.autoSizeWidth();
			_message.autoSizeHeight();
			_message.x = padding.left;
			_message.y = padding.top;
			
			// window setting
			var content : DisplayObject = _message;
			var marginBottomMessage : int = 10;
			var titleX : int = 7;
			var titleY : int = 2;
			var xX : int = 5;
			var xY : int = 4;
			
			_title = new SSenTextField();
			_title.defaultTextFormat = FlourFont.getTextStyle(11, 0x686868, null, -400, 120);
			_title.setFontRender(FlourFont.titleFontRender);
			_title.text = "알림창";
			_title.selectable = false;
			_okButton = new FlourLabelButtonGray("확인");
			_xButton = new FlourButtonXClose();
			_background = new GridBitmap(new panelGrayBG(0, 0), new Rectangle(10, 27, 32, 12));
			_move = DisplayObjectEx.createTransparentSpriteBox(10, 10);
			
			
			_title.autoSizeHeight();
			_background.width = content.width + padding.left + padding.right;
			_background.height = content.height + padding.top + padding.bottom + _okButton.height + marginBottomMessage;
			_title.x = titleX;
			_title.y = titleY;
			_title.width = _background.width - titleX - xX - _xButton.width;
			_xButton.x = _background.width - _xButton.width - xX;
			_xButton.y = xY;
			
			_okButton.x = int((_background.width >> 1) - (_okButton.width >> 1));
			_okButton.y = content.y + content.height + marginBottomMessage;
			_move.width = _title.width;
			_move.height = _title.height;
			_move.x = _title.x;
			_move.y = _title.y;
			
			filters = [new DropShadowFilter(6, 45, 0x000000, 0.1, 1, 1)];
			
			addChildren(_background, _okButton, _xButton, _title, _message, _move);
			setMoveObjects(_move);
			setCancelButtons(_xButton, _okButton);
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
			return null;
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
