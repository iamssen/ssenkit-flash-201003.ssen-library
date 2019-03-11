package ssen.forms.base 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.forms.labels.RollTextLabel;
	import ssen.forms.labels.TextLableData;
	import ssen.forms.textInput.TextArea;
	import ssen.forms.textInput.TextInputData;
	import ssen.forms.textInput.TextInputType;

	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Quadratic;
	import org.libspark.betweenas3.tweens.IObjectTween;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FormBaseTest extends SSenSprite 
	{
		private var _tween : IObjectTween;
		private var _form : FormSprite;
		private var _area : TextArea;
		public function FormBaseTest()
		{
			var form : RollTextLabel = new RollTextLabel();
			form.initialize();
			form.setting(new TextLableData("안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요. 안녕하세요."));
			
			var text : String = "YYYYY\n";
			var f : int = 50;
			while (--f >= 0) {
				text += "abcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuXXX\n";
			}
			text += "XXXXXX";
			var data1 : TextInputData = new TextInputData("10000", TextInputType.NUMBER);
			var data2 : TextInputData = new TextInputData(text);
			
			_area = new TextArea();
			_area.initialize();
			_area.setting(data2);
			
			_form = _area;
			addChild(_form);
			
			_tween = BetweenAS3.tween(_form, {width:400, height:200}, {width:form.formWidth, height:form.formHeight}, 1, Quadratic.easeOut);
			BetweenAS3.repeat(_tween, 10).play();
		}
	}
}

import ssen.core.display.graphics.Image;
import ssen.forms.base.FormSprite;

internal class Form extends FormSprite
{

	[Embed(source="asset/action.png")]
	public static var testImage : Class;
	public function Form() 
	{
		var image : Image = new Image(0, 0, 0, 0, new testImage().bitmapData);
		image.draw(graphics);
		formWidth = image.width;
		formHeight = image.height;
	}
}
