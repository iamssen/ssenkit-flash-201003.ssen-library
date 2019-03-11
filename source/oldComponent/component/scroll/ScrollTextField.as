package ssen.component.scroll 
{
	import ssen.core.text.SSenTextField;

	import flash.display.DisplayObject;
	/**
	 * @author SSen
	 */
	public class ScrollTextField extends SSenTextField implements IScrollContainer
	{
		private var _enable : Boolean;

		
		public function ScrollTextField()
		{
			multiline = true;
			wordWrap = true;
		}
		/* *********************************************************************
		 * implement IScrollContainer
		 ********************************************************************* */
		public function refresh() : void
		{
		}
		public function resourceKill() : void
		{
		}
		public function get containerWidth() : Number
		{
			return width;
		}
		public function get containerHeight() : Number
		{
			return height;
		}
		public function get contentWidth() : Number
		{
			return textWidth;
		}
		public function get contentHeight() : Number
		{
			return textHeight;
		}
		public function get secX() : Number
		{
			return (scrollH > 0 && maxScrollH > 0) ? (scrollH - 1) / (maxScrollH - 1) : 0;
		}
		public function get secY() : Number
		{
			return (scrollV > 0 && maxScrollV > 0) ? (scrollV - 1) / (maxScrollV - 1) : 0;
		}
		public function get contentX() : Number
		{
			return 0;
		}
		public function get contentY() : Number
		{
			return 0;
		}
		public function get disableFilter() : Boolean
		{
			return false;
		}
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			_enable = enable;
		}
		public function set secX(sec : Number) : void
		{
			scrollH = sec * maxScrollH;
		}
		public function set secY(sec : Number) : void
		{
			scrollV = sec * maxScrollV;
		}
		public function set contentX(value : Number) : void
		{
		}
		public function set contentY(value : Number) : void
		{
		}
		public function set disableFilter(bool : Boolean) : void
		{
		}
		public function deleteContent() : void
		{
		}
		public function set content(content : DisplayObject) : void
		{
		}
		public function get content() : DisplayObject
		{
			return this;
		}
	}
}
