package test.geom 
{
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.number.MathEx;

	import de.polygonal.core.ObjectPool;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.system.System;
	import flash.utils.getTimer;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class PoolingTest extends SSenSprite 
	{
		private var _max : int;
		private var _total : int;
		public function PoolingTest()
		{
			_max = 100000;
			_total = 10;
			var time : int = getTimer();
			//pool1();
			//pool2();
			nopool();
			//padding0();
			//padding1();
			trace(getTimer() - time, System.totalMemory);
			/*
			 * test 항목
			 * 생성 속도 테스트
			 * 메모리 총 사용량
			 * 사이즈가 꽉 찾을때 동작여부
			 */
		}
		private function nopool() : void 
		{
			// 1900 77680640
			var object : Sprite;
			var i : int = _max;
			while (--i >= 0) {
				object = new Sprite();
				displayObject(object);
				object = null;
			}
		}
		private function pool1() : void 
		{
			// 802 3936256
			var pool : ObjectPool = new ObjectPool();
			pool.allocate(_total, Sprite);
			var i : int = _max;
			var object : Sprite;
			while (--i >= 0) {
				object = Sprite(pool.object);
				displayObject(object);
				pool.object = object;
			}
			trace(pool.size, pool.usageCount, pool.wasteCount);
		}
		private function displayObject(object : Sprite) : void 
		{
			var g : Graphics = object.graphics;
			g.clear();
			g.beginFill(MathEx.rand(0xffffff, 0x000000));
			g.drawCircle(MathEx.rand(0, stage.stageWidth), MathEx.rand(0, stage.stageHeight), MathEx.rand(10, 30));
			g.endFill();
		}
	}
}
