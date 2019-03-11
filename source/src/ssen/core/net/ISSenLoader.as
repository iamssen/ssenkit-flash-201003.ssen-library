package ssen.core.net 
{
	import ssen.component.progress.IProgressGraphic;

	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;
	/**
	 * @author ssen
	 */
	public interface ISSenLoader extends IEventDispatcher
	{
		/** 로딩 중 이벤트를 중지시킬 타겟을 등록 */
		function addStopingEventTarget(target : InteractiveObject) : void
		/** 로딩 중 progress 를 알려줄 progress graphic 을 등록 */
		function addProgressionNotifierTarget(target : IProgressGraphic) : void
		/** 리소스 제거 */
		function resourceKill() : void
	}
}
