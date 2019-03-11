package ssen.core.display.graphics 
{
	import flash.display.BitmapData;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class GraphicsBitmapDraw extends GraphicsDraw 
	{
		private var _bitmapData : BitmapData;
		private var _smooth : Boolean;
		public function get bitmapData() : BitmapData
		{
			return _bitmapData;
		}
		public function set bitmapData(bitmapData : BitmapData) : void
		{
			_bitmapData = bitmapData;
			changed = true;
		}
		public function get smooth() : Boolean
		{
			return _smooth;
		}
		public function set smooth(smooth : Boolean) : void
		{
			_smooth = smooth;
			changed = true;
		}
	}
}
