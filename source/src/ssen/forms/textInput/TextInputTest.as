package ssen.forms.textInput 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.number.MathEx;
	import ssen.debug.TestButtonGroup;
	import ssen.forms.base.ISSenFormData;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TextInputTest extends SSenSprite 
	{
		private var _single : InputTextField;
		private var _area : TextArea;
		public function TextInputTest()
		{
			var text : String = "YYYYY\n";
			var f : int = 50;
			while (--f >= 0) {
				text += "abcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuXXX\n";
			}
			text += "XXXXXX";
			var data1 : TextInputData = new TextInputData("10000", TextInputType.NUMBER);
			var data2 : TextInputData = new TextInputData(text);
			
			_single = new InputTextField();
			_single.initialize();
			_single.setting(data1);
			_single.border = true;
			_single.moveXY(10, 10);
			
			_area = new TextArea();
			_area.initialize();
			_area.setting(data2);
			_area.position = _single.nextPosition();
			
			var tb : TestButtonGroup = new TestButtonGroup();
			tb.moveXY(10, 300);
			tb.addTest("data change", dataChange, "size change", sizeChange, "enable change", enableChange);
			
			addChildren(_single, _area, tb);
		}
		private function enableChange() : void 
		{
			_single.enabled = !_single.enabled;
			_area.enabled = !_area.enabled;
		}
		private function dataChange() : void 
		{
			var data : ISSenFormData = _single.data;
			_single.data = _area.data;
			_area.data = data;
		}
		private function sizeChange() : void 
		{
			_single.setFormSize(MathEx.rand(100, 300), MathEx.rand(20, 150));
			_area.setFormSize(MathEx.rand(100, 300), MathEx.rand(100, 300));
		}
	}
}
