package ssen.component.buttons 
{
	import ssen.core.convert.GraphicsConverter;
	import ssen.core.display.GridType;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.display.skin.SkinSliceBitmap;
	import ssen.core.geom.Padding;
	import ssen.core.display.BitmapUtil;

	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;		
	/**
	 * LabelButton 에 사용되는 Skin
	 * @author SSen
	 */
	public class LabelButtonSkin implements ILabelButtonSkin 
	{
		private var _button_9grid : Rectangle;
		private var _button_padding : Padding;
		private var _button_fontColor_default : uint;
		private var _button_fontColor_over : uint;
		private var _button_fontColor_action : uint;
		private var _button_fontColor_disable : uint;
		private var _button_fontColor_selected : uint;
		private var _button_bg_default : BitmapData;
		private var _button_bg_over : BitmapData;
		private var _button_bg_action : BitmapData;
		private var _button_bg_disable : BitmapData;
		private var _button_bg_selected : BitmapData;
		public function LabelButtonSkin(buttonBitmap : BitmapData)
		{
			_button_9grid = GraphicsConverter.getScale9GridFromBitmapData(buttonBitmap, 0, 0, 50, 50);
			_button_padding = GraphicsConverter.getPaddingFromBitmapData(buttonBitmap, 50, 0, 50, 50);
			_button_fontColor_default = GraphicsConverter.getColor(buttonBitmap, 102, 52);
			_button_fontColor_over = GraphicsConverter.getColor(buttonBitmap, 152, 52);
			_button_fontColor_action = GraphicsConverter.getColor(buttonBitmap, 202, 52);
			_button_fontColor_disable = GraphicsConverter.getColor(buttonBitmap, 252, 52);
			_button_fontColor_selected = GraphicsConverter.getColor(buttonBitmap, 302, 52);
			_button_bg_default = BitmapUtil.getSlice(buttonBitmap, 100, 0, 50, 50);
			_button_bg_over = BitmapUtil.getSlice(buttonBitmap, 150, 0, 50, 50);
			_button_bg_action = BitmapUtil.getSlice(buttonBitmap, 200, 0, 50, 50);
			_button_bg_disable = BitmapUtil.getSlice(buttonBitmap, 250, 0, 50, 50);
			_button_bg_selected = BitmapUtil.getSlice(buttonBitmap, 300, 0, 50, 50);
		}
		/** button bg */
		public function button_bg() : ISkinDisplayObject
		{
			var skin : SkinSliceBitmap = new SkinSliceBitmap(true, 50, 50, _button_9grid, GridType.SCALE_9_GRID, SkinFlag.DEFAULT, _button_bg_default);
			skin.addBitmapData(SkinFlag.OVER, _button_bg_over);
			skin.addBitmapData(SkinFlag.ACTION, _button_bg_action);
			skin.addBitmapData(SkinFlag.SELECTED, _button_bg_selected);
			skin.addBitmapData(SkinFlag.DISABLE, _button_bg_disable);
			
			return skin;
		}
		/** button 의 scale9Grid */
		public function get button_9grid() : Rectangle
		{
			return _button_9grid;
		}
		/** button 의 innerGrid */
		public function get button_innerGrid() : Padding
		{
			return _button_padding;
		}
		/** button 의 font colors */
		public function get button_fontColors() : Dictionary
		{
			var colors : Dictionary = new Dictionary();
			colors[SkinFlag.DEFAULT] = _button_fontColor_default;
			colors[SkinFlag.OVER] = _button_fontColor_over;
			colors[SkinFlag.ACTION] = _button_fontColor_action;
			colors[SkinFlag.DISABLE] = _button_fontColor_disable;
			colors[SkinFlag.SELECTED] = _button_fontColor_selected;
			return colors;
		}
	}
}
