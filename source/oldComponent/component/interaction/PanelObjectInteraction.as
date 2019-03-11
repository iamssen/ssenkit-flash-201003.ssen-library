package ssen.component.interaction
{
	import ssen.component.events.PanelEvent;
	import ssen.component.panels.IPanelObject;
	
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;	
	/**
	 * @author SSen
	 */
	public class PanelObjectInteraction 
	{
		private var _object : IPanelObject;
		/* *********************************************************************
		 * storage
		 ********************************************************************* */
		private var _enable : Boolean;
		private var _moveStartX : int;
		private var _moveStartY : int;
		private var _moveStartMouseX : int;
		private var _moveStartMouseY : int;
		/* *********************************************************************
		 * object
		 ********************************************************************* */
		private var _moveObjects : Vector.<InteractiveObject>;
		private var _cancelBtns : Vector.<InteractiveObject>;
		private var _okBtns : Vector.<InteractiveObject>;

		public function PanelObjectInteraction(object : IPanelObject)
		{
			_enable = true;
			_object = object;
			_object.tabEnabled = false;
		}
		/* *********************************************************************
		 * implement IPanelObject
		 ********************************************************************* */
		/** @copy ssen.component.base.ISSenComponent#enable */
		public function get enable() : Boolean
		{
			return _enable;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable) {
				_object.mouseEnabled = true;
				_object.mouseChildren = true;
			} else {
				_object.mouseEnabled = false;
				_object.mouseChildren = false;
			}
			_enable = enable;
		}
		/** @copy ssen.component.panels.IPanelObject#topIndex() */
		public function topIndex() : void
		{
			//_object.index = _object.stage.numChildren - 1;
		}
		/** @copy ssen.component.panels.IPanelObject#resourceKill() */
		public function resourceKill() : void
		{
			if (_moveObjects != null) unsetMouseMove();
			if (_cancelBtns != null) unsetCancel();
			if (_okBtns != null) unsetOk();
			_moveObjects = null;
			_cancelBtns = null;
			_okBtns = null;
		}
		/* *********************************************************************
		 * set object
		 ********************************************************************* */
		/** panel move 를 걸 Object들을 입력한다 */
		public function setMoveObjects(objs : Array) : void
		{
			if (_moveObjects != null) unsetMouseMove();
			_moveObjects = new Vector.<InteractiveObject>();
			
			var obj : InteractiveObject;
			for each (obj in objs) {
				_moveObjects.push(obj);
			}
			
			setMouseMove();
		}
		/** cancel 을 걸 Object 들을 입력한다 */
		public function setCancelButtons(btns : Array) : void
		{
			if (_cancelBtns != null) unsetCancel();
			_cancelBtns = new Vector.<InteractiveObject>();
			
			var obj : InteractiveObject;
			for each (obj in btns) {
				_cancelBtns.push(obj);
			}
			
			setCancel();
		}
		/** ok 를 걸 Object 들을 입력한다 */
		public function setOkButtons(btns : Array) : void
		{
			if (_okBtns != null) unsetOk();
			_okBtns = new Vector.<InteractiveObject>();
			
			var obj : InteractiveObject;
			for each (obj in btns) {
				_okBtns.push(obj);
			}
			
			setOk();
		}
		/* *********************************************************************
		 * move event
		 ********************************************************************* */
		private function moveStart() : void
		{
			unsetMouseMove();
			
			_moveStartX = _object.x;
			_moveStartY = _object.y;
			_moveStartMouseX = _object.stage.mouseX;
			_moveStartMouseY = _object.stage.mouseY;
			
			_object.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0, true);
			_object.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0, true);
		}
		private function mouseMove(event : MouseEvent) : void
		{
			var ox : int = _moveStartX + (_object.stage.mouseX - _moveStartMouseX);
			var oy : int = _moveStartY + (_object.stage.mouseY - _moveStartMouseY);
			var xmode : int;
			var ymode : int;
			
			if (ox < 0) {
				ox = 0;
				xmode = 1;
			} else if (ox > _object.stage.stageWidth - _object.width) {
				ox = _object.stage.stageWidth - _object.width;
				xmode = 2;
			}
			if (oy < 0) {
				oy = 0;
				ymode = 1;
			} else if (oy > _object.stage.stageHeight - _object.height) {
				oy = _object.stage.stageHeight - _object.height;
				ymode = 2;
			}
			_object.x = ox;
			_object.y = oy;
			
			event.updateAfterEvent();
		}
		private function moveStop() : void
		{
			_object.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			_object.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			setMouseMove();
		}
		private function mouseUp(event : MouseEvent) : void
		{
			moveStop();
		}
		private function mouseDown(event : MouseEvent) : void
		{
			moveStart();
		}
		/* *********************************************************************
		 * add or remove event to object group
		 ********************************************************************* */
		private function setMouseMove() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _moveObjects.length; f++) {
				obj = _moveObjects[f];
				if (!obj.hasEventListener(MouseEvent.MOUSE_DOWN)) obj.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0, true);
			}
		}
		private function unsetMouseMove() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _moveObjects.length; f++) {
				obj = _moveObjects[f];
				if (obj.hasEventListener(MouseEvent.MOUSE_DOWN)) obj.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
		}
		private function setCancel() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _cancelBtns.length; f++) {
				obj = _cancelBtns[f];
				if (!obj.hasEventListener(MouseEvent.CLICK)) obj.addEventListener(MouseEvent.CLICK, cancelClick, false, 0, true);
			}
		}
		private function unsetCancel() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _cancelBtns.length; f++) {
				obj = _cancelBtns[f];
				if (obj.hasEventListener(MouseEvent.CLICK)) obj.removeEventListener(MouseEvent.CLICK, cancelClick);
			}
		}
		private function setOk() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _okBtns.length; f++) {
				obj = _okBtns[f];
				if (!obj.hasEventListener(MouseEvent.CLICK)) obj.addEventListener(MouseEvent.CLICK, okClick, false, 0, true);
			}
		}
		private function unsetOk() : void
		{
			var obj : InteractiveObject;
			var f : int;
			for (f = 0;f < _okBtns.length; f++) {
				obj = _okBtns[f];
				if (obj.hasEventListener(MouseEvent.CLICK)) obj.removeEventListener(MouseEvent.CLICK, okClick);
			}
		}
		/* *********************************************************************
		 * event dispatch
		 ********************************************************************* */
		private function cancelClick(event : MouseEvent) : void
		{
			_object.dispatchEvent(new PanelEvent(PanelEvent.PANEL_CANCEL));
		}
		private function okClick(event : MouseEvent) : void
		{
			_object.dispatchEvent(new PanelEvent(PanelEvent.PANEL_OK, _object.getValues()));
		}
	}
}
