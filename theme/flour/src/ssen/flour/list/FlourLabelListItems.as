package ssen.flour.list 
{
	import ssen.component.list.AbstListItems;
	import ssen.component.list.IListItem;
	import ssen.component.list.LabelListItem;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSolidColorShape;
	import ssen.core.geom.Padding;
	import ssen.core.text.TextStyle;
	import ssen.data.selectGroup.ISelectGroup;
	import ssen.flour.text.FlourFont;
	import ssen.flour.thumbnail.FlourThumbnail;

	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class FlourLabelListItems extends AbstListItems 
	{
		private static function getItemPadding() : Padding
		{
			if (_itemPadding == null) {
				_itemPadding = new Padding(0, 0, 0, 2);
			}
			return _itemPadding;
		}
		private static function getItemColors() : Vector.<Dictionary>
		{
			if (_itemColors == null) {
				var itemColors : Dictionary;
				_itemColors = new Vector.<Dictionary>(2, true);
				itemColors = new Dictionary(true);
				itemColors[SkinMode.DEFAULT] = 0xffffff;
				itemColors[SkinMode.SELECTED] = 0x000000;
				itemColors[SkinMode.OVER] = 0xaaaaaa;
				itemColors[SkinMode.ACTION] = 0x999999;
				itemColors[SkinMode.DISABLE] = 0xffffff;
				_itemColors[0] = itemColors;
				itemColors = new Dictionary(true);
				itemColors[SkinMode.DEFAULT] = 0xF4F4F4;
				itemColors[SkinMode.SELECTED] = 0x000000;
				itemColors[SkinMode.OVER] = 0xaaaaaa;
				itemColors[SkinMode.ACTION] = 0x999999;
				itemColors[SkinMode.DISABLE] = 0xF4F4F4; 
				_itemColors[1] = itemColors;
			}
			return _itemColors;
		}  
		private static function getFontColors() : Vector.<Dictionary>
		{
			if (_fontColors == null) {
				var fontColors : Dictionary;
				_fontColors = new Vector.<Dictionary>(2, true);
				fontColors = new Dictionary(true);
				fontColors[SkinMode.DEFAULT] = 0x000000;
				fontColors[SkinMode.SELECTED] = 0xFFFFFF;
				fontColors[SkinMode.OVER] = 0x000000;
				fontColors[SkinMode.ACTION] = 0x000000;
				fontColors[SkinMode.DISABLE] = 0xaaaaaa; 
				_fontColors[0] = fontColors;
				fontColors = new Dictionary(true);
				fontColors[SkinMode.DEFAULT] = 0x000000;
				fontColors[SkinMode.SELECTED] = 0xFFFFFF;
				fontColors[SkinMode.OVER] = 0x000000;
				fontColors[SkinMode.ACTION] = 0x000000;
				fontColors[SkinMode.DISABLE] = 0xaaaaaa; 
				_fontColors[1] = fontColors;
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

		private static var _itemPadding : Padding;
		private static var _itemColors : Vector.<Dictionary>;
		private static var _fontColors : Vector.<Dictionary>;
		private static var _textStyle : TextStyle;

		public function FlourLabelListItems(itemWidth : int, itemHeight : int, data : ISelectGroup = null)
		{
			_styleLength = 2;
			super(itemWidth, itemHeight, data);
		}
		override protected function createListItem(styleID : int, enabled : Boolean) : IListItem
		{
			var shape : SkinSolidColorShape = new SkinSolidColorShape(getItemColors()[styleID], _itemWidth, _itemHeight);
			var item : LabelListItem = new LabelListItem(shape, _itemWidth, _itemHeight, getItemPadding(), getFontColors()[styleID], getTextStyle(), enabled, FlourThumbnail.labelThumbnails, FlourFont.contentFontRender);
			trace(item.minHeight);
			return item;
		}
	}
}
