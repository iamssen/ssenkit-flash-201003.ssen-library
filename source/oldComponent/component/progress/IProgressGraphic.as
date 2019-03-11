package ssen.component.progress 
{
	import ssen.core.display.base.IDisplayObject;
	import ssen.core.display.expanse.ISSenDisplayObject;		
	/**
	 * @author SSen
	 */
	public interface IProgressGraphic extends IDisplayObject, ISSenDisplayObject
	{
		function get progress() : Number
		function set progress(value : Number) : void
		function resourceKill() : void
	}
}
