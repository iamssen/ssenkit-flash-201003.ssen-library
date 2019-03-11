package ssen.core.display.expanse 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;	
	/**
	 * ISSenDisplayObject 인터페이스 구현
	 * @private
	 * @author SSen
	 */
	public class SSenDisplayObjectExpansion 
	{
		/** 구현 대상 */
		protected var _object : DisplayObject;
		private var _hover : Boolean;
		private var _hoverPreX : Number;
		private var _hoverPreY : Number;
		private var _hoverIndex : int;
		private var _hoverContainer : DisplayObjectContainer;

		
		/**
		 * 생성자 
		 * @param object 구현시킬 대상
		 */
		public function SSenDisplayObjectExpansion(object : DisplayObject)
		{
			_object = object;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextX() */
		public function nextX(spaceX : int = 0) : Number
		{
			return _object.x + _object.width + spaceX;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextY() */
		public function nextY(spaceY : int = 0) : Number
		{
			return _object.y + _object.height + spaceY;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextPosition() */
		public function nextPosition(spaceX : int = 5) : Point
		{
			var point : Point = new Point();
			point.x = _object.x + _object.width + spaceX;
			point.y = _object.y;
			return point;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#nextPositionBr() */
		public function nextPositionBr(spaceY : int = 5) : Point
		{
			var point : Point = new Point();
			point.x = _object.x;
			point.y = _object.y + _object.height + spaceY;
			return point;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#hover */
		public function get hover() : Boolean
		{
			return _hover;
		}
		public function set hover(hover : Boolean) : void
		{
			if (hover) {
				if (_object.parent != _object.stage && !_hover) {
					_hoverPreX = _object.x;
					_hoverPreY = _object.y;
					_hoverContainer = _object.parent;
					_hoverIndex = index;
					
					_object.x = globalX;
					_object.y = globalY;
					_object.stage.addChild(_object);
				} 
			} else {
				if (_object.parent == _object.stage && _hover) {
					_object.x = _hoverPreX;
					_object.y = _hoverPreY;
					_hoverContainer.addChildAt(_object, _hoverIndex);
				}
			}
			_hover = hover;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#canvas */
		public function get canvas() : Sprite
		{
			return _object.stage.getChildByName("root1") as Sprite;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#globalPosition */
		public function get globalPosition() : Point
		{
			var point : Point = _object.parent.localToGlobal(new Point(_object.x, _object.y));
			return point;
		}
		public function set globalPosition(point : Point) : void
		{
			var p : Point = _object.parent.globalToLocal(point);
			_object.x = p.x;
			_object.y = p.y;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#globalX */
		public function get globalX() : Number
		{
			return globalPosition.x;
		}
		public function set globalX(value : Number) : void
		{
			var p : Point = _object.parent.globalToLocal(new Point(value, 0));
			_object.x = p.x;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#globalY */
		public function get globalY() : Number
		{
			return globalPosition.y;
		}
		public function set globalY(value : Number) : void
		{
			var p : Point = _object.parent.globalToLocal(new Point(0, value));
			_object.y = p.y;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#position */
		public function get position() : Point
		{
			var point : Point = new Point();
			point.x = _object.x;
			point.y = _object.y;
			return point;
		}
		public function set position(point : Point) : void
		{
			_object.x = point.x;
			_object.y = point.y;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#index */
		public function get index() : int
		{
			if (_object.parent != null) {
				return _object.parent.getChildIndex(_object);
			} else {
				return -10;
			}
		}
		public function set index(index : int) : void
		{
			if (_object.parent != null) {
				if (index > _object.parent.numChildren - 1) {
					index = _object.parent.numChildren - 1;
				} else if (index < 0) {
					index = 0;
				}
				_object.parent.setChildIndex(_object, index);
			}
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#moveXY */
		public function moveXY(x : Number, y : Number) : void
		{
			_object.x = x;
			_object.y = y;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObject#setSize */
		public function setSize(width : Number, height : Number) : void
		{
			_object.width = width;
			_object.height = height;
		}
	}
}
