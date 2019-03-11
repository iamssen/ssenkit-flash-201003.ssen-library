package ssen.flour.buttons 
{
	import ssen.flour.text.FlourFont;	

	import bmds.buttons.labelButtonGray;

	import ssen.component.buttons.LabelButton;
	import ssen.component.buttons.LabelButtonSkin;
	import ssen.core.text.TextStyle;

	import flash.display.DisplayObject;	
	/**
	 * @author SSen
	 */
	public class FlourLabelButtonGray extends LabelButton 
	{
		private static var _skin : LabelButtonSkin;
		private static var _textStyle : TextStyle;

		private static function getSkin() : LabelButtonSkin
		{
			if (_skin == null) {
				_skin = new LabelButtonSkin(new labelButtonGray(0, 0));
			}
			return _skin;
		}
		private static function getTextStyle() : TextStyle
		{
			if (_textStyle == null) {
				_textStyle = FlourFont.getTextStyle();
			}
			return _textStyle;
		}
		public function FlourLabelButtonGray(title : String, thumbnail : DisplayObject = null, thumbnailResize : Boolean = true, buttonType : String = "normal")
		{
			super(getSkin(), title, getTextStyle(), thumbnail, thumbnailResize, buttonType);
			setFontRender(FlourFont.contentFontRender);
			
			if (width < 40) {
				width = 40;
			}
		}
	}
}
