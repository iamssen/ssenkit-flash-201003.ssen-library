package ssen.data.pointSelect 
{
	import ssen.data.IDataModel;		
	/**
	 * @author SSen
	 */
	public interface ISinglePointSelect extends IDataModel 
	{
		function get value() : Number
		function set value(value : Number) : void
		function get maxValue() : Number
		function set maxValue(maxValue : Number) : void
		function get minValue() : Number
		function set minValue(minValue : Number) : void
	}
}
