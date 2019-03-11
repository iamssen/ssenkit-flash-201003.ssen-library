package ssen.component.buttons 
{
	import ssen.component.interaction.ButtonInteraction;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.events.SSenEvent;
	
	import flash.display.DisplayObject;	
	/**
	 * SkinSprite 를 넣어서 간단하게 만드는 Button
	 * @author SSen
	 */
	public class SimpleSkinButton extends SSenSprite implements IButton
	{
		private var _buttonSkin : ISkinDisplayObject;
		private var _width : Number;
		private var _height : Number;
		private var _interaction : ButtonInteraction;

		public function SimpleSkinButton(buttonSkin : ISkinDisplayObject, buttonType : String = "normal")
		{
			_width = buttonSkin.width;
			_height = buttonSkin.height;
			_buttonSkin = buttonSkin;
			addChild(DisplayObject(buttonSkin));

			_interaction = new ButtonInteraction(this, buttonType);
			_interaction.addEventListener(SSenEvent.SKINNING, skinDraw, false, 0, true);
			_interaction.start();
		}
		/* *********************************************************************
		 * public interface override 
		 ********************************************************************* */
		/** @private */
		override public function get width() : Number
		{
			return _width;
		}
		override public function set width(value : Number) : void
		{
			_width = value;
			_buttonSkin.width = value;
		}
		/** @private */
		override public function get height() : Number
		{
			return _height;
		}
		override public function set height(value : Number) : void
		{
			_height = value;
			_buttonSkin.height = value;
		}
		/* *********************************************************************
		 * implement IButton
		 ********************************************************************* */
		public function resourceKill() : void
		{
			_interaction.resourceKill();
			_interaction.removeEventListener(SSenEvent.SKINNING, skinDraw);
			_buttonSkin = null;
		}
		public function get toggleOn() : Boolean
		{
			return _interaction.toggleOn;
		}
		public function set toggleOn(toggleOn : Boolean) : void
		{
			_interaction.toggleOn = toggleOn;
		}
		public function get buttonType() : String
		{
			return _interaction.buttonType;
		}
		public function set buttonType(buttonType : String) : void
		{
			_interaction.buttonType = buttonType;
		}
		public function get isMousePress() : Boolean
		{
			return _interaction.isMousePress;
		}
		public function get enable() : Boolean
		{
			return _interaction.enabled;
		}
		public function set enable(enable : Boolean) : void
		{
			if (enable) {
				_interaction.start();
			} else {
				_interaction.stop();
			}
		}
		/* *********************************************************************
		 * skinning
		 ********************************************************************* */
		private function skinDraw(event : SSenEvent) : void
		{
			_buttonSkin.skinDraw(_interaction.skinMode);
		}
	}
}
