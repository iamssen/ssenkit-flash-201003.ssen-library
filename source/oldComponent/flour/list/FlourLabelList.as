package ssen.flour.list 
{
	import ssen.component.list.AbstList;
	import ssen.component.list.AbstListItems;
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.IScrollPane;
	import ssen.data.selectGroup.ISelectGroup;
	import ssen.flour.scroll.FlourScrollPaneThin;
	
	import flash.filters.DropShadowFilter;		
	/**
	 * @author SSen
	 */
	public class FlourLabelList extends AbstList 
	{
		private var _itemHeight : int;

		public function FlourLabelList(width : int, height : int, itemHeight : int,  data : ISelectGroup = null)
		{
			_itemHeight = itemHeight;
			super(width, height, data);
			
			filters = [new DropShadowFilter(5, 45, 0, 0.1, 3, 3)];
		}
		override protected function createScrollPane(width : int, height : int) : IScrollPane
		{
			return new FlourScrollPaneThin(null, width, height, DirectionMode.VERTICAL);
		}
		override protected function createListItems(data : ISelectGroup = null) : AbstListItems
		{
			return new FlourLabelListItems(_width, _itemHeight, data);
		}
	}
}
