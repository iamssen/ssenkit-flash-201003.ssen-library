package ssen.flour.list 
{
	import ssen.component.list.AbstListItems;
	import ssen.component.list.IListItem;
	import ssen.component.list.LabelListItem;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFillRect;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.geom.Padding;
	import ssen.core.text.TextStyle;
	import ssen.data.selectGroup.ISelectGroup;
	import ssen.flour.text.FlourFont;
	import ssen.flour.thumbnail.FlourThumbnail;
	
	import flash.display.GraphicsSolidFill;
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
		private static function getBackground(styleID : int, width : Number, height : Number) : ISkinDisplayObject
		{
			var skin : SkinFillRect = new SkinFillRect(false, width, height);
			switch (styleID) {
				case 0 : 
					skin.addFill(SkinFlag.DEFAULT, new GraphicsSolidFill(0xffffff));
					skin.addFill(SkinFlag.SELECTED, new GraphicsSolidFill(0x000000));
					skin.addFill(SkinFlag.OVER, new GraphicsSolidFill(0xaaaaaa));
					skin.addFill(SkinFlag.ACTION, new GraphicsSolidFill(0x999999));
					skin.addFill(SkinFlag.DISABLE, new GraphicsSolidFill(0xffffff));
					break;
				case 1 : 
					skin.addFill(SkinFlag.DEFAULT, new GraphicsSolidFill(0xf4f4f4));
					skin.addFill(SkinFlag.SELECTED, new GraphicsSolidFill(0x000000));
					skin.addFill(SkinFlag.OVER, new GraphicsSolidFill(0xaaaaaa));
					skin.addFill(SkinFlag.ACTION, new GraphicsSolidFill(0x999999));
					skin.addFill(SkinFlag.DISABLE, new GraphicsSolidFill(0xf4f4f4));
					break;
			}
			skin.skinDraw(SkinFlag.DEFAULT);
			return skin;
		}  
		private static function getFontColors() : Vector.<Dictionary>
		{
			if (_fontColors == null) {
				var fontColors : Dictionary;
				_fontColors = new Vector.<Dictionary>(2, true);
				fontColors = new Dictionary(true);
				fontColors[SkinFlag.DEFAULT] = 0x000000;
				fontColors[SkinFlag.SELECTED] = 0xFFFFFF;
				fontColors[SkinFlag.OVER] = 0x000000;
				fontColors[SkinFlag.ACTION] = 0x000000;
				fontColors[SkinFlag.DISABLE] = 0xaaaaaa; 
				_fontColors[0] = fontColors;
				fontColors = new Dictionary(true);
				fontColors[SkinFlag.DEFAULT] = 0x000000;
				fontColors[SkinFlag.SELECTED] = 0xFFFFFF;
				fontColors[SkinFlag.OVER] = 0x000000;
				fontColors[SkinFlag.ACTION] = 0x000000;
				fontColors[SkinFlag.DISABLE] = 0xaaaaaa; 
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
		private static var _fontColors : Vector.<Dictionary>;
		private static var _textStyle : TextStyle;

		
		public function FlourLabelListItems(itemWidth : int, itemHeight : int, data : ISelectGroup = null)
		{
			_styleLength = 2;
			super(itemWidth, itemHeight, data);
		}
		override protected function createListItem(styleID : int, enabled : Boolean) : IListItem
		{
			var item : LabelListItem = new LabelListItem(getBackground(styleID, _itemWidth, _itemHeight), _itemWidth, _itemHeight, getItemPadding(), getFontColors()[styleID], getTextStyle(), enabled, FlourThumbnail.labelThumbnails, FlourFont.contentFontRender);
			return item;
		}
	}
}
