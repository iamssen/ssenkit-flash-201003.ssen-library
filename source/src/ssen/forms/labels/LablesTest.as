package ssen.forms.labels 
{
	import ssen.core.display.expanse.SSenSprite;

	/**
	 * @author ssen (i@ssen.name)
	 */
	[SWF(width="550",height="400",frameRate="31",backgroundColor="#444444")]
	public class LablesTest extends SSenSprite 
	{
		private var _roll : RollTextLabel;
		private var _text : TextLable;
		public function LablesTest()
		{
			var data : TextLableData = new TextLableData("안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요.");
			_roll = new RollTextLabel();
			_text = new TextLable();
			
			_roll.initialize();
			_text.initialize();
			
			_roll.setting(data, 100, 20);
			_text.setting(data, 100, 20);
			
			_roll.moveXY(10, 10);
			_text.position = _roll.nextPosition();
			
			trace(_text.text);
			
			addChildren(_roll, _text);
			
			_roll.roll = true;
		}
	}
}
