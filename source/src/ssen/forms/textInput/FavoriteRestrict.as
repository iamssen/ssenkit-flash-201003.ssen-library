package ssen.forms.textInput 
{
	/**
	 * Favorite TextField Restrict<br />
	 * <a href="http://ssen.name/develop/document/ascii_unicode_table/unicode.html" target="_blank">unicode table</a>
	 * @author SSen
	 */
	public class FavoriteRestrict 
	{
		/** 0-9 . - */
		public static const NUMBER : String = "\u0030-\u0039 \u002D \u002E";
		/** [space]-~ */
		public static const ENGLISH : String = "\u0020-\u007E";
		/** A-Z a-z 0-9 . @ _ - */
		public static const EMAIL : String = "\u0040-\u005A \u0061-\u007A \u0030-\u0039 \u002E \u005F \u002D";
		/** A-Z a-z 0-9 . - : / */
		public static const DOMAIN : String = "\u0041-\u005A \u0061-\u007A \u0030-\u0039 \u002E \u002D \u003A \u002F";
		/** null */
		public static const NULL : String = null;
	}
}
