package ssen.forms.base 
{
	import ssen.core.display.expanse.SSenSprite;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class FormSprite extends SSenSprite implements ISSenForm
	{
		protected var _formWidth : Number;
		protected var _formHeight : Number;
		protected var _initialized : Boolean;
		protected var _enabled : Boolean;
		public function kill() : void
		{
		}
		public function deconstruction() : void
		{
		}
		public function get enabled() : Boolean
		{
			return _enabled;
		}
		public function get data() : ISSenFormData
		{
			return null;
		}
		public function get initialized() : Boolean
		{
			return _initialized;
		}
		public function get formWidth() : Number
		{
			return _formWidth;
		}
		public function get formHeight() : Number
		{
			return _formHeight;
		}
		public function set enabled(enabled : Boolean) : void
		{
			_enabled = enabled;
		}
		public function set data(data : ISSenFormData) : void
		{
		}
		public function set formWidth(width : Number) : void
		{
			_formWidth = width;
		}
		public function set formHeight(height : Number) : void
		{
			_formHeight = height;
		}
		override public function get width() : Number
		{
			return scaleX * _formWidth;
		}
		override public function set width(width : Number) : void
		{
			scaleX = width / _formWidth;
		}
		override public function get height() : Number
		{
			return scaleY * _formHeight;
		}
		override public function set height(height : Number) : void
		{
			scaleY = height / _formHeight;
		}
		public function setFormSize(width : Number, height : Number) : void
		{
			formWidth = width;
			formHeight = height;
		}
	}
}
