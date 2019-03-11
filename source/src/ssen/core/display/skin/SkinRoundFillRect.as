package ssen.core.display.skin 
{
	import ssen.core.display.skin.SkinFillRect;

	import flash.display.GraphicsPath;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsFill;
	/**
	 * 둥근 모서리를 가지는 SkinFillRect
	 * @author SSen
	 */
	public class SkinRoundFillRect extends SkinFillRect 
	{
		private var _ellipseWidth : Number;
		private var _ellipseHeight : Number;

		
		/**
		 * 생성자
		 * @param interactiveObject 마우스, 키보드 이벤트를 활성화 시킬지 여부
		 * @param width 가로 사이즈
		 * @param height 세로 사이즈
		 * @param ellipseWidth 둥근 모서리 가로 사이즈
		 * @param ellipseHeight 둥근 모서리 세로 사이즈
		 * @param defaultFlag 최초 상태의 이름
		 * @param defaultAsset 최초 상태로 사용할 fill
		 * @param defaultStroke 최초 상태로 사용할 stroke
		 */
		public function SkinRoundFillRect(interactiveObject : Boolean = true, width : Number = 100, height : Number = 100, ellipseWidth : Number = 5, ellipseHeight : Number = 5, defaultFlag : String = null, defaultFill : IGraphicsFill = null, defaultLine : GraphicsStroke = null)
		{
			_ellipseWidth = ellipseWidth;
			_ellipseHeight = ellipseHeight;
			
			super(interactiveObject, width, height, defaultFlag, defaultFill, defaultLine);
		}
		/* *********************************************************************
		 * manage ellipse
		 ********************************************************************* */
		/** 둥근 모서리 가로 사이즈 */
		public function get ellipseWidth() : Number
		{
			return _ellipseWidth;
		}
		public function set ellipseWidth(ellipseWidth : Number) : void
		{
			if (_ellipseWidth != ellipseWidth) {
				_ellipseWidth = ellipseWidth;
				_status["width"] = true;
				skinDraw(_skinFlag);
				invalidate();
			}
		}
		/** 둥근 모서리 세로 사이즈 */
		public function get ellipseHeight() : Number
		{
			return _ellipseHeight;
		}
		public function set ellipseHeight(ellipseHeight : Number) : void
		{
			if (_ellipseHeight != ellipseHeight) {
				_ellipseHeight = ellipseHeight;
				_status["height"] = true;
				skinDraw(_skinFlag);
				invalidate();
			}
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		/** @private */
		override protected function setRectanglePath(width : Number, height : Number) : void
		{
			_width = width;
			_height = height;
			
			var path : GraphicsPath = new GraphicsPath();
			path.moveTo(_ellipseWidth, 0);
			path.lineTo(_width - _ellipseWidth, 0);
			path.curveTo(_width, 0, _width, _ellipseHeight);
			path.lineTo(_width, _height - _ellipseHeight);
			path.curveTo(_width, _height, _width - _ellipseWidth, _height);
			path.lineTo(_ellipseWidth, _height);
			path.curveTo(0, _height, 0, _height - _ellipseHeight);
			path.lineTo(0, _ellipseHeight);
			path.curveTo(0, 0, _ellipseWidth, 0);
			_graphicsData[2] = path;
		}
	}
}
