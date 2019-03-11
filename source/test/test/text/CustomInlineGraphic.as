package test.text 
{
	import flash.display.Shape;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class CustomInlineGraphic extends Shape 
	{
		private var _color : uint;
		private var _width : int;
		private var _height : int;

		
		public function CustomInlineGraphic(color : uint, width : int, height : int)
		{
			_color = color;
			_width = width;
			_height = height;
			graphics.beginFill(0xff0000);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
		}
		override public function toString() : String
		{
			return '[CustomInlineGraphic color="' + _color + '" width="' + _width + '" height="' + _height + '"]';
		}
	}
}
