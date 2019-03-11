package ssen.core.display.expanse 
{
	import ssen.core.array.ArrayUtil;
	import ssen.core.display.expanse.SSenInteractiveObjectExpansion;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * ISSenDisplayObjectContainer 인터페이스 구현
	 * @private
	 * @author SSen
	 */
	public class SSenDisplayObjectContainerExpansion extends SSenInteractiveObjectExpansion 
	{
		/**
		 * 생성자
		 * @param object 구현시킬 대상
		 */
		public function SSenDisplayObjectContainerExpansion(object : DisplayObjectContainer)
		{
			super(object);
		}
		private function get object() : DisplayObjectContainer
		{
			return _object as DisplayObjectContainer;
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObjectContainer#addChildTo() */
		public function addChildTo(child : DisplayObject, dummy : DisplayObject, option : Array) : void
		{
			if (object.contains(dummy)) {
				if (option.length <= 0) option = ["x", "y", "index", "width", "height"];
				if (ArrayUtil.findElement("index", option)) {
					object.addChildAt(child, object.getChildIndex(dummy));
					option = ArrayUtil.delElement("index", option);
				} else {
					object.addChild(child);
				}
				var f : int;
				for (f = 0;f < option.length; f++) {
					child[option[f]] = dummy[option[f]];
				}
				object.removeChild(dummy);
			} else {
				throw new Error("SSenContainer#addChildTo : dummy 는 container 의 자식이 아닙니다.");
			}
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObjectContainer#addChildren() */
		public function addChildren(children : Array) : void
		{
			var child : DisplayObject;
			for (var f : int = 0;f < children.length; f++) {
				child = children[f];
				object.addChild(child);
			}
		}
		/** @copy ssen.core.display.expanse.ISSenDisplayObjectContainer#removeChildren() */
		public function removeChildren(children : Array) : void
		{
			var child : DisplayObject;
			for (var f : int = 0;f < children.length; f++) {
				child = children[f];
				object.removeChild(child);
			}
		}
	}
}
