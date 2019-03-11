package ssen.frame {
	import ssen.core.display.expanse.SSenSprite;
	import ssen.forms.panel.IPanelObject;

	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Quadratic;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class SSenPanel extends SSenSprite {
		private var _panels : Vector.<IPanelObject>;
		private var _total : int = 0;
		private var _bg : Number = 0;

		public function open(panel : IPanelObject) : int {
			if (!_panels) _panels = new Vector.<IPanelObject>(10, true);
			if (_total == 0) {
				BetweenAS3.to(this, {bg:1}, 0.4, Quadratic.easeOut).play();
				SSenFrame.application.wait = true;
			}
			
			fall();
			
			var id : int = _panels.indexOf(panel);
			if (id < 0) {
				id = _panels.indexOf(null);
				_panels[id] = panel;
				_total++;
			}
			
			panel.id = id;
			panel.rise = true;
			panel.register(this);
			panel.addEventListener(Event.CLOSE, panelClose);
			setChildIndex(DisplayObject(panel), numChildren - 1);
			
			disableInteraction();
			
			return id;
		}

		protected function disableInteraction() : void {
		}

		private function panelClose(event : Event) : void {
			close(IPanelObject(event.target).id);
		}

		public function get bg() : Number {
			return _bg;
		}

		public function set bg(bg : Number) : void {
			_bg = bg;
		}

		public function close(id : int) : void {
			if (_panels[id]) {
				var panel : IPanelObject = _panels[id];
				panel.deregister();
				
				_panels[id] = null;
				_total--;
				
				if (_total > 0) {
					var i : int = numChildren;
					var obj : DisplayObject;
					while (--i >= 0) {
						obj = getChildAt(i);
						if (obj is IPanelObject && id != IPanelObject(obj).id) {
							IPanelObject(obj).rise = true;
							break;
						}
					}
				}
				
				if (_total == 0) {
					BetweenAS3.to(this, {bg:0}, 0.4, Quadratic.easeOut).play();
					SSenFrame.application.wait = false;
					enableInteraction();
					dispatchEvent(new Event(Event.CLOSE));
				}
			}
		}

		protected function enableInteraction() : void {
		}

		public function rise(id : int) : void {
			if (_panels[id]) {
				fall();
				setChildIndex(DisplayObject(_panels[id]), numChildren - 1);
				_panels[id].rise = true;
			}
		}

		private function fall() : void {
			if (_total > 0) {
				var i : int = numChildren;
				var obj : DisplayObject;
				while (--i >= 0) {
					obj = getChildAt(i);
					if (obj is IPanelObject) {
						IPanelObject(obj).rise = false;
						break;
					}
				}
			}
		}

		public function get total() : int {
			return _total;
		}
	}
}
