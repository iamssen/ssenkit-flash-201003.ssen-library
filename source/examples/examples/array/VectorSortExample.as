package examples.array 
{
	import examples.Example;
	
	import ssen.data.selectGroup.ISelectItem;
	import ssen.data.selectGroup.SelectItem;	
	/**
	 * @author SSen
	 */
	public class VectorSortExample extends Example 
	{
		public function VectorSortExample()
		{
			var vec : Vector.<ISelectItem> = new Vector.<ISelectItem>();
			vec.push(new SelectItem(1, "a1", "thumb1"), new SelectItem(2, "a2", "thumb2"), new SelectItem(4, "a4", "thumb1"), new SelectItem(3, "a3", "thumb1"));
			vec.sort(asc);
			tracer("순정렬", vec);
			vec.sort(desc);
			tracer("역순정렬", vec);
		}
		private function asc(a : ISelectItem, b : ISelectItem) : Number
		{
			return a.id - b.id;
		}
		private function desc(a : ISelectItem, b : ISelectItem) : Number
		{
			return b.id - a.id;
		}	
	}
}
