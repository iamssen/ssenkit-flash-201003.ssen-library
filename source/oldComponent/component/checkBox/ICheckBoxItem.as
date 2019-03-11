package ssen.component.checkBox 
{
	import ssen.component.base.IComponent;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.data.selectGroup.ISelectItem;	
	/**
	 * @author SSen
	 */
	public interface ICheckBoxItem extends IComponent, ISkinDisplayObject 
	{
		function get data() : ISelectItem
		function set data(data : ISelectItem) : void
	}
}
