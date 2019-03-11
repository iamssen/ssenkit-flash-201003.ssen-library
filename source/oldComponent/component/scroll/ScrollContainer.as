package ssen.component.scroll 
{
	import ssen.component.events.ScrollEvent;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.filters.FavoriteColorMatrix;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.filters.ColorMatrixFilter;	

	/** @copy ssen.component.events.ScrollEvent#MASK_ON */
	[Event(name="maskOn", type="ssen.component.events.ScrollEvent")]

	/** @copy ssen.component.events.ScrollEvent#MASK_OFF */
	[Event(name="maskOff", type="ssen.component.events.ScrollEvent")]

	/** @copy ssen.component.events.ScrollEvent#CONTENT_CHANGE */
	[Event(name="contentChange", type="ssen.component.events.ScrollEvent")]

	/** @copy ssen.component.events.ScrollEvent#CONTENT_DELETED */
	[Event(name="contentDeleted", type="ssen.component.events.ScrollEvent")]

	/** @copy ssen.component.events.ScrollEvent#SCROLL */
	[Event(name="scroll", type="ssen.component.events.ScrollEvent")]
	/**
	 * Description
	 * @author SSen
	 */
	public class ScrollContainer extends SSenSprite implements ISkinDisplayObject, IScrollContainer
	{
		private var _width : Number;
		private var _height : Number;
		// secX 의 저장소
		private var _secX : Number = 0;
		// secY 의 저장소
		private var _secY : Number = 0;
		/** content 의 저장소 */
		private var _content : DisplayObject;
		/** mask object 의 저장소 */
		private var _mask : Shape;
		/** maskOn 의 저장소 */
		protected var _maskOn : Boolean;
		private var _skinMode : String;
		private var _enable : Boolean;
		private var _disableFilter : Boolean;

		
		public function ScrollContainer(content : DisplayObject = null, width : Number = 300, height : Number = 300, maskOn : Boolean = true, secX : Number = 0, secY : Number = 0)
		{
			_width = width;
			_height = height;
			_secX = secX;
			_secY = secY;
			_content = content;
			_maskOn = maskOn;
			
			_skinMode = SkinFlag.DEFAULT;
			_enable = true;
			
			init();
		}
		public function skinDraw(flag : String) : void
		{
			if (flag == SkinFlag.DISABLE) {
				_skinMode = SkinFlag.DISABLE;
				filters = (_disableFilter) ? [new ColorMatrixFilter(FavoriteColorMatrix.DISABLE)] : [];
			} else {
				_skinMode = SkinFlag.DEFAULT;
				filters = [];
			}
		}
		public function get skinFlag() : String
		{
			return _skinMode;
		}
		public function get skinFlagList() : Vector.<String>
		{
			return Vector.<String>([SkinFlag.DEFAULT, SkinFlag.DISABLE]);
		}
		private function init() : void
		{
			if (_content != null) { 
				addChild(_content); 
			}
			secX = _secX;
			secY = _secY;
			maskOn = _maskOn;
		}
		/* *********************************************************************
		 * Interface Properties and Methods :: positioning
		 ********************************************************************* */
		/** 현재 X위치의 0~1 값 */
		public function get secX() : Number
		{
			return _secX;
		}
		public function set secX(sec : Number) : void
		{
			_secX = sec;
			if (_content != null) {
				_content.x = secToX(sec);
			}
		}
		/** 현재 Y위치의 0~1 값 */
		public function get secY() : Number
		{
			return _secY;
		}
		public function set secY(sec : Number) : void
		{
			_secY = sec;
			if (_content != null) {
				_content.y = secToY(sec);
			}
		}
		/** content 의 x 위치 */
		public function get contentX() : Number
		{
			return _content.x;
		}
		public function set contentX(value : Number) : void
		{
			if (_content != null) {
				var xMin : Number = getXMin();
				if (value > 0) {
					_content.x = 0;
				} else if (value < xMin) {
					_content.x = xMin;
				} else {
					_content.x = value;
				}
				_secX = _content.x / (_width - content.width);
				dispatchScroll();
			} else {
				trace("SSEN//", this, "container 에 content 가 null 이라 무효화됨");
			}
		}
		/** content 의 y 위치 */
		public function get contentY() : Number
		{
			return _content.y;
		}
		public function set contentY(value : Number) : void
		{
			if (_content != null) {
				var yMin : Number = getYMin();
				if (value > 0) {
					_content.y = 0;
				} else if (value < yMin) {
					_content.y = yMin;
				} else {
					_content.y = value;
				}
				_secY = _content.y / (_height - content.height);
				dispatchScroll();
			} else {
				trace(this, "container 에 content 가 null 이라 무효화됨");
			}
		}
		/* *********************************************************************
		 * Interface Properties and Methods 
		 ********************************************************************* */
		/** @private */
		public function resourceKill() : void
		{
			_content = null;
			_mask = null;
		}
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			if (_content != null) {
				maskSize(value, _height);
				alignContent();
			}
		}
		/** @private */
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			if (_content != null) {
				maskSize(_width, value);
				alignContent();
			}
		}
		/** mask 의 활성, 비활성 여부 */
		public function get maskOn() : Boolean
		{
			return _maskOn;
		}
		public function set maskOn(bool : Boolean) : void
		{
			_maskOn = bool;
			if (_content != null) {
				if (bool) {
					addMask();
					dispatchEvent(new ScrollEvent(ScrollEvent.MASK_ON));
				} else {
					removeMask();
					dispatchEvent(new ScrollEvent(ScrollEvent.MASK_OFF));
				}
			}
		}
		/** container 의 width */
		public function get containerWidth() : Number
		{
			return _width;
		}
		/** container 의 height */
		public function get containerHeight() : Number
		{
			return _height;
		}
		/** content 의 width */
		public function get contentWidth() : Number
		{
			return (_content != null) ? _content.width : 0;
		}
		/** content 의 height */
		public function get contentHeight() : Number
		{
			return (_content != null) ? _content.height : 0;
		}
		/** 내용이 되는 display object */
		public function get content() : DisplayObject
		{
			return _content;
		}
		public function set content(content : DisplayObject) : void
		{
			removeContent();
			_content = content;
			addChild(_content);
			refresh();
			_content = content; 
		}
		/** content 를 삭제한다 */
		public function deleteContent() : void
		{
			removeContent();
			dispatchEvent(new ScrollEvent(ScrollEvent.CONTENT_DELETED));
		}
		/** content 의 size 가 변경되거나 할 경우 호출해서, 사이즈를 재정렬 시켜준다 */
		public function refresh() : void
		{
			alignContent();
			if (_maskOn) {
				addMask();
			}
			dispatchEvent(new ScrollEvent(ScrollEvent.CONTENT_CHANGE));
		}
		public function get disableFilter() : Boolean
		{
			return _disableFilter;
		}
		public function set disableFilter(bool : Boolean) : void
		{
			_disableFilter = bool;
			skinDraw(_skinMode);
		}
		/* *********************************************************************
		 * Private Util functions
		 ********************************************************************* */
		// content 를 재정렬 시킨다.
		private function alignContent() : void
		{
			if (_content.width < _width) _secX = 0;
			if (_content.height < _height) _secY = 0;
			_content.x = secToX(_secX);
			_content.y = secToY(_secY);
		}
		// content 를 삭제한다.
		private function removeContent() : void
		{
			if (_content != null) {
				if (contains(_content)) {
					removeChild(_content);
				}
				_content = null;
			}
		}
		// mask 의 사이즈를 조절한다.
		private function maskSize(width : Number, height : Number) : void
		{
			if (_maskOn && _mask != null) {
				_mask.width = width;
				_mask.height = height;
			}
		}
		// mask 를 활성화 시킨다.
		private function addMask() : void
		{
			removeMask();
			if (_maskOn) {
				_mask = new Shape();
				var g : Graphics = _mask.graphics;
				g.beginFill(0xeeeeee);
				g.drawRect(0, 0, _width, _height);
				g.endFill();
				addChild(_mask);
				_content.mask = _mask;
			}
		}
		// mask 를 비활성 시킨다.
		private function removeMask() : void
		{
			if (_mask != null) {
				_content.mask = null;
				if (contains(_mask)) {
					removeChild(_mask);
				}
				_mask = null;
			}
		}
		// sec 를 저장하고, ScrollEvent 를 dispatch 시킨다
		private function dispatchScroll() : void
		{
			dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL, _secX, _secY));
		}
		// sec 를 x 위치로 바꿔서 반환
		private function secToX(sec : Number) : Number
		{
			return sec * (getXMin());
		}
		// sec 를 y 위치로바꿔서 반환
		private function secToY(sec : Number) : Number
		{
			return sec * (getYMin());
		}
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable != _enable) {
				if (enable) {
					mouseChildren = true;
					mouseEnabled = true;
					skinDraw(SkinFlag.DEFAULT);
				} else {
					mouseChildren = false;
					mouseEnabled = false;
					skinDraw(SkinFlag.DISABLE);
				}
			}
			_enable = enable;
		}
		private function getXMin() : Number
		{
			var xMin : Number = _width - _content.width;
			return (xMin > 0) ? 0 : xMin;
		}
		private function getYMin() : Number
		{
			var yMin : Number = _height - _content.height;
			return (yMin > 0) ? 0 : yMin;
		}
	}
}
