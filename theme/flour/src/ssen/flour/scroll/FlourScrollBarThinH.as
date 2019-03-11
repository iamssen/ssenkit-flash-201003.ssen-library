package ssen.flour.scroll 
{
	import ssen.component.buttons.IButton;
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.IScrollContainer;
	import ssen.component.scroll.IScroller;
	import ssen.component.scroll.ScrollBarBase;
	import ssen.component.scroll.ScrollBarButtonGroup;
	import ssen.component.scroll.ScrollBarButtonType;
	import ssen.flour.buttons.FlourScrollThineButton;		
	/**
	 * @author SSen
	 */
	public class FlourScrollBarThinH extends ScrollBarBase 
	{
		private var _buttonGroupUpPosition : ScrollBarButtonGroup;
		private var _buttonGroupDownPosition : ScrollBarButtonGroup;
		private var _track : IScroller;

		public function FlourScrollBarThinH(width : Number,
											container : IScrollContainer = null,
											buttonsUpPosition : Array = null,
											buttonsDownPosition : Array = null,
											sec : Number = 0,
											isTrackHide : Boolean = false,
											trackMode : String = "point",
											minValue : Number = 0,
											maxValue : Number = 0)
		{
			if (buttonsUpPosition == null) buttonsUpPosition = [ScrollBarButtonType.UP];
			if (buttonsDownPosition == null) buttonsDownPosition = [ScrollBarButtonType.DOWN];
			
			var f : int;
			var directionMode : String = DirectionMode.HORIZONTAL;
			
			var up : IButton;
			var down : IButton;
			var pageUp : IButton;
			var pageDown : IButton;
			
			for (f = 0;f < buttonsUpPosition.length; f++) {
				switch (buttonsUpPosition[f]) {
					case ScrollBarButtonType.UP :
						up = new FlourScrollThineButton(directionMode, ScrollBarButtonType.UP);
						break;
					case ScrollBarButtonType.DOWN :
						down = new FlourScrollThineButton(directionMode, ScrollBarButtonType.DOWN);
						break;
					case ScrollBarButtonType.PAGE_UP :
						pageUp = new FlourScrollThineButton(directionMode, ScrollBarButtonType.PAGE_UP);
						break;
					case ScrollBarButtonType.PAGE_DOWN :
						pageDown = new FlourScrollThineButton(directionMode, ScrollBarButtonType.PAGE_DOWN);
						break;
				}
			}
			_buttonGroupUpPosition = new ScrollBarButtonGroup(up, down, pageUp, pageDown);
			_buttonGroupUpPosition.align(directionMode, buttonsUpPosition);
			
			up = null;
			down = null;
			pageUp = null;
			pageDown = null;
			for (f = 0;f < buttonsDownPosition.length; f++) {
				switch (buttonsDownPosition[f]) {
					case ScrollBarButtonType.UP :
						up = new FlourScrollThineButton(directionMode, ScrollBarButtonType.UP);
						break;
					case ScrollBarButtonType.DOWN :
						down = new FlourScrollThineButton(directionMode, ScrollBarButtonType.DOWN);
						break;
					case ScrollBarButtonType.PAGE_UP :
						pageUp = new FlourScrollThineButton(directionMode, ScrollBarButtonType.PAGE_UP);
						break;
					case ScrollBarButtonType.PAGE_DOWN :
						pageDown = new FlourScrollThineButton(directionMode, ScrollBarButtonType.PAGE_DOWN);
						break;
				}
			}
			_buttonGroupDownPosition = new ScrollBarButtonGroup(up, down, pageUp, pageDown);
			_buttonGroupDownPosition.align(directionMode, buttonsDownPosition);
			
			_track = new FlourScrollTrackThineH(width - _buttonGroupUpPosition.width - _buttonGroupDownPosition.width);
			
			addChildren(_buttonGroupUpPosition, _buttonGroupDownPosition, _track);
			setting(_track, _buttonGroupUpPosition, _buttonGroupDownPosition, directionMode, width, 10);
			if (container != null) init(container, sec, isTrackHide, trackMode, minValue, maxValue);
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_buttonGroupUpPosition.resourceKill();
			_buttonGroupDownPosition.resourceKill();
			_track.resourceKill();
			_buttonGroupUpPosition = null;
			_buttonGroupDownPosition = null;
			_track = null;
		}
	}
}
