package ssen.component.panels 
{
	import ssen.component.base.ISSenComponent;
	import ssen.core.array.Values;
	import ssen.core.display.base.ISprite;		
	/**
	 * PanelObject 의 Interface
	 * @author SSen
	 */
	public interface IPanelObject extends ISSenComponent, ISprite
	{
		/** 최상위 인덱스로 끌어올린다 */
		function topIndex() : void;
		/** 입력폼 형태의 Panel 의 입력된 데이터 */
		function getValues() : Values;
		/** panel move 를 걸 Object들을 입력한다 */
		function setMoveObjects(...objs) : void;
		/** cancel 을 걸 Object 들을 입력한다 */
		function setCancelButtons(...btns) : void;
		/** ok 를 걸 Object 들을 입력한다 */
		function setOkButtons(...btns) : void;
	}
}
