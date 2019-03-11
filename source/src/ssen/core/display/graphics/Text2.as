package ssen.core.display.graphics {
	import ssen.core.text.SSenTextField;
	import ssen.core.geom.HorizontalAlign;
	import ssen.core.geom.Padding;
	import ssen.core.geom.VerticalAlign;
	import ssen.core.text.TextStyle;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsStroke;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;

	/**
	 * @author ssen (i@ssen.name)
	 */
	public class Text2 {
		private static var _bounds : Shape = new Shape();
		private var _text : String;
		private var _shapeChanged : Boolean;
		private var _padding : Padding;
		private var _box : Rectangle;
		private var _boxChanged : Boolean;
		private var _bitmap : BitmapData;
		private var _textBox : Rectangle;
		private var _textColor : uint;
		private var _ct : ColorTransform;
		private var _fill : GraphicsBitmapFill;
		private var _path : GraphicsPath;
		private var _mat : Matrix;
		private var _align : String;
		private var _valign : String;
		private var _x : int = 0;
		private var _y : int = 0;
		private var _lineBox : Rectangle;
		private var _bank : Vector.<BitmapData>;
		private var _line : SSenTextField;
		private var _style : TextStyle;

		public function Text2(box : Rectangle = null, padding : Padding = null, style : TextStyle = null, textColor : uint = 0x000000, align : String = "left", valign : String = "middle", text : String = "") {
			_fill = new GraphicsBitmapFill();
			_path = new GraphicsPath();
			_mat = new Matrix();
			_bank = new Vector.<BitmapData>();
			
			_style = style ? style : new TextStyle();
			
			_text = text;
			_box = box ? box : new Rectangle();
			_padding = padding ? padding : new Padding();
			_line = new SSenTextField();
			_line.defaultTextFormat = _style;
			_textBox = new Rectangle();
			_lineBox = new Rectangle();
			_ct = new ColorTransform();
			_textColor = textColor;
			_align = align;
			_valign = valign;
			
			_boxChanged = true;
			_shapeChanged = true;
		}

		public function draw(graphics : Graphics, shift : Boolean = false, shiftSpace : int = 0) : void {
			if (_text == "") return;
			
			if (_boxChanged) {
				_textBox.x = _box.x + _padding.left;
				_textBox.y = _box.y + _padding.top;
				_textBox.width = _box.width - _padding.left - _padding.right;
				_textBox.height = _box.height - _padding.top - _padding.bottom;
			}
			if (_boxChanged || _shapeChanged) {
				createTextLine(_text, _textBox.width);
				_bitmap = new BitmapData(_line.width, _line.height, true, 0x00ffffff);
				_bank.push(_bitmap);
				_lineBox.width = _bitmap.width;
				_lineBox.height = _bitmap.height;
				_bitmap.draw(_line);
			}
			_boxChanged = false;
			_shapeChanged = false;
			
			_ct.color = _textColor;
			_bitmap.colorTransform(_lineBox, _ct);
			
			var x : Number;
			var y : Number;
			
			switch (_align) {
				case HorizontalAlign.LEFT :
					x = _textBox.x;
					if (shift) {
						_padding.left += _bitmap.width + shiftSpace;
						_boxChanged = true;
					}
					break;
				case HorizontalAlign.CENTER:
					x = (_textBox.width / 2) - (_bitmap.width / 2) + _textBox.x;
					break;
				case HorizontalAlign.RIGHT:
					x = _textBox.x + _textBox.width - _bitmap.width;
					if (shift) {
						_padding.right += _bitmap.width + shiftSpace;
						_boxChanged = true; 
					}
					break;
			}
			switch (_valign) {
				case VerticalAlign.TOP : 
					break;
					y = _textBox.y;
				case VerticalAlign.MIDDLE :
					y = (_textBox.height / 2) - (_bitmap.height / 2) + _textBox.y; 
					break;
				case VerticalAlign.BOTTOM : 
					y = _textBox.y + _textBox.height - _bitmap.height;
					break;
			}
			
			_mat.identity();
			_mat.tx = x + _x;
			_mat.ty = y + _y;
			_fill.bitmapData = _bitmap;
			_fill.matrix = _mat;
			
			PathMaker.rect(_path, x, y, _bitmap.width, _bitmap.height);
			GraphicsDraw.draw(graphics, _path, _fill, stroke);
		}

		private function createTextLine(text : String, width : int) : void {
			_line.autoReplaceOverText = false;
			_line.defaultTextFormat = _style;
			_line.text = text;
			_line.autoSizeWidth();
			if (_line.width > width) {
				_line.autoReplaceOverText = true;
				_line.width = width;
			}
			_line.autoSizeHeight();
		}

		public function dispose() : void {
			var f : int = _bank.length;
			while (--f >= 0) {
				_bank[f].dispose();
				_bank[f] = null;
			}
			_bank.length = 0;
		}

		public function get elementFormat() : TextStyle {
			_shapeChanged = true;
			return _style;
		}

		public function set elementFormat(elementFormat : TextStyle) : void {
			_style = elementFormat;
			_shapeChanged = true;
		}

		public function get text() : String {
			return _text;
		}

		public function set text(text : String) : void {
			_text = text;
			_shapeChanged = true;
		}

		public function get paddingTop() : Number {
			return _padding.top;
		}

		public function set paddingTop(paddingTop : Number) : void {
			if (_padding.top != paddingTop) {
				_padding.top = paddingTop;
				_boxChanged = true;
			}
		}

		public function get paddingRight() : Number {
			return _padding.right;
		}

		public function set paddingRight(paddingRight : Number) : void {
			if (_padding.right != paddingRight) {
				_padding.right = paddingRight;
				_boxChanged = true;
			}
		}

		public function get paddingBottom() : Number {
			return _padding.bottom;
		}

		public function set paddingBottom(paddingBottom : Number) : void {
			if (_padding.bottom != paddingBottom) {
				_padding.bottom = paddingBottom;
				_boxChanged = true;
			}
		}

		public function get paddingLeft() : Number {
			return _padding.left;
		}

		public function set paddingLeft(paddingLeft : Number) : void {
			if (_padding.left != paddingLeft) {
				_padding.left = paddingLeft;
				_boxChanged = true;
			}
		}

		public function get boxX() : Number {
			return _box.x;
		}

		public function set boxX(boxX : Number) : void {
			if (_box.x != boxX) {
				_box.x = boxX;
				_boxChanged = true;
			}
		}

		public function get boxY() : Number {
			return _box.y;
		}

		public function set boxY(boxY : Number) : void {
			if (_box.y != boxY) {
				_box.y = boxY;
				_boxChanged = true;
			}
		}

		public function get boxWidth() : Number {
			return _box.width;
		}

		public function set boxWidth(boxWidth : Number) : void {
			if (_box.width != boxWidth) {
				_box.width = boxWidth;
				_boxChanged = true;
			}
		}

		public function get boxHeight() : Number {
			return _box.height;
		}

		public function set boxHeight(boxHeight : Number) : void {
			if (_box.height != boxHeight) {
				_box.height = boxHeight;
				_boxChanged = true;
			}
		}

		public function get textColor() : uint {
			return _textColor;
		}

		public function set textColor(color : uint) : void {
			_textColor = color;
		}

		private static const NO_STROKE : GraphicsStroke = new GraphicsStroke(0);
		private var _stroke : IGraphicsStroke;

		public function get stroke() : IGraphicsStroke {
			if (!_stroke) _stroke = NO_STROKE;
			return _stroke;
		}

		public function set stroke(stroke : IGraphicsStroke) : void {
			_stroke = stroke ? stroke : NO_STROKE;
		}

		public function get x() : int {
			return _x;
		}

		public function set x(x : int) : void {
			_x = x;
		}

		public function get y() : int {
			return _y;
		}

		public function set y(y : int) : void {
			_y = y;
		}
	}
}
