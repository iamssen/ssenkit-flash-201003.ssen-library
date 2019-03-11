package test.library 
{
	import ssen.core.utils.FormatToString;

	import flash.display.Sprite;
	import flash.text.Font;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class NanumGothic extends Sprite 
	{

		[Embed(source="asset/나눔고딕.ttf", fontFamily="nanumGothic", mimeType="application/x-font", embedAsCFF="true")]
		public static const NanumGothicRegular : Class;

		[Embed(source="asset/나눔고딕Bold.ttf", fontFamily="nanumGothic", mimeType="application/x-font", embedAsCFF="true")]
		public static const NanumGothicBold : Class;

		
		public static function initialize() : void
		{
			Font.registerFont(NanumGothicRegular);
			Font.registerFont(NanumGothicBold);
			
			var fonts : Array = Font.enumerateFonts();
			var font : Font;
			var f : int;
			for (f = 0;f < fonts.length; f++) {
				font = fonts[f];
				trace("load font", f, font, FormatToString.toString(font, "fontName", "fontStyle", "fontType"));
			}
		}
	}
}
