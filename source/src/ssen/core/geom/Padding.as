package ssen.core.geom 
{
	import ssen.core.utils.FormatToString;

	import flash.geom.Point;
	/**
	 * 공간속의 여백을 조절한다
	 * @author SSen
	 */
	public class Padding
	{
		private var _top : Number;
		private var _right : Number;
		private var _bottom : Number;
		private var _left : Number;
		/** 생성자 */
		public function Padding(top : Number = 0, right : Number = 0, bottom : Number = 0, left : Number = 0)
		{
			_top = top;
			_right = right;
			_bottom = bottom;
			_left = left;
		}
		/** clone */
		public function clone() : Padding
		{
			return new Padding(_top, _right, _bottom, _left);
		}
		/** top */
		public function get top() : Number
		{
			return _top;
		}
		public function set top(top : Number) : void
		{
			_top = top;
		}
		/** right */
		public function get right() : Number
		{
			return _right;
		}
		public function set right(right : Number) : void
		{
			_right = right;
		}
		/** bottom */
		public function get bottom() : Number
		{
			return _bottom;
		}
		public function set bottom(bottom : Number) : void
		{
			_bottom = bottom;
		}
		/** left */
		public function get left() : Number
		{
			return _left;
		}
		public function set left(left : Number) : void
		{
			_left = left;
		}
		/** padding 요소들을 한꺼번에 수정한다 */
		public function setPadding(top : Number, right : Number, bottom : Number, left : Number) : void
		{
			_top = top;
			_right = right;
			_bottom = bottom;
			_left = left;
		}
		/** 
		 * Object 가 위치해야 할 x, y 좌표 point 를 계산한다
		 * @param position 썸네일의 위치
		 * @param containerWidth 썸네일이 위치할 박스의 가로 크기
		 * @param containerHeight 썸네일이 위치할 박스의 세로 크기
		 * @param objectWidth 썸네일의 가로 크기
		 * @param objectHeight 썸네일의 세로 크기
		 */ 
		public function getPosition(position : String, containerWidth : Number, containerHeight : Number, objectWidth : Number, objectHeight : Number) : Point
		{
			var x : int;
			var y : int;
			
			switch (position) {
				case Position9.TL :
				case Position9.ML :
				case Position9.BL :
					x = left;
					break;
				case Position9.TC :
				case Position9.MC :
				case Position9.BC :
					x = (containerWidth >> 1) - (objectWidth >> 1);
					break;
				case Position9.TR :
				case Position9.MR :
				case Position9.BR :
					x = containerWidth - right - objectWidth;
					break;
			}
			switch (position) {
				case Position9.TL :
				case Position9.TC :
				case Position9.TR :
					y = top;
					break;
				case Position9.ML :
				case Position9.MC :
				case Position9.MR :
					y = (containerHeight >> 1) - (objectHeight >> 1);
					break;
				case Position9.BL :
				case Position9.BC :
				case Position9.BR :
					y = containerHeight - bottom - objectHeight;
					break;
			}
			
			return new Point(x, y);
		}
		/** toString */
		public function toString() : String
		{
			return FormatToString.toString(this, "top", "right", "bottom", "left");
		}
	}
}
