package ssen.core.utils 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;	
	/**
	 * Asset 들을 가져오는 기능들의 모음
	 * @author SSen
	 */
	public class GetDefinition 
	{
		/** bitmap asset 을 가져온다 */
		public static function getBitmapDefinition(where : DisplayObject, name : String) : BitmapData
		{
			var cl : Class = getDefinition(where, name);
			var bmd : BitmapData;
			bmd = new cl(0, 0);
			return bmd;
		}
		/** asset 을 가져온다 */
		public static function getDefinition(where : DisplayObject, name : String) : Class
		{
			var cl : Class;
			if (where.root != null && where.root.loaderInfo.applicationDomain.hasDefinition(name)) {
				cl = where.root.loaderInfo.applicationDomain.getDefinition(name) as Class;
			} else {
				cl = getDefinitionByName(name) as Class;
			}
			return cl;
		}
	}
}
