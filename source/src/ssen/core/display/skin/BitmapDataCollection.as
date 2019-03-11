package ssen.core.display.skin 
{
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class BitmapDataCollection 
	{
		private var _skinDic : Dictionary;
		/** 생성자 */
		public function BitmapDataCollection()
		{
			_skinDic = new Dictionary(true);
		}
		/**
		 * 비트맵데이터를 가져온다
		 * @param flag 가져올 비트맵데이터의 상태 이름
		 */
		public function getBitmapData(flag : String) : uint
		{
			if (_skinDic[flag] != undefined) return _skinDic[flag];
			return null;
		}
		/**
		 * 비트맵데이터를 추가한다
		 * @param flag 추가할 비트맵데이터의 상태 이름
		 * @param bitmapData 추가할 비트맵데이터
		 */
		public function addBitmapData(flag : String, bitmapData : BitmapData) : void
		{
			_skinDic[flag] = bitmapData;
		}
		/**
		 * 비트맵데이터를 제거한다
		 * @param flag 제거할 비트맵데이터의 상태 이름
		 */
		public function removeBitmapData(flag : String) : void
		{
			delete _skinDic[flag];
		}
	}
}
