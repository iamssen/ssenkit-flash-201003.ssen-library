package ssen.core.events 
{
	import flash.events.Event;
	/**
	 * 로더에 대한 응답 이벤트
	 * @author ssen
	 */
	public class RespondEvent extends Event 
	{
		public static const RESPOND : String = "respond";
		private var _success : Boolean;
		private var _data : Object;
		private var _httpStatus : int;
		private var _errorMessage : String;
		private var _errorType : String;

		
		/**
		 * 로더에 대한 응답 이벤트
		 * @param success 응답 성공 여부
		 * @param data 응답되어 돌아온 데이터
		 * @param httpStatus httpStatus code
		 * @param errorType error type
		 * @param errorMessage error message 
		 */
		public function RespondEvent(type : String, success : Boolean, data : Object = null, httpStatus : int = 0, errorType : String = null, errorMessage : String = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			_success = success;
			_data = data;
			_httpStatus = httpStatus;
			_errorType = errorType;
			_errorMessage = errorMessage;
		}
		/** 응답 성공 여부 */
		public function get success() : Boolean
		{
			return _success;
		}
		/** 응답되어 돌아온 데이터 */
		public function get data() : Object
		{
			return _data;
		}
		/** httpStatus code */
		public function get httpStatus() : int
		{
			return _httpStatus;
		}
		/** error message */
		public function get errorMessage() : String
		{
			return _errorMessage;
		}
		override public function clone() : Event
		{
			return new RespondEvent(type, success, data, httpStatus, errorType, errorMessage, bubbles, cancelable);
		}
		override public function toString() : String
		{
			return formatToString("RespondEvent", "type", "success", "data", "httpStatus", "errorType", "errorMessage", "bubbles", "cancelable");
		}
		/** error type */
		public function get errorType() : String
		{
			return _errorType;
		}
	}
}
