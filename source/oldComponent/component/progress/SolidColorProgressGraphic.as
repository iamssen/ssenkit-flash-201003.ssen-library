package ssen.component.progress
{
	import ssen.core.display.expanse.SSenShape;
	import ssen.core.number.NumberUtil;

	import flash.display.Graphics;	
	/**
	 * 단색으로 구성되는 간단한 progress 그래픽 모듈
	 * @author SSen
	 */
	public class SolidColorProgressGraphic extends SSenShape implements IProgressGraphic
	{
		private var _progress : Number;
		private var _width : Number;
		private var _height : Number;
		private var _bgColor : uint;
		private var _barColor : uint;

		
		public function SolidColorProgressGraphic(bgColor : uint, barColor : uint, width : Number, height : Number)
		{
			_progress = 0;
			_width = width;
			_height = height;
			_bgColor = bgColor;
			_barColor = barColor;
			
			progressDraw(bgColor, 1);
		}
		/** 0 ~ 1 로 제한되는 진행상태 */
		public function get progress() : Number
		{
			return _progress;
		}
		public function set progress(value : Number) : void
		{
			value = NumberUtil.restriction(value, 0, 1);
			_progress = value;
			progressDraw(_barColor, value);
		}
		/** 바탕색 */
		public function get bgColor() : uint
		{
			return _bgColor;
		}
		public function set bgColor(bgColor : uint) : void
		{
			_bgColor = bgColor;
			reset();
		}
		/** progress 진행막대의 색 */
		public function get barColor() : uint
		{
			return _barColor;
		}
		public function set barColor(barColor : uint) : void
		{
			_barColor = barColor;
			reset();
		}
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			reset();
		}
		/** @private */
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			reset();
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function reset() : void
		{
			graphics.clear();
			progressDraw(_bgColor, 1);
			progressDraw(_barColor, _progress);
		}
		private function progressDraw(color : uint, progress : Number) : void
		{
			var g : Graphics = graphics;
			g.beginFill(color);
			g.drawRect(0, 0, _width * progress, _height);
			g.endFill();
		}
		public function resourceKill() : void
		{
		}
	}
}
