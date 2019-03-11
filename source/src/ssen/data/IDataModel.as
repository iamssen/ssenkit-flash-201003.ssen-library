package ssen.data 
{
	import flash.events.IEventDispatcher;	
	/**
	 * 데이터 컴포넌트들의 기본 모델
	 * @author SSen
	 */
	public interface IDataModel extends IEventDispatcher
	{
		/** 컴포넌트의 데이터들을 xml 형태로 정리해서 리턴한다 */
		function get valueXML() : XML;
		/** 컴포넌트의 리소스들을 제거해준다 */
		function resourceKill() : void
		/** toString */
		function toString() : String
		/** clone */
		function clone() : IDataModel
	}
}
