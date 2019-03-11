package ssen.component.scroll 
{
	import ssen.component.scroll.ScrollPaneBase;
	import ssen.core.display.CreateBoxes;
	import ssen.core.geom.Padding;
	
	import flash.display.DisplayObject;		
	/**
	 * @author SSen
	 */
	public class ScrollPane extends ScrollPaneBase 
	{
		public function ScrollPane(content : DisplayObject = null, scrollerH : IScroller = null, scrollerV : IScroller = null, 
									width : Number = 300, height : Number = 250, padding : Padding = null,
									secX : Number = 0, secY : Number = 0,
									isTrackHide : Boolean = false, trackMode : String = "point", background : Object = null)
		{
			// background setting
			if (background != null) {
				if (background is uint) {
					_background = CreateBoxes.createColorShapeBox(background as uint, width, height);
					addChildAt(_background, 0);
				} else if (background is DisplayObject) {
					_background = background as DisplayObject;
					addChildAt(_background, 0);
				}
			}
			// container setting
			_container = new ScrollContainer(content, width, height, true, secX, secY);
			addChildAt(_container, 1);
			// padding setting
			_padding = (padding != null) ? padding : new Padding(0, 0, 0, 0);
			
			_width = width;
			_height = height;
			if (scrollerH != null && scrollerV != null) {
				_directionMode = DirectionMode.VERTICAL_AND_HORIZONTAL;
				_scrollerH = scrollerH;
				_scrollerV = scrollerV;
				_scrollerH.init(_container, secX, isTrackHide, trackMode);
				_scrollerV.init(_container, secY, isTrackHide, trackMode);
				addChildren(scrollerH, scrollerV);
			} else if (scrollerV != null) {
				_directionMode = DirectionMode.VERTICAL;
				_scrollerV = scrollerV;
				_scrollerV.init(_container, secY, isTrackHide, trackMode);
				addChild(DisplayObject(scrollerV));
			} else if (scrollerH != null) {
				_directionMode = DirectionMode.HORIZONTAL;
				_scrollerH = scrollerH;
				_scrollerH.init(_container, secX, isTrackHide, trackMode);
				addChild(DisplayObject(scrollerH));
			} else {
				throw new Error("ssen.component.scroll.ScrollPane :: scrollerH 와 scrollerV 둘 중 하나는 존재해야 합니다.");
			}
			
			align();
		}
	}
}
