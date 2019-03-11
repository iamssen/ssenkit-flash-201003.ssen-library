package ssen.core.display 
{
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	/**
	 * @author ssen
	 */
	public class CreateGraphicsStroke
	{
		public static function solid(thickness : Number = 1, color : uint = 0x000000, alpha : Number = 1, pixelHinting : Boolean = false, scaleMode : String = "normal", caps : String = "none", joints : String = "round", miterLimit : Number = 3.0) : GraphicsStroke
		{
			var fill : GraphicsSolidFill = new GraphicsSolidFill(color, alpha);
			return new GraphicsStroke(thickness, pixelHinting, scaleMode, caps, joints, miterLimit, fill);
		}
	}
}
