package ssen.component.buttons 
{
	import ssen.core.display.expanse.ISSenSprite;	
	import ssen.component.base.ISSenComponent;
	import ssen.core.display.base.ISprite;		
	/**
	 * Button Interface
	 * @author SSen
	 */
	public interface IButton extends ISSenComponent, ISprite, ISSenSprite
	{
		/** toggle 이 선택되어 있는지 확인 */
		function get toggleOn() : Boolean;
		function set toggleOn(toggleOn : Boolean) : void;
		/** button 의 타입, normal || toggle */
		function get buttonType() : String;
		function set buttonType(buttonType : String) : void;
		/** 마우스가 눌러진 상태인지 확인 */
		function get isMousePress() : Boolean;
	}
}
