package ssen.flour.input 
{
	import ssen.component.buttons.IButton;
	import ssen.component.input.AbstInput;
	import ssen.component.list.AbstList;
	import ssen.core.display.PositionTester;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.geom.Padding;
	import ssen.forms.textInput.SingleLineInputType;
	import ssen.core.text.TextStyle;
	import ssen.data.events.SelectGroupEvent;
	import ssen.data.selectGroup.ISelectGroup;
	import ssen.data.selectGroup.ISelectItem;
	import ssen.flour.buttons.FlourInputButtons;
	import ssen.flour.list.FlourLabelList;
	import ssen.flour.text.FlourFont;

	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	/**
	 * @author SSen
	 */
	public class FlourComboBox extends AbstInput 
	{
		private static var _padding : Padding;
		private static var _fontColors : ColorCollection;
		private static var _textStyle : TextStyle;
		private var _data : ISelectGroup;
		private var _btn : IButton;
		private var _list : AbstList;

		
		/* *********************************************************************
		 * style book
		 ********************************************************************* */
		private static function getPadding() : Padding
		{
			if (_padding == null) {
				_padding = new Padding(3, 4, 5, 5);
			}
			return _padding;
		}
		private static function getFontColors() : ColorCollection
		{
			if (_fontColors == null) {
				var fontColors : ColorCollection = new ColorCollection();
				fontColors.addColor(SkinFlag.DEFAULT, 0x000000);
				fontColors.addColor(SkinFlag.SELECTED, 0xFFFFFF);
				fontColors.addColor(SkinFlag.OVER, 0x000000);
				fontColors.addColor(SkinFlag.ACTION, 0x000000);
				fontColors.addColor(SkinFlag.DISABLE, 0xaaaaaa);
				_fontColors = fontColors;
			}
			return _fontColors;
		}
		private static function getTextStyle() : TextStyle
		{
			if (_textStyle == null) {
				_textStyle = FlourFont.getTextStyle(10);
			}
			return _textStyle;
		}
		/* *********************************************************************
		 * constructor
		 ********************************************************************* */
		public function FlourComboBox(width : int, data : ISelectGroup = null)
		{
			super(width, 23, SingleLineInputType.ALL);
			
			_txt.setFontRender(FlourFont.contentFontRender);
			_txt.type = TextFieldType.DYNAMIC;
			_txt.mouseEnabled = false;
			
			if (data != null) {
				_data = data;
				if (data.selected) {
					var item : ISelectItem = data.selectedItems[0];
					value = item.labelText;
				}
			} else {
				enabled = false;
			}
		}
		override public function set enabled(enabled : Boolean) : void
		{
			if (super.enabled != enabled) {
				super.enabled = enabled;
				_btn.enable = enabled;
			}
		}
		public function get data() : ISelectGroup
		{
			return _data;
		}
		public function set data(data : ISelectGroup) : void
		{
			if (data == null) {
				_data = data;
			}
		}
		/* *********************************************************************
		 * Skin Factory
		 ********************************************************************* */
		override protected function createTextStyle() : TextStyle
		{
			return getTextStyle();
		}
		override protected function createFontColors() : ColorCollection
		{
			return getFontColors();
		}
		override protected function createBackGround() : ISkinDisplayObject
		{
			return new FlourInputBackground(false);
		}
		override protected function createPadding() : Padding
		{
			return getPadding();
		}
		override protected function createButtonGroup() : SSenSprite
		{
			_btn = new FlourInputButtons("comboBox");
			eventOnButton(_btn);
			return SSenSprite(_btn);
		}
		/* *********************************************************************
		 * event
		 ********************************************************************* */
		private function eventOnButton(btn : IButton) : void
		{
			btn.addEventListener(MouseEvent.CLICK, click, false, 0, true);
		}
		private function eventOffButton(btn : IButton) : void
		{
			btn.removeEventListener(MouseEvent.CLICK, click);
		}
		private function click(event : MouseEvent) : void
		{
			_list = new FlourLabelList(_bg.width, 150, 23, _data);
			_list.x = globalX;
			_list.y = globalY + height + 5;
			_list.moveToSelectedY();
			stage.addChild(_list);
			eventOffButton(_btn);
			_data.addEventListener(SelectGroupEvent.SELECT_ITEM, selectItem, false, 0, true);
			stage.addEventListener(MouseEvent.CLICK, stageClick, false, 0, true);
		}
		private function stageClick(event : MouseEvent) : void
		{
			if (_list != null && !PositionTester.isPointerInRect(stage, new Rectangle(globalX, globalY, width, height + 5 + _list.height))) {
				clearList();
			}
		}
		private function selectItem(event : SelectGroupEvent) : void
		{
			value = event.item.labelText;
			clearList();
		}
		private function clearList() : void
		{
			eventOnButton(_btn);
			stage.removeChild(_list);
			_list.resourceKill();
			_list = null;
			_data.removeEventListener(SelectGroupEvent.SELECT_ITEM, selectItem);
			stage.removeEventListener(MouseEvent.CLICK, stageClick, true);
		}
	}
}
