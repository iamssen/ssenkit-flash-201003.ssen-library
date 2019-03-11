package ssen.core.net 
{
	import ssen.core.number.MathEx;

	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;

	import flash.display.BitmapData;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;	
	/**
	 * Multipart form data 를 전송한다
	 * @author SSen
	 */
	public class MultyformToHTTP extends EventDispatcher 
	{
		private var _request : URLRequest;
		private var _loader : URLLoader;
		private var _boundary : String;
		private var _content : ByteArray;

		
		public function MultyformToHTTP()
		{
			_boundary = getRandomBoundary();
			_content = new ByteArray();
		}
		/**
		 * BitmapData를 jpg 파일로 추가한다
		 * @param bitmapData 이미지 데이터
		 * @param fileName 파일 이름
		 * @param quality jpg 압축 퀄리티
		 */
		public function pushJpgImage(bitmapData : BitmapData, fileName : String, quality : Number = 50.0) : void
		{
			var encoder : JPEGEncoder = new JPEGEncoder(quality);
			push(encoder.encode(bitmapData), fileName, "jpg");
		}
		/**
		 * BitmapData를 png 파일로 추가한다
		 * @param bitmapData 이미지 데이터
		 * @param fileName 파일 이름
		 */
		public function pushPngImage(bitmapData : BitmapData, fileName : String) : void
		{
			var encoder : PNGEncoder = new PNGEncoder();
			push(encoder.encode(bitmapData), fileName, "png");
		}
		/**
		 * HTTP 프로토콜의 body 에 보낼 이미지파일을 추가한다
		 * @param fileByte file의 byteArray
		 * @param fileName file 의 이름
		 * @param fileType file 의 확장자 이름
		 */
		public function push(fileByte : ByteArray, fileName : String, fileType : String) : void
		{
			try {
				_content.writeUTFBytes('-----------------------------' + _boundary + '\r\n');
				_content.writeUTFBytes('Content-Disposition: form-data; name="' + fileName + '"; filename="' + fileName + '.' + fileType + '"\r\n');
				_content.writeUTFBytes('Content-Type: application/octet-stream\r\n\r\n');
					
				_content.writeBytes(fileByte, 0, fileByte.length);
				_content.writeUTFBytes("\r\n");
			} catch (e : IOError) {
				trace("SSEN//", e);
			}
		}
		/**
		 * HTTP 프로토콜의 body 에 보낼 이미지파일을 추가한다
		 * @param fileByte file의 byteArray
		 * @param fileName file 의 이름
		 * @param fileType file 의 확장자 이름
		 */
		public function pushText(string : String, name : String) : void
		{
			try {
				_content.writeUTFBytes('-----------------------------' + _boundary + '\r\n');
				_content.writeUTFBytes('Content-Disposition: form-data; name="' + name + '"\r\n\r\n');
					
				_content.writeMultiByte(string, "utf-8");
				_content.writeUTFBytes("\r\n");
			} catch (e : IOError) {
				trace("SSEN//", e);
			}
		}
		/**
		 * 최종적으로 web 으로 전송한다
		 * @param url 파일처리를 할 서버사이드 스크립트의 경로
		 */
		public function send(url : String) : void
		{
			_content.writeUTFBytes('-----------------------------' + _boundary + '\r\nContent-Disposition: form-data; name="Upload"\r\n\r\nSubmit Query\r\n-----------------------------' + _boundary + '--\r\n');
				
			_request = new URLRequest(url);
			_request.data = _content;
			_request.method = URLRequestMethod.POST;
			_request.contentType = "multipart/form-data; boundary=---------------------------" + _boundary;
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, loaderComplete);
			
			try {
				_loader.load(_request);
			} catch (e : Error) {
				trace("SSEN//", "Error : " + e);
			}
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		// complete event
		private function loaderComplete(event : Event) : void
		{
			try{
				trace(_loader.data);
			} catch (e:Error){
				trace(e);
			}
			dispatchEvent(event);
		}
		// 13 자리로 된 multypart/form-data 의 boundary 를 랜덤생성
		private function getRandomBoundary() : String
		{
			var boundary : String = "";
			var sets : Array = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e"];
			for (var f : int = 1;f <= 13; f++) {
				var n : int = MathEx.rand(1, 14);
				boundary += sets[n];
			}
			
			return boundary;
		}
	}
}
