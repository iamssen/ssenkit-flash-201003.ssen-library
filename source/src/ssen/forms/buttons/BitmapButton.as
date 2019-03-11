package ssen.forms.buttons 
{
	import ssen.core.display.graphics.Image;
	import ssen.core.display.skin.InvalidateStatus;
	import ssen.core.display.skin.SkinFlag;
	import ssen.forms.base.FormSprite;
	import ssen.forms.base.ISSenFormData;

	import flash.display.BitmapData;
	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class BitmapButton extends FormSprite implements ISSenButton 
	{

		[Embed(source="asset/defaultSkin/default.png")]
		private static var _defaultImage : Class;
		private static var _defaultBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/over.png")]
		private static var _overImage : Class;
		private static var _overBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/action.png")]
		private static var _downImage : Class;
		private static var _downBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/selected.png")]
		private static var _selectedImage : Class;
		private static var _selectedBitmap : BitmapData;

		[Embed(source="asset/defaultSkin/disable.png")]
		private static var _disableImage : Class;
		private static var _disableBitmap : BitmapData;
		private var _default : BitmapData;
		private var _over : BitmapData;
		private var _down : BitmapData;
		private var _selected : BitmapData;
		private var _disable : BitmapData;
		private var _interaction : ButtonInteraction;
		private var _status : InvalidateStatus;
		private var _image : Image;
		public function initialize() : void
		{
			_default = getDefaultImage();
			_over = getOverImage();
			_down = getDownImage();
			_selected = getSelectedImage();
			_disable = getDisableImage();
			_image = new Image(0, 0, _default.width, _default.height, _default);
			
			_status = new InvalidateStatus();
			_interaction = new ButtonInteraction();
			_interaction.initialize(this);
			_initialized = true;
		}
		override public function set formWidth(width : Number) : void
		{
			_formWidth = width;
			_image.width = width;
			_status["size"] = true;
			invalidate();
		}
		override public function set formHeight(height : Number) : void
		{
			_formHeight = height;
			_image.height = height;
			_status["size"] = true;
			invalidate();
		}
		public function setting(toggle : Boolean = false, toggleOn : Boolean = false) : void
		{
			_formWidth = _default.width;
			_formHeight = _default.height;
			scaleX = scaleY = 1;
			_interaction.setting(toggle, toggleOn);
			_interaction.start();
			
			buttonSkinDraw();
		}
		/* *********************************************************************
		 * implement ISSenButton
		 ********************************************************************* */
		override public function kill() : void
		{
			_interaction.stop();
		}
		override public function deconstruction() : void
		{
			kill();
			_interaction.deconstruction();
			_interaction = null;
			_default = null;
			_over = null;
			_down = null;
			_selected = null;
			_disable = null;
		}
		override public function get data() : ISSenFormData
		{
			return null;
		}
		override public function set data(data : ISSenFormData) : void
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
			switch (_interaction.skinFlag) {
				case SkinFlag.DEFAULT : 
					_image.bitmapData = _default; 
					break;
				case SkinFlag.OVER : 
					_image.bitmapData = _over; 
					break;
				case SkinFlag.ACTION : 
					_image.bitmapData = _down; 
					break;
				case SkinFlag.SELECTED : 
					_image.bitmapData = _selected; 
					break;
				case SkinFlag.DISABLE : 
					_image.bitmapData = _disable; 
					break;
			}
			
			graphics.clear();
			_image.draw(graphics);
			_status.clear();
		}
		protected function getDefaultImage() : BitmapData
		{
			if (!_defaultBitmap) _defaultBitmap = new _defaultImage().bitmapData;
			return _defaultBitmap;
		}
		protected function getOverImage() : BitmapData
		{
			if (!_overBitmap) _overBitmap = new _overImage().bitmapData;
			return _overBitmap;
		}
		protected function getDownImage() : BitmapData
		{
			if (!_downBitmap) _downBitmap = new _downImage().bitmapData;
			return _downBitmap;
		}
		protected function getSelectedImage() : BitmapData
		{
			if (!_selectedBitmap) _selectedBitmap = new _selectedImage().bitmapData;
			return _selectedBitmap;
		}
		protected function getDisableImage() : BitmapData
		{
			if (!_disableBitmap) _disableBitmap = new _disableImage().bitmapData;
			return _disableBitmap;
		}
	}
}
