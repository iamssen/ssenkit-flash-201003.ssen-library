package ssen.core.display.skin 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * Embed 로 가져온 Asset 을 스킨자원으로 활용하는 SkinDisplayObject
	 * @author SSen
	 */
	public class SkinAssetSprite extends SSenSprite implements ISkinDisplayObject 
	{
		private var _skinDic : Dictionary;
		private var _skinFlag : String;
		private var _width : Number;
		private var _height : Number;
		private var _object : DisplayObject;
		private var _cache : Dictionary;
		private var _status : InvalidateStatus;

		
		/**
		 * 생성자
		 * @param interactiveObject 마우스, 키보드 이벤트를 활성화 시킬지 여부
		 * @param width 가로 사이즈
		 * @param height 세로 사이즈
		 * @param defaultFlag 최초 상태의 이름
		 * @param defaultAsset 최초 상태로 사용할 Asset 
		 */
		public function SkinAssetSprite(interactiveObject : Boolean = true, width : Number = 100, height : Number = 100, defaultFlag : String = null, defaultAsset : Class = null)
		{
			_skinDic = new Dictionary(true);
			_cache = new Dictionary(true);
			_status = new InvalidateStatus();
			_width = width;
			_height = height;
			
			mouseEnabled = interactiveObject;
			mouseChildren = false;
			tabChildren = false;
			
			if (defaultFlag != null && defaultAsset != null) {
				addAsset(defaultFlag, defaultAsset);
				_status["width"] = true;
				_status["height"] = true;
				skinDraw(defaultFlag);
			}
		}
		/* *********************************************************************
		 * override art api
		 ********************************************************************* */
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		/** @private */
		override public function set width(value : Number) : void
		{
			if (_width != value) {
				_width = value;
				_status["width"] = true;
				invalidate();
			}
		}
		/** @private */
		override public function get height() : Number
		{
			return _height;
		}
		/** @private */
		override public function set height(value : Number) : void
		{
			if (_height != value) {
				_height = value;
				_status["height"] = true;
				invalidate();
			}
		}
		/* *********************************************************************
		 * manage asset
		 ********************************************************************* */
		/**
		 * Asset을 추가한다
		 * @param flag 추가할 Asset의 상태 이름
		 * @param color 추가할 Asset Class
		 */
		public function addAsset(flag : String, asset : Class) : void
		{
			_skinDic[flag] = asset;
		}
		/**
		 * Asset을 제거한다
		 * @param flag 제거할 Asset의 상태 이름
		 */
		public function removeAsset(flag : String) : void
		{
			delete _skinDic[flag];
		}
		/* *********************************************************************
		 * implement ISkinDisplayObject
		 ********************************************************************* */
		/** @copy ssen.core.display.skin.ISkinDisplayObject#skinDraw() */
		public function skinDraw(flag : String) : void
		{
			if (_skinFlag != flag) {
				_skinFlag = flag;
				_status["skinFlag"] = true;
				invalidate();
			}
		}
		/** @copy ssen.core.display.skin.ISkinDisplayObject#resourceKill() */
		public function kill() : void
		{
			_skinDic = null;
			_object = null; 
			_cache = null;
			
			if (stage.hasEventListener(Event.RENDER)) stage.removeEventListener(Event.RENDER, render);
			if (stage.hasEventListener(Event.ENTER_FRAME)) stage.removeEventListener(Event.ENTER_FRAME, render);
			if (hasEventListener(Event.ADDED_TO_STAGE)) removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		/** @copy ssen.core.display.skin.ISkinDisplayObject#skinFlag */
		public function get skinFlag() : String
		{
			return _skinFlag;
		}
		/* *********************************************************************
		 * display invalidating
		 ********************************************************************* */
		private function invalidate() : void
		{
			if (stage != null) {
				stage.addEventListener(Event.RENDER, render, false, 0, true);
				stage.addEventListener(Event.ENTER_FRAME, render, false, 0, true);
				stage.invalidate();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
			}
		}
		private function addedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			invalidate();
		}
		private function render(event : Event) : void
		{
			if (stage != null) {
				stage.removeEventListener(Event.RENDER, render);
				stage.removeEventListener(Event.ENTER_FRAME, render);
			}
			if (_status.invalidate) rendering();
		}
		private function rendering() : void
		{
			if (_status["skinFlag"]) {
				if (_object != null) {
					removeChild(_object);
					_object = null;
				}
				
				var obj : DisplayObject;
				if (_cache[_skinFlag] == null) {
					var cls : Class = _skinDic[_skinFlag];
					obj = new cls();
					_cache[_skinFlag] = obj;
				} else {
					obj = _cache[_skinFlag];
				}
				
				_status["width"] = true;
				_status["height"] = true;
				_object = obj;
				addChild(obj);
			}
			if (_status["width"]) _object.width = _width;
			if (_status["height"]) _object.height = _height;
			
			_status.clear();
		}
	}
}
