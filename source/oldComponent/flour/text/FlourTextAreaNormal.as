package ssen.flour.text 
{
	import ssen.component.scroll.IScroller;
	import ssen.component.scroll.TextAreaBase;
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.geom.Padding;
	import ssen.core.text.TextStyle;
	import ssen.flour.scroll.FlourScrollTrackNormalH;
	import ssen.flour.scroll.FlourScrollTrackNormalV;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FlourTextAreaNormal extends TextAreaBase 
	{

		[Embed(source="../scroll/asset/normal/piece/default.png")]
		private static var defaultPiece : Class;

		[Embed(source="../scroll/asset/normal/piece/action.png")]
		private static var actionPiece : Class;

		[Embed(source="../scroll/asset/normal/piece/disable.png")]
		private static var disablePiece : Class;
		private static var _textStyle : TextStyle;
		private static var _fontColors : ColorCollection;
		private static function getTextStyle() : TextStyle
		{
			if (!_textStyle) _textStyle = FlourFont.getTextStyle();
			return _textStyle;
		}
		private static function getFontColors() : ColorCollection
		{
			if (!_fontColors) {
				_fontColors = new ColorCollection();
				_fontColors.addColor(SkinFlag.DEFAULT, 0x000000);
				_fontColors.addColor(SkinFlag.DISABLE, 0xcccccc);
				_fontColors.addColor(SkinFlag.HIGHLIGHT, 0x862f00);
				_fontColors.addColor(SkinFlag.ACTION, 0x000000);
			}
			return _fontColors;
		}
		public function FlourTextAreaNormal(width : Number = 300, height : Number = 250, padding : Padding = null, secX : Number = 0, secY : Number = 0, directionMode : String = "verticalAndHorizontal", isTrackHide : Boolean = true, trackMode : String = "point")
		{
			super(getTextStyle(), getFontColors(), width, height, padding, secX, secY, directionMode, isTrackHide, trackMode);
		}
		override protected function createPiece() : ISkinDisplayObject 
		{
			var piece : SkinAssetSprite = new SkinAssetSprite(true, 20, 20, SkinFlag.DEFAULT, defaultPiece);
			piece.addAsset(SkinFlag.ACTION, actionPiece);
			piece.addAsset(SkinFlag.DISABLE, disablePiece);
			return piece;
		}
		override protected function createScrollerH(width : Number) : IScroller 
		{
			return new FlourScrollTrackNormalH(width);
		}
		override protected function createScrollerV(height : Number) : IScroller 
		{
			return new FlourScrollTrackNormalV(height);
		}
	}
}
