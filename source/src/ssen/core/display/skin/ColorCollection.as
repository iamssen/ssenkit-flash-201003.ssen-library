package ssen.core.display.skin 
{
	import flash.utils.Dictionary;
	/**
	 * 색(色)들을 모아서 스킨 형태로 사용한다
	 * @author SSen
	 */
	public class ColorCollection
	{
		private var _skinDic : Dictionary;

		
		/** 생성자 */
		public function ColorCollection()
		{
			_skinDic = new Dictionary(true);
		}
		/**
		 * 색을 가져온다
		 * @param flag 가져올 색의 상태 이름
		 */
		public function getColor(flag : String) : uint
		{
			if (_skinDic[flag] != undefined) return _skinDic[flag];
			return 0xffffff;
		}
		/**
		 * 색을 추가한다
		 * @param flag 추가할 색의 상태 이름
		 * @param color 추가할 색
		 */
		public function addColor(flag : String, color : uint) : void
		{
			_skinDic[flag] = color;
		}
		/**
		 * 색을 제거한다
		 * @param flag 제거할 색의 상태 이름
		 */
		public function removeColor(flag : String) : void
		{
			delete _skinDic[flag];
		}
	}
}
