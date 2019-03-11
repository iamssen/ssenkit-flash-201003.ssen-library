package ssen.component.base
{
	/**
	 * Input component 의 interface
	 * @author SSen
	 */
	public interface IInput
	{
		/** input 의 값 */
		function get value() : Object;
		function set value(value : Object) : void;
		/** input 의 값 타입 */
		function get valueType() : Class;
	}
}
