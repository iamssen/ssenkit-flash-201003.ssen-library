package ssen.forms.panel 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface IPanelObject extends IEventDispatcher
	{
		function get id() : int
		function set id(id : int) : void
		function get rise() : Boolean
		function set rise(rise : Boolean) : void
		function register(parent : DisplayObjectContainer = null, index : int = -1) : Boolean
		function deregister() : Boolean
	}
}
