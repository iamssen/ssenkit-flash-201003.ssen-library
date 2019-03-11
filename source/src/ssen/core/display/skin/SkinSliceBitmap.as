package ssen.core.display.skin 
{
	import ssen.core.geom.GridType;
	import ssen.core.display.SliceBitmapDraw;
	import ssen.core.display.expanse.SSenSprite;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * 9Slice, 3Slice 등의 비트맵을 스킨 자원으로 활용하는 SkinDisplayObject
	 * @author SSen
	 */
	public class SkinSliceBitmap extends SSenSprite implements ISkinDisplayObject 
	{
		private var _skinDic : Dictionary;
		private var _skinFlag : String;
		private var _width : Number;
		private var _height : Number;
		private var _scale9Grid : Rectangle;
		private var _gridType : String;
		private var _status : InvalidateStatus;
		private var _bitmapData : BitmapData;
		/**
		 * 생성자
		 * @param interactiveObject 마우스, 키보드 이벤트를 활성화 시킬지 여부
		 * @param width 가로 사이즈
		 * @param height 세로 사이즈
		 * @param scale9Grid Scale9Grid
		 * @param gridType slice type
		 * @param defaultFlag 최초 상태의 이름
		 * @param defaultBitmapData 최초 상태로 사용할 BitmapData
		 */
		public function SkinSliceBitmap(interactiveObject : Boolean = true, width : Number = 100, height : Number = 100, scale9Grid : Rectangle = null, gridType : String = "scale9Grid", defaultFlag : String = null, defaultBitmapData : BitmapData = null)
		{
			_skinDic = new Dictionary(true);
			_status = new InvalidateStatus();
			_width = width;
			_height = height;
			_scale9Grid = scale9Grid;
			_gridType = gridType;
			
			mouseEnabled = interactiveObject;
			mouseChildren = false;
			tabChildren = false;
			
			if (defaultFlag != null && defaultBitmapData != null) {
				_skinFlag = defaultFlag;
				_skinDic[defaultFlag] = defaultBitmapData;
				skinDraw(_skinFlag);
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
		override public function get scale9Grid() : Rectangle
		{
			return _scale9Grid;
		}
		override public function set scale9Grid(scale9Grid : Rectangle) : void
		{
			_scale9Grid = scale9Grid;
			_status["scale9Grid"] = true;
			invalidate();
		}
		public function get gridType() : String
		{
			return _gridType;
		}
		public function set gridType(gridType : String) : void
		{
			_gridType = gridType;
			_status["gridType"] = true;
			invalidate();
		}
		/* *********************************************************************
		 * manage bitmap
		 ********************************************************************* */
		/**
		 * bitmapData 를 추가한다
		 * @param flag 추가할 bitmapData 의 상태 이름
		 * @param bitmapData 추가할 bitmapData
		 */
		public function addBitmapData(flag : String, bitmapData : BitmapData) : void
		{
			_skinDic[flag] = bitmapData;
		}
		/**
		 * bitmapData 를 제거한다
		 * @param flag 제거할 bitmapData 의 상태 이름
		 */
		public function removeBitmapData(flag : String) : void
		{
			var bmd : BitmapData = _skinDic[flag];
			bmd.dispose();
			delete _skinDic[flag];
		}
		/* *********************************************************************
		 * implement ISkinDisplayObejct
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
		 * utils
		 ********************************************************************* */
		protected function draw() : void
		{
			if (_bitmapData) _bitmapData.dispose();
			var g : Graphics = graphics;
			g.clear();
			
			switch (_gridType) {
				case GridType.SCALE_3_GRID_HORIZONTAL :
					_bitmapData = SliceBitmapDraw.draw3SliceHorizontal(_skinDic[_skinFlag], _scale9Grid, _width);
					break;
				case GridType.SCALE_3_GRID_VERTICAL : 
					_bitmapData = SliceBitmapDraw.draw3SliceVertical(_skinDic[_skinFlag], _scale9Grid, _height);
					break;
				default : 
					_bitmapData = SliceBitmapDraw.draw9Slice(_skinDic[_skinFlag], _scale9Grid, _width, _height);
					break;
			}
			
			g.beginBitmapFill(_bitmapData);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
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
			draw();
			_status.clear();
		}
	}
}
