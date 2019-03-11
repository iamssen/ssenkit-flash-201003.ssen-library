package ssen.component.scroll 
{
	import ssen.core.display.expanse.ISSenSprite;
	import ssen.core.display.base.ISprite;		
	/**
	 * @author SSen
	 */
	public interface IScrollPane extends ISprite, IScrollContainer, ISSenSprite
	{
		function get directionMode() : String
		function wheelOn() : void
		function wheelOff() : void
	}
}
