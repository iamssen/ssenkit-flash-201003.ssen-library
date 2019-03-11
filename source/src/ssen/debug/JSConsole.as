package ssen.debug 
{
	import flash.external.ExternalInterface;			
	/**
	 * safari, fire bug, chrome 등의 console 연결
	 * @author SSen
	 */
	public class JSConsole 
	{
		/** console message */
		public static function console(...messages) : void
		{
			messages.unshift("FROM FLASH//");
			ExternalInterface.call("console.log", messages.join(" "));
			messages.shift();
			messages.unshift("JS CONSOLE//");
			trace.apply(null, messages);
		}
	}
}
