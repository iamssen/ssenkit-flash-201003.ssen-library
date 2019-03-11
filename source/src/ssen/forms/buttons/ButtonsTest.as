package ssen.forms.buttons 
{
	import ssen.core.number.MathEx;
	import ssen.debug.TestButtonGroup;
	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ButtonsTest extends SSenSprite 
	{
		private var _lable : LableButton;
		private var _bitmap : BitmapButton;
		public function ButtonsTest()
		{
			_lable = new LableButton();
			_bitmap = new BitmapButton();
			
			_lable.initialize();
			_bitmap.initialize();
			
			_lable.setting(150, 40, "test button test button test button test button test button");
			_bitmap.setting();
			
			_lable.moveXY(10, 10);
			_bitmap.position = _lable.nextPosition();
			
			var tb:TestButtonGroup = new TestButtonGroup();
			tb.moveXY(10, 200);
			tb.addTest("size change", sizeChange, "title change", titleChange, "toggle change", toggleChange);
			
			addChildren(_lable, _bitmap, tb);
		}
		private function toggleChange() : void 
		{
			_lable.toggle = !_lable.toggle;
			_bitmap.toggle = !_bitmap.toggle;
		}
		private function titleChange() : void 
		{
			_lable.title = "title changed title changed title changed title changed title changed";
		}
		private function sizeChange() : void 
		{
			_lable.setFormSize(MathEx.rand(60, 200), MathEx.rand(25, 100));
			_bitmap.position = _lable.nextPosition();
		}
	}
}
