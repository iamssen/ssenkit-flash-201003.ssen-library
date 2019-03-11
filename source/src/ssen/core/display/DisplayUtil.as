package ssen.core.display 
{
	import ssen.core.geom.Padding;
	import ssen.core.number.MathEx;

	import flash.display.DisplayObject;
	/**
	 * @author ssen
	 */
	public class DisplayUtil 
	{
		public static function transformInStage(display : DisplayObject, width : int, height : int, full : Boolean, ratio : Boolean, padding : Padding = null) : void
		{
			if (padding == null) padding = new Padding(0, 0, 0, 0);
			var w : Number = width - padding.left - padding.right;
			var h : Number = height - padding.top - padding.bottom;
			var transform : Vector.<int>;
			
			if (full) {
				if (ratio) {
					transform = MathEx.ratioTransform(display.width, display.height, w, h);
					display.width = transform[0];
					display.height = transform[1];
					display.x = transform[2];
					display.y = transform[3];
				} else {
					display.width = w;
					display.height = h;
				}
			} else {
				if (display.width > w || display.height > h) {
					transform = MathEx.ratioTransform(display.width, display.height, w, h);
					display.width = transform[0];
					display.height = transform[1];
					display.x = transform[2];
					display.y = transform[3];
				} else {
					display.x = (w >> 1) - (display.width >> 1);
					display.y = (h >> 1) - (display.height >> 1);
				}
			}
			display.x += padding.left;
			display.y += padding.top;
		}
	}
}
