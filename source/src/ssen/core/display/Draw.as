package ssen.core.display 
{
	import flash.display.Graphics;
	import flash.display.GraphicsEndFill;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Draw 
	{
		public static function drawScaleBitmap() : void
		{
		}
		public static function vertexDraw(graphics : Graphics, fill : IGraphicsFill, stroke : IGraphicsStroke, ...vertex : Array) : void
		{
			var vertexLength : int = vertex.length;
			var path : GraphicsPath = new GraphicsPath();
			path.moveTo(vertex[vertexLength - 2], vertex[vertexLength - 1]);
			var f : int;
			for (f = 0;f < vertexLength;f = f + 2) {
				path.lineTo(vertex[f], vertex[f + 1]);
			}
			var data : Vector.<IGraphicsData> = new Vector.<IGraphicsData>(4);
			data[0] = IGraphicsData(fill);
			data[1] = IGraphicsData(stroke);
			data[2] = path;
			data[3] = new GraphicsEndFill();
			graphics.drawGraphicsData(data);
		}
		public static function donutDraw(graphics : Graphics, fill : IGraphicsFill, stroke : IGraphicsStroke, x : Number, y : Number, radius : Number, innerRadius : Number, startDeg : Number, endDeg : Number) : void
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
	
			var data : Vector.<IGraphicsData> = new Vector.<IGraphicsData>(4);
			data[0] = IGraphicsData(fill);
			data[1] = IGraphicsData(stroke);
			data[2] = new GraphicsPath(outCmd, outData);
			data[3] = new GraphicsEndFill();
			graphics.drawGraphicsData(data);
		}
	}
}
