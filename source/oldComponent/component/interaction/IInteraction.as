package ssen.component.interaction 
{
	/**
	 * @author SSen
	 */
	public interface IInteraction 
	{
		function start() : void;
		function stop() : void;
		function get enabled() : Boolean
		function resourceKill() : void;
	}
}
