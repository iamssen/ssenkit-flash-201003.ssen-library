package ssen.flour.text 
{
	import ssen.core.events.FontRenderEvent;	

	import flash.net.SharedObject;	

	import ssen.core.text.FontRender;	
	import ssen.core.text.TextStyle;		
	/**
	 * @author SSen
	 */
	public class FlourFont
	{
		private static var _contentFontRender : FontRender;
		private static var _titleFontRender : FontRender;
		public static const CONTENT_SHARPNESS : String = "contentSharpness";
		public static const CONTENT_THICKNESS : String = "contentThickness";
		public static const TITLE_SHARPNESS : String = "titleSharpness";
		public static const TITLE_THICKNESS : String = "titleThickness";
		public static const DEFAULT_CONTENT_SHARPNESS : int = -400;
		public static const DEFAULT_CONTENT_THICKNESS : int = -50;
		public static const DEFAULT_TITLE_SHARPNESS : int = -400;
		public static const DEFAULT_TITLE_THICKNESS : int = 120;

		public static function getTextStyle(size : int = 11, color : Object = -1, align : String = null, sharpness : int = -400, thickness : int = -50) : TextStyle
		{
			var textStyle : TextStyle = new TextStyle(true, sharpness, thickness, "NanumGothic", size, color, false, false, false, null, null, align);
			return textStyle;
		}
		public static function get contentFontRender() : FontRender
		{
			if (_contentFontRender == null) {
				var sharpness : int = DEFAULT_CONTENT_SHARPNESS;
				var thickness : int = DEFAULT_CONTENT_THICKNESS;
				var so : SharedObject = SharedObject.getLocal("fontSetting");
				if (so.data[CONTENT_SHARPNESS] != null) sharpness = Number(so.data[CONTENT_SHARPNESS]);
				if (so.data[CONTENT_THICKNESS] != null) thickness = Number(so.data[CONTENT_THICKNESS]);
				
				_contentFontRender = new FontRender(sharpness, thickness);
				_contentFontRender.addEventListener(FontRenderEvent.RENDER_CHANGE, contentRenderChange, false, 0, true);
			}
			return _contentFontRender;
		}
		private static function contentRenderChange(event : FontRenderEvent) : void
		{
			var so : SharedObject = SharedObject.getLocal("fontSetting");
			so.data[CONTENT_SHARPNESS] = event.sharpness;
			so.data[CONTENT_THICKNESS] = event.thickness;
		}
		public static function get titleFontRender() : FontRender
		{
			if (_titleFontRender == null) {
				var sharpness : int = DEFAULT_TITLE_SHARPNESS;
				var thickness : int = DEFAULT_TITLE_THICKNESS;
				var so : SharedObject = SharedObject.getLocal("fontSetting");
				if (so.data[TITLE_SHARPNESS] != null) sharpness = Number(so.data[TITLE_SHARPNESS]);
				if (so.data[TITLE_THICKNESS] != null) thickness = Number(so.data[TITLE_THICKNESS]);
				
				_titleFontRender = new FontRender(sharpness, thickness);
				_titleFontRender.addEventListener(FontRenderEvent.RENDER_CHANGE, titleRenderChange, false, 0, true);
			}
			return _titleFontRender;
		}
		private static function titleRenderChange(event : FontRenderEvent) : void
		{
			var so : SharedObject = SharedObject.getLocal("fontSetting");
			so.data[TITLE_SHARPNESS] = event.sharpness;
			so.data[TITLE_THICKNESS] = event.thickness;
		}
	}
}
