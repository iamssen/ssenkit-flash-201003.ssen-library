package test.displayLoaders 
{
	import gs.TweenMax;
	import gs.easing.Quad;

	import ssen.component.displayLoaders.AbstDisplayLoader;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.debug.TestButtonGroup;

	import flash.net.URLRequest;
	/**
	 * @author ssen
	 */
	public class DisplayLoaderTest extends SSenSprite 
	{
		private var loader : AbstDisplayLoader;

		
		public function DisplayLoaderTest()
		{
			loader = new AbstDisplayLoader(100, 100, false, true, true, 0xaaaaaa);
			loader.moveXY(10, 10);
			loader.mouseChildren = false;
			loader.mouseEnabled = false;
			
			var tg : TestButtonGroup = new TestButtonGroup("add", add, "remove", remove, "load1", load1, "load2", load2, "load3", load3);
			tg.addTest("big", big, "small", small);
			tg.position = loader.nextPositionBr(200);
			
			addChildren(tg);
		}
		private function big() : void
		{
			TweenMax.killTweensOf(loader);
			TweenMax.to(loader, .4, {width:300, height:300, ease:Quad.easeOut});
		}
		private function small() : void
		{
			TweenMax.killTweensOf(loader);
			TweenMax.to(loader, .4, {width:100, height:100, ease:Quad.easeOut});
		}
		private function remove() : void
		{
			removeChildren(loader);
		}
		private function add() : void
		{
			addChildren(loader);
		}
		private function load1() : void
		{
			loader.load(new URLRequest("http://ssen.name/portfolio/contents/0711card.jpg"));
		}
		private function load2() : void
		{
			loader.load(new URLRequest("http://ssen.name/portfolio/contents/unipicture9.jpg"));
		}
		private function load3() : void
		{
			loader.load(new URLRequest("http://ssen.name/portfolio/contents/unipicture9.jpgx"));
		}
	}
}
