package ssen.forms.buttons {
	import ssen.forms.buttons.events.ToggleEvent;
	import ssen.forms.buttons.events.ToggleMenuEvent;

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class ToggleMenu extends EventDispatcher {
		private var _dic : Dictionary;

		public function ToggleMenu() {
			_dic = new Dictionary();
		}

		public function addMenu(id : String, button : ISSenButton, toggleOn : Boolean = false) : void {
			button.toggle = true;
			button.toggleOn = toggleOn;
			button.addEventListener(ToggleEvent.TOGGLE, toggle);
			button.name = id;
			_dic[id] = button;
		}

		private function toggle(event : ToggleEvent) : void {
			var button : ISSenButton = ISSenButton(event.target);
			var btn : ISSenButton;
			for each (btn in _dic) {
				if (btn != button) btn.toggleOn = false;
			}
			dispatchEvent(new ToggleMenuEvent(ToggleMenuEvent.CHANGE, button.name, button));
		}
	}
}
