package test.flour.input 
{
	import ssen.data.selectGroup.SelectGroup;
	import ssen.data.selectGroup.SelectType;
	import ssen.debug.TestButtonGroup;
	import ssen.flour.input.FlourComboBox;

	import test.flour.FlourTest;
	/**
	 * @author SSen
	 */
	public class FlourInputTest extends FlourTest 
	{
		private var _combo : FlourComboBox;
		private var _model : SelectGroup;

		override protected function initialize() : void
		{
			_model = new SelectGroup(SelectType.SINGLE_SELECT);
			_model.addItem("ActionScript 3.0", "page");
			_model.addItem("PHP", "page");
			_model.addItem("C++", "folder");
			_model.addItem("C#", "folder");
			_model.addItem("JavaScript", "page");
			_model.addItem("XBAP", "page");
			_model.addItem("MXML", "folder");
			_model.addItem("Lua", "folder");
			_model.addItem("Python", "page");
			_model.addItem("쎈과 서연", "page");
			_model.addItem("한글테스트", "folder");
			
			_combo = new FlourComboBox(120, _model);
			_combo.moveXY(10, 10);
			//_combo.align = TextFormatAlign.LEFT;
			//_combo.value = "가나다라마바사";
			
			var test : TestButtonGroup = new TestButtonGroup("autoSize", autoSize, "valueChange", valueChange);
			test.position = _combo.nextPositionBr(100);
			
			addChildren(_combo, test);
		}
		private function valueChange() : void
		{
			_combo.value = 123455;
		}
		private function autoSize() : void
		{
			_combo.autoSizeWidth();
			//_combo.autoSizeHeight();
		}
	}
}
