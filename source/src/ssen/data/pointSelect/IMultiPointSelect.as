package ssen.data.pointSelect 
{
	import flash.utils.Dictionary;		
	/**
	 * @author SSen
	 */
	public interface IMultiPointSelect 
	{
		function get pointLength() : int
		function get pointNames() : Vector.<String>
		function setPoint(pointName : String, value : Number) : void
		function unsetPoint(pointName : String) : void
		function getPointValue(pointName : String) : Number
		function getAllValues() : Dictionary
		function get maxValue() : Number
		function set maxValue(maxValue : Number) : void
		function get minValue() : Number
		function set minValue(minValue : Number) : void
	}
}
