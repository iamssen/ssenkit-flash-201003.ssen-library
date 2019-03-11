package ssen.forms.buttons 
{
	import ssen.core.display.expanse.SSenMovieClip;
	import ssen.core.display.skin.InvalidateStatus;
	import ssen.core.display.skin.SkinFlag;
	import ssen.forms.base.ISSenFormData;

	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class MovieClipButton extends SSenMovieClip implements ISSenButton
	{
		private var _interaction : ButtonInteraction;
		private var _status : InvalidateStatus;
		private var _initialized : Boolean;
		public function MovieClipButton()
		{
			stop();
		}
		public function get initialized() : Boolean
		{
			return _initialized;
		}
		public function initialize() : void
		{
			_status = new InvalidateStatus();
			
			_interaction = new ButtonInteraction();
			_interaction.initialize(this);
			
			_initialized = true;
		}
		public function setting(toggle : Boolean = false, toggleOn : Boolean = false) : void
		{
			_interaction.setting(toggle, toggleOn);
			_interaction.start();
			
			buttonSkinDraw();
		}
		/* *********************************************************************
		 * implement ISSenButton
		 ********************************************************************* */
		public function kill() : void
		{
			_interaction.stop();
		}
		public function deconstruction() : void
		{
			kill();
			_interaction.deconstruction();
			_interaction = null;
		}
		public function get data() : ISSenFormData
		{
			return null;
		}
		public function set data(data : ISSenFormData) : void
		{
		}
		public function get toggleOn() : Boolean
		{
			return _interaction.toggleOn;
		}
		public function set toggleOn(toggleOn : Boolean) : void
		{
			_interaction.toggleOn = toggleOn;
		}
		public function get toggle() : Boolean
		{
			return _interaction.toggle;
		}
		public function set toggle(toggle : Boolean) : void
		{
			_interaction.toggle = toggle;
		}
		public function get isMousePress() : Boolean
		{
			return _interaction.isMousePress;
		}
		override public function get enabled() : Boolean
		{
			return _interaction.enabled;
		}
		override public function set enabled(enabled : Boolean) : void
		{
			if (enabled) {
				_interaction.start();
			} else {
				_interaction.stop();
			}
		}
		/* *********************************************************************
		 * skinning
		 ********************************************************************* */
		public function buttonSkinDraw() : void
		{
			_status["draw"] = true;
			invalidate();
		}
		/* *********************************************************************
		 * display invalidating
		 ********************************************************************* */
		private function invalidate() : void
		{
			if (stage != null) {
				stage.addEventListener(Event.RENDER, render, false, 0, true);
				stage.addEventListener(Event.ENTER_FRAME, render, false, 0, true);
				stage.invalidate();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
			}
		}
		private function addedToStage(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			invalidate();
		}
		private function render(event : Event) : void
		{
			if (stage != null) {
				stage.removeEventListener(Event.RENDER, render);
				stage.removeEventListener(Event.ENTER_FRAME, render);
			}
			if (_status.invalidate) rendering();
		}
		private function rendering() : void
		{
			var frame : int;
			
			switch (_interaction.skinFlag) {
				case SkinFlag.DEFAULT : 
					frame = 1; 
					break;
				case SkinFlag.OVER : 
					frame = 2; 
					break;
				case SkinFlag.ACTION : 
					frame = 3; 
					break;
				case SkinFlag.SELECTED : 
					frame = 4; 
					break;
				case SkinFlag.DISABLE : 
					frame = 5; 
					break;
			}
			
			gotoAndStop(frame);
			
			_status.clear();
		}
		public function get formWidth() : Number
		{
			return width;
		}
		public function get formHeight() : Number
		{
			return height;
		}
		public function set formWidth(width : Number) : void
		{
			this.width = width;
		}
		public function set formHeight(height : Number) : void
		{
			this.height = height;
		}
		public function setFormSize(width : Number, height : Number) : void
		{
			formWidth = width;
			formHeight = height;
		}
	}
}
