package ssen.core.text
{
	import flash.utils.ByteArray;	
	/**
	 * String 도구 모음
	 * @author SSen
	 */
	public class StringUtil
	{
		private static const HANGUL_JAUM : Vector.<String> = Vector.<String>(["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]);

		
		/**
		 * 특정 문자를 모두 교체해준다
		 * @param original 바꿔줄 문자 ex "남자"
		 * @param replace 바꿀 문자 ex "여자"
		 * @param target 바꿔줄 대상 문자열
		 */
		public static function replace(original : String, replace : String, target : String) : String
		{
			var originalReg : RegExp = new RegExp(original, "g");
			return target.replace(originalReg, replace);
		}
		/**
		 * callback 을 통해서 정규식 문자열을 처리한다
		 * @param regStr 정규식 대상 문자
		 * @param callback 콜백함수
		 * @param target 바꿔줄 대상 문자열
		 */
		public static function regex_callback(regStr : String, callback : Function, target : String) : String
		{
			var sets : Array = target.match(new RegExp(regStr, "g"));
			var regEx : RegExp = new RegExp(regStr, "");

			for each(var f:* in sets) {
				var obj : Object = regEx.exec(f);
				var parsed : String = callback(obj);
				var regChange : RegExp = new RegExp(obj[0], "");
				trace("SSEN//", regStr, obj, f, parsed);
				target = target.replace(regChange, parsed);
			}

			return target;
		}
		/**
		 * 공백을 제거한다.
		 * @param original 바꿔줄 문자
		 */
		public static function removeBlank(original : String) : String
		{
			var strs : Array = original.split("");
			var s : String = "";
			var ch : String;
			for each (ch in strs) {
				if (ch != " ") {
					s += ch;
				}
			}
			return s;
		}
		/**
		 * 문자열을 분해해서 입력되는 모양의 시나리오로 만들어준다
		 * @param text 분해할 문자열
		 */
		public static function hangulTypoScenario(text : String) : Vector.<String>
		{
			var vec : Vector.<String> = new Vector.<String>();
			var tmp : String = "";
			var str : Array = text.split("");
			var chr : Vector.<String>;
			var f : int;
			var s : int;
			for (f = 0;f < str.length; f++) {
				chr = hangulWordSplit(str[f]);
				for (s = 0;s < chr.length;s++) {
					vec.push(tmp + chr[s]);
				}
				tmp += chr[s - 1];
			}
			return vec;
		}
		/**
		 * 자, 모음 분리
		 * @param word 분해한 글자
		 */
		public static function hangulWordSplit(word : String) : Vector.<String>
		{
			var vec : Vector.<String> = new Vector.<String>();
			if (word.charCodeAt() >= 44032 && word.charCodeAt() <= 55203) {
				var code : int = word.charCodeAt() - 44032;
				var a : int = code / 588;
				var b : int = a * 588 + 44032;
				var c : int = ((word.charCodeAt() - b) / 28) * 28 + b;
				var d : int = ((word.charCodeAt() - b) / 28) * 28;
				vec.push(HANGUL_JAUM[a]);
				if (d >= 252 && d <= 308) {
					//글자가 "과" 에 관련된 글자일때 ㅗ 를 포함한 글자를 추가
					vec.push(String.fromCharCode(b + 224));
				} else if (d >= 392 && d <= 448) {
					//글자가 "궈" 에 관련된 글자일때 ㅜ 를 포함한 글자를 추가
					vec.push(String.fromCharCode(b + 364));
				} else if (d >= 532 && d <= 559) {
					//글자가 "긔" 에 관련된 글자일때 ㅡ 를 포함한 글자를 추가
					vec.push(String.fromCharCode(b + 504));
				}
				// 자음추가
				vec.push(String.fromCharCode(c));
				// 받침 계산 추가
				if((word.charCodeAt() - c) % 28 != 0) {
					vec.push(word);
				}
			} else if(word.charCodeAt() == 32) {
				vec.push(String.fromCharCode(32));
			} else if (word.charCodeAt() >= 33 && word.charCodeAt() <= 126 && word.charCodeAt() != 47) {
				vec.push(String.fromCharCode(word.charCodeAt()));
			} else if(word.charCodeAt() == 47) {
				vec.push("\n");
			} else {
				vec.push(String.fromCharCode(word.charCodeAt()));
			}
			return vec;
		}
		public static function hangulByteLength(str : String) : uint
		{
			var byte : ByteArray = new ByteArray();
			byte.writeMultiByte(str, "utf-8");
			return byte.length;
		}
	}
}