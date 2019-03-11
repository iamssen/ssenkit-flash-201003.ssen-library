package ssen.core.display.skin 
{
	import ssen.core.display.expanse.SSenSprite;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * 여러장의 DisplayObject 를 스킨자원으로 활용하는 SkinDisplayObject
	 * @author SSen
	 */
	public class SkinSprite extends SSenSprite implements ISkinDisplayObject
	{
		private var _object : DisplayObject;
		private var _skinDic : Dictionary;
		private var _skinFlag : String;
		private var _status : InvalidateStatus;
		private var _width : Number;
		private var _height : Number;

		
		/**
		 * 생성자
		 * @param interactiveObject 마우스, 키보드 이벤트를 활성화 시킬지 여부
		 * @param defaultFlag 최초 상태의 이름
		 * @param defaultDisplayObject 최초 상태로 사용할 DisplayObject
		 */
		public function SkinSprite(interactiveObject : Boolean = true, defaultFlag : String = null, defaultDisplayObject : DisplayObject = null)
		{
			_skinDic = new Dictionary(true);
			_status = new InvalidateStatus();
			
			mouseEnabled = interactiveObject;
			mouseChildren = false;
			tabChildren = false;
			
			if (defaultDisplayObject != null) {
				addDisplayObject(defaultFlag, defaultDisplayObject);
				_object = defaultDisplayObject;
				_skinFlag = defaultFlag;
				addChild(_object);
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
		 * manage Object
		 ********************************************************************* */
		/**
		 * displayObject 를 추가한다
		 * @param flag 추가할 displayObject 의 상태 이름
		 * @param object 추가할 displayObject
		 */
		public function addDisplayObject(flag : String, object : DisplayObject) : void
		{
			_skinDic[flag] = object;
		}
		/**
		 * displayObject 를 제거한다
		 * @param flag 제거할 displayObject 의 상태 이름
		 */
		public function removeDisplayObject(flag : String) : void
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
		/** @copy ssen.core.display.skin.ISkinDisplayObject#skinFlag */
		public function get skinFlag() : String
		{
			return _skinFlag;
		}
		/** @copy ssen.core.display.skin.ISkinDisplayObject#resourceKill() */
		public function kill() : void
		{
			_skinDic = null;
			_object = null;
			
			if (stage.hasEventListener(Event.RENDER)) stage.removeEventListener(Event.RENDER, render);
			if (stage.hasEventListener(Event.ENTER_FRAME)) stage.removeEventListener(Event.ENTER_FRAME, render);
			if (hasEventListener(Event.ADDED_TO_STAGE)) removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
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
				var child : DisplayObject = _skinDic[_skinFlag];
				if (_object != null) {
					addChildTo(child, _object);
				} else {
					addChild(child);
				}
				_object = child;
			}
			if (_status["width"]) super.width = _width;
			if (_status["height"]) super.height = _height;
			_status.clear();
		}
	}
}
