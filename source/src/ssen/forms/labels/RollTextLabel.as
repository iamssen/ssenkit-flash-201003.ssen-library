package ssen.forms.labels 
{
	import ssen.core.display.skin.ColorCollection;
	import ssen.core.display.skin.ISkinDisplayObject;
	import ssen.core.display.skin.InvalidateStatus;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.text.SSenTextField;
	import ssen.core.text.TextStyle;
	import ssen.forms.base.FormSprite;
	import ssen.forms.base.ISSenFormData;

	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;

	/**
	 * Rolling text : skin[default, action, disable, highlight]
	 * @author SSen
	 */
	[SWF(width="550",height="400",frameRate="31",backgroundColor="#444444")]
	public class RollTextLabel extends FormSprite implements ISSenTextLable, ISkinDisplayObject
	{
		private var _textStyle : TextStyle;
		private var _fontColors : ColorCollection;
		private var _background : ColorCollection;
		private var _speed : Number;
		private var _replaceWord : String;
		private var _replaceWidth : int;
		private var _data : TextLableData;
		private var _text : SSenTextField;
		private var _bitmaps : Vector.<BitmapData>;
		private var _halfY : int;
		private var _roll : Boolean;
		private var _rollX : Number;
		private var _timer : Timer;
		private var _rollWidth : int;
		private var _skinFlag : String;
		private var _status : InvalidateStatus;
		public function initialize() : void
		{
			mouseChildren = false;
			_text = new SSenTextField();
			_bitmaps = new Vector.<BitmapData>(8, true);
			_status = new InvalidateStatus();
			
			_initialized = true;
		}
		protected function getBackGround() : ColorCollection 
		{
			return null;
		}
		protected function getTextStyle() : TextStyle
		{
			return new TextStyle();
		}
		protected function getFontColors() : ColorCollection
		{
			var colors : ColorCollection = new ColorCollection();
			colors.addColor(SkinFlag.DEFAULT, 0x000000);
			colors.addColor(SkinFlag.ACTION, 0x000000);
			colors.addColor(SkinFlag.DISABLE, 0x000000);
			colors.addColor(SkinFlag.HIGHLIGHT, 0x000000);
			return colors;
		}
		public function setting(data : TextLableData = null, width : int = 250, height : int = 30, speed : Number = 1.3, replaceWord : String = "...", replaceWidth : int = 15, textStyle : TextStyle = null, fontColors : ColorCollection = null, background : ColorCollection = null) : void
		{
			_textStyle = textStyle ? textStyle : getTextStyle();
			_fontColors = fontColors ? fontColors : getFontColors();
			_background = background ? background : getBackGround();
			
			_speed = speed;
			_replaceWord = replaceWord;
			_replaceWidth = replaceWidth;
			_data = data;
			_formWidth = width;
			_formHeight = height;
			_rollX = 0;
			_enabled = true;
			
			if (_data) {
				_status["data"] = true;
				invalidate();
			}
		}
		private function setDisplayList() : void 
		{
			if (_data) {
				_text.replaceWidth = _replaceWidth;
				_text.replaceWord = _replaceWord;
				_text.autoReplaceOverText = true;
				_text.text = _data.title;
				_text.defaultTextFormat = _textStyle;
				_text.autoSizeHeight();
				_halfY = (_formHeight >> 1) - (_text.height >> 1);
				
				var bmd : BitmapData;
				var flag : Array = [SkinFlag.DEFAULT, SkinFlag.ACTION, SkinFlag.DISABLE, SkinFlag.HIGHLIGHT];
				var height : int = _text.height;
				
				_text.width = _formWidth;
				var f : int = -1;
				var transparent : Boolean = _background == null;
				while(++f < 4) {
					if (_bitmaps[f]) _bitmaps[f].dispose();
					_text.textColor = _fontColors.getColor(flag[f]);
					bmd = new BitmapData(_formWidth, height, transparent, transparent ? 0x00ffffff : _background.getColor(flag[f]));
					bmd.draw(_text);
					_bitmaps[f] = bmd;
				}
				
				_text.autoReplaceOverText = false;
				_text.autoSizeWidth();
				_rollWidth = _text.width;
				trace("llll", _rollWidth);
				f = 3;
				while(++f < 8) {
					if (_bitmaps[f]) _bitmaps[f].dispose();
					_text.textColor = _fontColors.getColor(flag[f - 4]);
					bmd = new BitmapData(_rollWidth, height, transparent, transparent ? 0x00ffffff : _background.getColor(flag[f - 4]));
					bmd.draw(_text);
					_bitmaps[f] = bmd;
				}
			}
		}
		public function get roll() : Boolean
		{
			return _roll;
		}
		public function set roll(roll : Boolean) : void
		{
			if (roll == _roll || stage == null) return;
			
			_roll = roll;
			_rollX = 0;
			_status["roll"] = true;
			invalidate();
		}
		private function timerStop() : void 
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, rollTimer);
			_timer = null;
		}
		private function timerStart() : void
		{
			_timer = new Timer(10);
			_timer.addEventListener(TimerEvent.TIMER, rollTimer);
			_timer.start();
		}
		private function rollTimer(event : TimerEvent) : void 
		{
			_rollX = (_rollX - _speed) % _rollWidth;
			draw();
			event.updateAfterEvent();
		}
		override public function set formWidth(width : Number) : void
		{
			if (_formWidth != width) {
				_formWidth = width;
				_status["width"] = true;
				invalidate();
			}
		}
		override public function set formHeight(height : Number) : void
		{
			if (_formHeight != height) {
				_formHeight = height;
				_status["height"] = true;
				invalidate();
			}
		}
		/* *********************************************************************
		 * implement ISSenTextLable
		 ********************************************************************* */
		override public function kill() : void
		{
			var f : int = _bitmaps.length;
			while (--f >= 0) {
				_bitmaps[f].dispose();
				_bitmaps[f] = null;
			}
			_data = null;
			graphics.clear();
		}
		override public function deconstruction() : void
		{
			if (parent) DisplayObjectContainer(parent).removeChild(this);
			kill();
			_bitmaps = null;
		}
		override public function get enabled() : Boolean
		{
			return _enabled;
		}
		override public function get data() : ISSenFormData
		{
			return _data;
		}
		override public function set enabled(enabled : Boolean) : void
		{
			if (_enabled != enabled) {
				_enabled = enabled;
				if (enabled) {
					skinDraw(SkinFlag.DEFAULT);
				} else {
					skinDraw(SkinFlag.DISABLE);
				}
			}
		}
		override public function set data(data : ISSenFormData) : void
		{
			_data = TextLableData(data);
			_status["data"] = true;
			invalidate();
		}
		/* *********************************************************************
		 * imlement ISkinDisplayObject
		 ********************************************************************* */
		public function skinDraw(flag : String) : void
		{
			if (_skinFlag != flag) {
				_skinFlag = _enabled ? flag : SkinFlag.DISABLE;
				_status["skinFlag"] = true;
				invalidate();
			}
		}
		public function get skinFlag() : String
		{
			return _skinFlag;
		}
		/* *********************************************************************
		 * display invalidating
		 ********************************************************************* */
		private function invalidate() : void
		{
			if (_data == null) return;
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
			if (_status["data"] || _status["width"] || _status["height"]) {
				setDisplayList();
			}
			if (_status["roll"] && _rollWidth > _formWidth) {
				if (_roll) {
					_skinFlag = SkinFlag.ACTION;
					timerStart();
				} else {
					_skinFlag = SkinFlag.DEFAULT;
					timerStop();
				}
			}
			if (_status["data"] || _status["width"] || _status["height"] || _status["skinFlag"] || _status["draw"]) {
				var mat : Matrix = new Matrix();
				mat.tx = _rollX;
				mat.ty = _halfY;
				graphics.clear();
				if (_background) {
					graphics.beginFill(_background.getColor(_skinFlag));
					graphics.drawRect(0, 0, _formWidth, _formHeight);
					graphics.endFill();
				}
				var index : int = getBitmapIndexFromSkinFlag();
				var width1 : int;
				var width2 : int;
				if (_roll) {
					width1 = _rollWidth + _rollX;
					if (width1 >= _formWidth) width1 = _formWidth;
					width2 = (width1 < _formWidth) ? _formWidth - width1 : 0; 
				} else {
					width1 = _formWidth;
					width2 = 0;
				}
				graphics.beginBitmapFill(_bitmaps[index], mat, false);
				graphics.drawRect(0, _halfY, width1, _bitmaps[index].height);
				graphics.endFill();
				
				if (_roll && width2 > 0) {
					mat.tx = width1;
					mat.ty = _halfY;
					graphics.beginBitmapFill(_bitmaps[index], mat, false);
					graphics.drawRect(width1, _halfY, width2, _bitmaps[index].height);
					graphics.endFill();
				}
			}
			
			_status.clear();
		}
		private function getBitmapIndexFromSkinFlag() : int
		{
			var index : int;
			switch (_skinFlag) {
				case SkinFlag.DEFAULT :
					index = 0; 
					break;
				case SkinFlag.ACTION :
					index = 1; 
					break;
				case SkinFlag.DISABLE :
					index = 2; 
					break;
				case SkinFlag.HIGHLIGHT :
					index = 3; 
					break;
			}
			if (_roll) index = index + 4;
			return index;
		}
		private function draw() : void 
		{
			_status["draw"] = true;
			invalidate();
		}
	}
}
