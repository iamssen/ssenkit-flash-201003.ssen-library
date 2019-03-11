package ssen.core.display.graphics 
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsTrianglePath;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class PathMaker 
	{
		private static const RECT_COMMAND : Vector.<int> = Vector.<int>([1,2,2,2,2]);
		public static function rect(path : GraphicsPath, x : Number, y : Number, width : Number, height : Number) : void 
		{
			path.commands = RECT_COMMAND;
			if (!path.data) path.data = new Vector.<Number>(10, true);
			path.data[0] = x;
			path.data[1] = y;
			path.data[2] = x + width;
			path.data[3] = y;
			path.data[4] = x + width;
			path.data[5] = y + height;
			path.data[6] = x;
			path.data[7] = y + height;
			path.data[8] = x;
			path.data[9] = y;
		}
		private static const ROUND_RECT_COMMAND : Vector.<int> = Vector.<int>([1,2,3,2,3,2,3,2,3]);
		public static function roundRect(path : GraphicsPath, x : Number, y : Number, width : Number, height : Number, ellipseWidth : Number, ellipseHeight : Number) : void
		{
			path.commands = ROUND_RECT_COMMAND;
			if (!path.data) path.data = new Vector.<Number>(26, true);
			var x0 : Number = x;
			var x1 : Number = x + ellipseWidth;
			var x2 : Number = x + width - ellipseWidth;
			var x3 : Number = x + width;
			var y0 : Number = y;
			var y1 : Number = y + ellipseHeight;
			var y2 : Number = y + height - ellipseHeight;
			var y3 : Number = y + height;
			path.data[0] = x1;
			path.data[1] = y0;
			path.data[2] = x2;
			path.data[3] = y0;
			path.data[4] = x3;
			path.data[5] = y0;
			path.data[6] = x3;
			path.data[7] = y1;
			path.data[8] = x3;
			path.data[9] = y2;
			path.data[10] = x3;
			path.data[11] = y3;
			path.data[12] = x2;
			path.data[13] = y3;
			path.data[14] = x1;
			path.data[15] = y3;
			path.data[16] = x0;
			path.data[17] = y3;
			path.data[18] = x0;
			path.data[19] = y2;
			path.data[20] = x0;
			path.data[21] = y1;
			path.data[22] = x0;
			path.data[23] = y0;
			path.data[24] = x1;
			path.data[25] = y0;
		}
		private static const DISTORT_INDICES : Vector.<int> = Vector.<int>([0, 1, 2, 1, 3, 2]);
		private static const DISTORT_UVT_DATA : Vector.<Number> = Vector.<Number>([0, 0, 1, 0, 0, 1, 1, 1]);
		public static function distort(path : GraphicsTrianglePath, tlX : Number, tlY : Number, trX : Number, trY : Number, dlX : Number, dlY : Number, drX : Number, drY : Number) : void
		{
			var v : Vector.<Number> = path.vertices ? path.vertices : new Vector.<Number>(8, true);
			v[0] = tlX;
			v[1] = tlY;
			v[2] = trX;
			v[3] = trY;
			v[4] = dlX;
			v[5] = dlY;
			v[6] = drX;
			v[7] = drY;
			path.vertices = v;
			path.indices = DISTORT_INDICES;
			path.uvtData = DISTORT_UVT_DATA;
		}
		public static function donut(path : GraphicsPath, x : Number, y : Number, radius : Number, innerRadius : Number, startDeg : Number, endDeg : Number) : void
		{
			// (degree) start 와 end 를 계산해서 그릴 각도를 구한다.
			var arc : Number = endDeg > startDeg ? endDeg - startDeg : 360 - startDeg + endDeg;
			// segs 각도를 45 로 나누어서 등분을 결정한다.
			var s : int = Math.ceil(arc / 45);
			// theta : radian 등분의 갯수 단위로 radian 이 얼마만큼 증가할지 구한다.
			var th : Number = ((arc / s) / 180) * Math.PI;			
			// angle : radian 시작 radian 을 계산한다.
			var a : Number = (startDeg / 180) * Math.PI;
			// GraphicsPath 의 command, data
			var outCmd : Vector.<int> = new Vector.<int>();
			var outData : Vector.<Number> = new Vector.<Number>();
			var inCmd : Vector.<int> = new Vector.<int>();
			var inData : Vector.<Number> = new Vector.<Number>();
			// 외부 최초점을 moveTo 로 옮겨준다.
			outCmd.push(1);
			outData.push(x + radius * Math.cos(a), y + radius * Math.sin(a));
			inCmd.push(3);
			inData.push(x + innerRadius * Math.cos(a), y + innerRadius * Math.sin(a));
			// controlAngle : radian 컨트롤 점의 radian angle
			var ca : Number;
	
			// draw
			while (--s >= 0) {
				a += th;
				ca = a - (th / 2);
				outCmd.push(3);
				outData.push(x + (radius / Math.cos(th / 2)) * Math.cos(ca), y + (radius / Math.cos(th / 2)) * Math.sin(ca), x + radius * Math.cos(a), y + radius * Math.sin(a));
				inCmd.unshift(3);
				inData.unshift(x + innerRadius * Math.cos(a), y + innerRadius * Math.sin(a), x + (innerRadius / Math.cos(th / 2)) * Math.cos(ca), y + (innerRadius / Math.cos(th / 2)) * Math.sin(ca));
			}
			// 내부 최초점을 lineTo 로 바꿔준다.
			inCmd[0] = 2;
			// 내부 마지막점과 외부 최초점을 연결하는 lineTo 를 설정해준다.
			inCmd.push(2);
			inData.push(outData[0], outData[1]);
			// 외부 데이터 + 내부 데이터 
			outCmd = outCmd.concat(inCmd);
			outData = outData.concat(inData);
				
			path.commands = outCmd;
			path.data = outData;
		}
		private static const LINE_COMMAND : Vector.<int> = Vector.<int>([1,2]);
		public static function line(path : GraphicsPath, x0 : Number, y0 : Number, x1 : Number, y1 : Number) : void 
		{
			path.commands = LINE_COMMAND;
			if (!path.data) path.data = new Vector.<Number>(4, true);
			path.data[0] = x0;
			path.data[1] = y0;
			path.data[2] = x1;
			path.data[3] = y1;
		}
	}
}
