package ssen.core.display 
{
	import ssen.core.display.expanse.SSenShape;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.TriangleCulling;
	import flash.geom.Point;	
	/**
	 * 자유왜곡이 가능한 Shape
	 * @author SSen
	 */
	public class DistortShape extends SSenShape
	{
		private var _vertices : Vector.<Number>;
		private var _indices : Vector.<int>;
		private var _bitmapData : BitmapData;
		private var _uvData : Vector.<Number>;

		
		/**
		 * 생성자
		 * @param tl 좌상단 위치점
		 * @param tr 우상단 위치점
		 * @param dl 좌하단 위치점
		 * @param dr 우하단 위치점
		 * @param bitmapData 렌더링 시킬 비트맵 데이터
		 */
		public function DistortShape(tl : Point, tr : Point, dl : Point, dr : Point, bitmapData : BitmapData)
		{
			_vertices = new Vector.<Number>(8, true);
			_vertices[0] = tl.x;
			_vertices[1] = tl.y;
			_vertices[2] = tr.x;
			_vertices[3] = tr.y;
			_vertices[4] = dl.x;
			_vertices[5] = dl.y;
			_vertices[6] = dr.x;
			_vertices[7] = dr.y;
			
			_indices = new Vector.<int>(6, true);
			_indices[0] = 0;
			_indices[1] = 1;
			_indices[2] = 2;
			_indices[3] = 1;
			_indices[4] = 3;
			_indices[5] = 2;
			
			_uvData = new Vector.<Number>(8, true);
			_uvData[0] = 0;
			_uvData[1] = 0;
			_uvData[2] = 1;
			_uvData[3] = 0;
			_uvData[4] = 0;
			_uvData[5] = 1;
			_uvData[6] = 1;
			_uvData[7] = 1;
			
			_bitmapData = bitmapData;
			draw();
		}
		/** 좌상단 위치점을 바꾼다 */
		public function topLeft(x : Number, y : Number) : void
		{
			_vertices[0] = x;
			_vertices[1] = y;
			draw();
		}
		/** 우상단 위치점을 바꾼다 */
		public function topRight(x : Number, y : Number) : void
		{
			_vertices[2] = x;
			_vertices[3] = y;
			draw();
		}
		/** 좌하단 위치점을 바꾼다 */
		public function downLeft(x : Number, y : Number) : void
		{
			_vertices[4] = x;
			_vertices[5] = y;
			draw();
		}
		/** 우하단 위치점을 바꾼다 */
		public function downRight(x : Number, y : Number) : void
		{
			_vertices[6] = x;
			_vertices[7] = y;
			draw();
		}
		/** triangles vertices 형태의 위치점 데이터 */
		public function get vertices() : Vector.<Number>
		{
			return _vertices;
		}
		public function set vertices(vector : Vector.<Number>) : void
		{
			_vertices = vector;
			draw();
		}
		/** 비트맵 데이터 */
		public function get bitmapData() : BitmapData
		{
			return _bitmapData;
		}
		public function set bitmapData(bitmapData : BitmapData) : void
		{
			_bitmapData = bitmapData;
			draw();
		}
		/* *********************************************************************
		 * utils
		 ********************************************************************* */
		private function draw() : void
		{
			var g : Graphics = graphics;
			g.clear();
			g.beginBitmapFill(_bitmapData, null, false, true);
			g.drawTriangles(_vertices, _indices, _uvData, TriangleCulling.NONE);
			g.endFill();
		}
	}
}
