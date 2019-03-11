package ssen.forms.scroll 
{
	import flash.events.Event;

	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.text.SSenTextField;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ScrollTest extends SSenSprite 
	{
		private var _txt : SSenTextField;
		private var _scrollV : ScrollBar;
		private var _scrollH : ScrollBar;
		public function ScrollTest()
		{
			var text : String = "YYYYY\n";
			var f : int = 50;
			while (--f >= 0) {
				text += "abcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuabcdefghijklmnopqrstuXXX\n";
			}
			text += "XXXXXX";
			
			_txt = new SSenTextField();
			_txt.multiline = true;
			_txt.border = true;
			_txt.text = text;
			_txt.setSize(200, 300);
			_txt.addEventListener(Event.SCROLL, container);
			
			_scrollV = new ScrollBar();
			_scrollV.initialize();
			_scrollV.setting(ScrollDirection.VERTICAL, 10, 300);
			_scrollV.position = _txt.nextPosition(0);
			_scrollV.scrollPosition = _txt.scrollV - 1;
			_scrollV.maxScrollPosition = _txt.maxScrollV - 1;
			_scrollV.minScrollPosition = 0;
			_scrollV.pageSize = _txt.numLines - 1;
			_scrollV.addEventListener(Event.SCROLL, scroll);
			
			_scrollH = new ScrollBar();
			_scrollH.initialize();
			_scrollH.setting(ScrollDirection.HORIZONTAL, 200, 10);
			_scrollH.position = _txt.nextPositionBr(0);
			_scrollH.scrollPosition = _txt.scrollH;
			_scrollH.maxScrollPosition = _txt.maxScrollH;
			_scrollH.minScrollPosition = 0;
			_scrollH.pageSize = _txt.maxScrollH + _txt.width;
			_scrollH.addEventListener(Event.SCROLL, scroll);
			
			trace(_scrollV.scrollPosition, _scrollV.minScrollPosition, _scrollV.maxScrollPosition, _scrollV.pageSize, _scrollV.scrollSightRatio);
			trace(_scrollH.scrollPosition, _scrollH.minScrollPosition, _scrollH.maxScrollPosition, _scrollH.pageSize, _scrollH.scrollSightRatio);
			
			addChildren(_txt, _scrollV, _scrollH);
		}
		private function container(event : Event) : void 
		{
			_scrollH.scrollPosition = _txt.scrollH;
		}
		private function scroll(event : Event) : void  
		{
			trace(_scrollH.scrollPosition, _scrollH.maxScrollPosition, _scrollH.pageSize, _scrollV.scrollPosition + 1, _scrollV.maxScrollPosition + 1, _scrollV.pageSize + 1);
			_txt.scrollV = _scrollV.scrollPosition + 1;
			_txt.scrollH = _scrollH.scrollPosition;
			//trace(_scrollV.maxScrollPosition, _scrollV.scrollPosition + 1);
		}
	}
}
