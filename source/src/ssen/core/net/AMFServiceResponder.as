package ssen.core.net 
{
	import ssen.core.events.RespondEvent;

	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.ErrorMessage;

	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	/**
	 * @author ssen
	 */
	public class AMFServiceResponder extends Responder 
	{
		private var _respond : Function;
		private var _netConnection : NetConnection;

		
		public function AMFServiceResponder(respond : Function)
		{
			_respond = respond;
			super(result, status);
		}
		private function status(message : ErrorMessage) : void
		{
			_respond(new RespondEvent(RespondEvent.RESPOND, false, null, 404, "amfServiceFail", message.faultString));
			clear();
		}
		private function result(message : AcknowledgeMessage) : void
		{
			_respond(new RespondEvent(RespondEvent.RESPOND, true, message.body, 200));
			clear();
		}
		internal function setNetConnection(netConnection : NetConnection) : void
		{
			_netConnection = netConnection;
			_netConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError, false, 0, true);
			_netConnection.addEventListener(IOErrorEvent.IO_ERROR, ioError, false, 0, true);
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatus, false, 0, true);
			_netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError, false, 0, true);
		}
		private function securityError(event : SecurityErrorEvent) : void
		{
			_respond(new RespondEvent(RespondEvent.RESPOND, false, null, 0, event.type, event.text));
			clear();
		}
		private function netStatus(event : NetStatusEvent) : void
		{
			_respond(new RespondEvent(RespondEvent.RESPOND, false, event.info, 0, event.type));
			clear();
		}
		private function ioError(event : IOErrorEvent) : void
		{
			_respond(new RespondEvent(RespondEvent.RESPOND, false, null, 0, event.type, event.text));
			clear();
		}
		private function asyncError(event : AsyncErrorEvent) : void
		{
			_respond(new RespondEvent(RespondEvent.RESPOND, false, null, 0, event.type, event.text));
			clear();
		}
		private function clear() : void
		{
			if (_netConnection != null) {
				_netConnection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncError);
				_netConnection.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
				_netConnection.removeEventListener(NetStatusEvent.NET_STATUS, netStatus);
				_netConnection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
				_netConnection = null;
			}
			_respond = null;
		}
	}
}
