package ssen.forms.tooltip 
{
	import flash.events.IEventDispatcher;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public interface IToolTipObject extends IEventDispatcher
	{
		function get id() : String
		function set id(id : String) : void
		function open() : void
		function close() : void
	}
}
