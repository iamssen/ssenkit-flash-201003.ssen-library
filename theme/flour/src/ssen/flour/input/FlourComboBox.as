package ssen.flour.input 
{
	import bmds.input.textInputBackDefault;
	import bmds.input.textInputBackDisable;
	import bmds.input.textInputBackHighlight;
	
	import ssen.component.buttons.IButton;
	import ssen.component.input.AbstInput;
	import ssen.component.list.AbstList;
	import ssen.core.display.DisplayObjectEx;
	import ssen.core.display.ISkinObject;
	import ssen.core.display.SSenSprite;
	import ssen.core.display.SkinGridBitmap;
	import ssen.core.display.SkinMode;
	import ssen.core.geom.Padding;
	import ssen.core.text.InputType;
	import ssen.core.text.TextStyle;
	import ssen.data.events.SelectGroupEvent;
	import ssen.data.selectGroup.ISelectGroup;
	import ssen.data.selectGroup.ISelectItem;
	import ssen.flour.buttons.FlourInputButtons;
	import ssen.flour.list.FlourLabelList;
	import ssen.flour.text.FlourFont;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	import flash.utils.Dictionary;		
	/**
	 * @author SSen
	 */
	public class FlourComboBox extends AbstInput 
	{
		private static var _padding : Padding;
		private static var _fontColors : Dictionary;
		private static var _textStyle : TextStyle;
		private var _data : ISelectGroup;
		private var _btn : IButton;
		private var _list : AbstList;

		private static function getPadding() : Padding
		{
			if (_padding == null) {
				_padding = new Padding(3, 4, 5, 5);
			}
			return _padding;
		}
		private static function getFontColors() : Dictionary
		{
			if (_fontColors == null) {
				var fontColors : Dictionary;
				fontColors = new Dictionary(true);
				fontColors[SkinMode.DEFAULT] = 0x000000;
				fontColors[SkinMode.SELECTED] = 0xFFFFFF;
				fontColors[SkinMode.OVER] = 0x000000;
				fontColors[SkinMode.ACTION] = 0x000000;
				fontColors[SkinMode.DISABLE] = 0xaaaaaa; 
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
		public function FlourComboBox(width : int, data : ISelectGroup = null)
		{
			super(width, 23, InputType.ALL);
			
			_txt.setFontRender(FlourFont.contentFontRender);
			_txt.type = TextFieldType.DYNAMIC;
			
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
		override protected function createFontColors() : Dictionary
		{
			return getFontColors();
		}
		override protected function createBackGround() : ISkinObject
		{
			var dic : Dictionary = new Dictionary(true);
			dic[SkinMode.DEFAULT] = new textInputBackDefault(0, 0);
			dic[SkinMode.OVER] = new textInputBackDefault(0, 0);
			dic[SkinMode.ACTION] = new textInputBackHighlight(0, 0);
			dic[SkinMode.HIGHLIGHT] = new textInputBackHighlight(0, 0);
			dic[SkinMode.DISABLE] = new textInputBackDisable(0, 0);
			var skin : SkinGridBitmap = new SkinGridBitmap(dic, new Rectangle(4, 4, 14, 13));
			return skin;
		}
		override protected function createPadding() : Padding
		{
			return getPadding();
		}
		override protected function createButtonGroup() : SSenSprite
		{
			var sp : SSenSprite = new SSenSprite();
			_btn = new FlourInputButtons("comboBox");
			eventOnButton(_btn);
			sp.addChild(DisplayObject(_btn));
			return sp;
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
			_btn.removeEventListener(MouseEvent.CLICK, click);
			_list = new FlourLabelList(_bg.width, 150, 23, _data);
			stage.addChild(_list);
			_list.x = globalX;
			_list.y = globalY + height + 5;
			_list.moveToSelectedY();
			_data.addEventListener(SelectGroupEvent.SELECT_ITEM, selectItem, false, 0, true);
			stage.addEventListener(MouseEvent.CLICK, stageClick, false, 0, true);
		}
		private function stageClick(event : MouseEvent) : void
		{
			if (_list != null && !DisplayObjectEx.isPointerInRect(stage, new Rectangle(globalX, globalY, width, height + 5 + _list.height))) {
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
			_btn.addEventListener(MouseEvent.CLICK, click, false, 0, true);
			stage.removeChild(_list);
			_list.resourceKill();
			_list = null;
			_data.removeEventListener(SelectGroupEvent.SELECT_ITEM, selectItem);
			stage.removeEventListener(MouseEvent.CLICK, stageClick, true);
		}
	}
}
