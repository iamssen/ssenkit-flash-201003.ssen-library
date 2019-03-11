package ssen.debug 
{
	import flash.external.ExternalInterface;			
	/**
	 * fire bug 디버거 연결
	 * @author SSen
	 */
	public class Firebug 
	{
		/** console message */
		public static function console(...messages) : void
		{
			messages.unshift("FROM FLASH//");
			ExternalInterface.call("console.log", messages.join(" "));
			messages.shift();
			messages.unshift("FIRE BUG//");
			trace.apply(null, messages);
		}
	}
}
