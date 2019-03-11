package ssen.core.display.skin 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;

	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * GraphicsFill 을 스킨 자원으로 활용하는 SkinDisplayObject
	 * @author SSen
	 */
	public class SkinFillRect extends SSenSprite implements ISkinDisplayObject 
	{
		private var _fillDic : Dictionary;
		private var _strokeDic : Dictionary;
		/** @private */
		protected var _skinFlag : String;
		/** @private */
		protected var _width : Number;
		/** @private */
		protected var _height : Number;
		/** @private */
		protected var _graphicsData : Vector.<IGraphicsData>;
		/** @private */
		protected var _status : InvalidateStatus;

		
		/**
		 * 생성자
		 * @param interactiveObject 마우스, 키보드 이벤트를 활성화 시킬지 여부
		 * @param width 가로 사이즈
		 * @param height 세로 사이즈
		 * @param defaultFlag 최초 상태의 이름
		 * @param defaultAsset 최초 상태로 사용할 fill
		 * @param defaultStroke 최초 상태로 사용할 stroke
		 */
		public function SkinFillRect(interactiveObject : Boolean = true, width : Number = 100, height : Number = 100, defaultFlag : String = null, defaultFill : IGraphicsFill = null, defaultStroke : GraphicsStroke = null)
		{
			_fillDic = new Dictionary(true);
			_strokeDic = new Dictionary(true);
			_status = new InvalidateStatus();
			_graphicsData = new Vector.<IGraphicsData>(4, true);
			_graphicsData[3] = new GraphicsEndFill();
			
			mouseEnabled = interactiveObject;
			mouseChildren = false;
			tabChildren = false;
			
			setRectanglePath(width, height);
			if (defaultFlag != null && defaultFill != null) {
				addFill(defaultFlag, defaultFill, defaultStroke);
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
				skinDraw(_skinFlag);
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
				skinDraw(_skinFlag);
				invalidate();
			}
		}
		/* *********************************************************************
		 * manage fill
		 ********************************************************************* */
		/**
		 * fill을 추가한다
		 * @param flag 추가할 fill의 상태 이름
		 * @param color 추가할 fill
		 * @param stroke 추가할 stroke
		 */
		public function addFill(flag : String, fill : IGraphicsFill, stroke : GraphicsStroke = null) : void
		{
			_fillDic[flag] = fill;
			_strokeDic[flag] = stroke;
		}
		/**
		 * fill을 제거한다
		 * @param flag 제거할 fill의 상태 이름
		 */
		public function removeFill(flag : String) : void
		{
			delete _fillDic[flag];
			delete _strokeDic[flag];
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
			_fillDic = null;
			_strokeDic = null;
			_graphicsData = null;
			
			if (stage.hasEventListener(Event.RENDER)) stage.removeEventListener(Event.RENDER, render);
			if (stage.hasEventListener(Event.ENTER_FRAME)) stage.removeEventListener(Event.ENTER_FRAME, render);
			if (hasEventListener(Event.ADDED_TO_STAGE)) removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		/** @private */
		protected function setRectanglePath(width : Number, height : Number) : void
		{
			_width = width;
			_height = height;
			
			var path : GraphicsPath = new GraphicsPath();
			path.lineTo(width, 0);
			path.lineTo(width, height);
			path.lineTo(0, height);
			path.lineTo(0, 0);
			_graphicsData[2] = path;
		}
		/* *********************************************************************
		 * display invalidating
		 ********************************************************************* */
		/** @private */
		protected function invalidate() : void
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
		/** @private */
		protected function rendering() : void
		{
			if (_status["width"] || _status["height"]) {
				setRectanglePath(_width, _height);
				_status["skinFlag"] = true;
			}
			if (_status["skinFlag"]) {
				_graphicsData[0] = IGraphicsData(_fillDic[_skinFlag]);
				_graphicsData[1] = IGraphicsData(_strokeDic[_skinFlag]);
				graphics.clear();
				graphics.drawGraphicsData(_graphicsData);
			}
			_status.clear();
		}
	}
}
