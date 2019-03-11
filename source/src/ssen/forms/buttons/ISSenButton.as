package ssen.forms.buttons 
{
	import ssen.core.display.base.ISprite;
	import ssen.core.display.expanse.ISSenSprite;
	import ssen.forms.base.ISSenForm;
	/**
	 * Button Interface
	 * @author SSen
	 */
	public interface ISSenButton extends ISSenForm, ISprite, ISSenSprite
	{
		/** toggle 이 선택되어 있는지 확인 */
		function get toggleOn() : Boolean
		function set toggleOn(toggleOn : Boolean) : void
		/** button 의 타입, normal || toggle */
		function get toggle() : Boolean
		function set toggle(toggle : Boolean) : void
		/** 마우스가 눌러진 상태인지 확인 */
		function get isMousePress() : Boolean
		function buttonSkinDraw() : void
	}
}
