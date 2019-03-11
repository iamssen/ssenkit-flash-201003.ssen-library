package ssen.flour.scroll 
{
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.ScrollContainer;
	import ssen.component.scroll.ScrollPaneBase;
	import ssen.core.display.CreateBoxes;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.geom.Padding;
	
	import flash.display.DisplayObject;	
	/**
	 * @author SSen
	 */
	public class FlourScrollPaneThin extends ScrollPaneBase
	{

		[Embed(source="asset/thine/piece/default.png")]
		private static var defaultPiece : Class;

		[Embed(source="asset/thine/piece/disable.png")]
		private static var disablePiece : Class;
		private var _piece : SkinAssetSprite;

		
		public function FlourScrollPaneThin(content : DisplayObject = null, width : Number = 300, height : Number = 250,
												directionMode : String = "verticalAndHorizontal", secX : Number = 0, secY : Number = 0,
												isTrackHide : Boolean = false, trackMode : String = "point")
		{
			// background setting
			_background = CreateBoxes.createColorShapeBox(0xd8d8d8, width, height);
			addChildAt(_background, 0);
			// container setting
			_container = new ScrollContainer(content, width, height, true, secX, secY);
			addChildAt(_container, 1);
			// padding setting
			_padding = new Padding(1, 1, 2, 1);
			
			_width = width;
			_height = height;
			
			if (directionMode == DirectionMode.VERTICAL_AND_HORIZONTAL) {
				_directionMode = DirectionMode.VERTICAL_AND_HORIZONTAL;
				_scrollerH = new FlourScrollBarThinH(width);
				_scrollerV = new FlourScrollBarThinV(height);
				_scrollerH.init(_container, secX, isTrackHide, trackMode);
				_scrollerV.init(_container, secY, isTrackHide, trackMode);
				addChildren(_scrollerH, _scrollerV);
				
				_piece = new SkinAssetSprite(true, 10, 10, SkinFlag.DEFAULT, defaultPiece);
				_piece.addAsset(SkinFlag.ACTION, defaultPiece);
				_piece.addAsset(SkinFlag.DISABLE, disablePiece);
				addChild(_piece);
			} else if (directionMode == DirectionMode.VERTICAL) {
				_directionMode = DirectionMode.VERTICAL;
				_scrollerV = new FlourScrollBarThinV(height);
				_scrollerV.init(_container, secY, isTrackHide, trackMode);
				addChild(DisplayObject(_scrollerV));
			} else if (directionMode == DirectionMode.HORIZONTAL) {
				_directionMode = DirectionMode.HORIZONTAL;
				_scrollerH = new FlourScrollBarThinH(width);
				_scrollerH.init(_container, secX, isTrackHide, trackMode);
				addChild(DisplayObject(_scrollerH));
			} else {
				throw new Error("ssen.component.scroll.ScrollPane :: scrollerH 와 scrollerV 둘 중 하나는 존재해야 합니다.");
			}
			
			align();
			alignPiece();
		}
		/* *********************************************************************
		 * override size
		 ********************************************************************* */
		override public function set width(value : Number) : void
		{
			super.width = value;
			alignPiece();
		}
		override public function set height(value : Number) : void
		{
			super.height = value;
			alignPiece();
		}
		private function alignPiece() : void
		{
			if (_directionMode == DirectionMode.VERTICAL_AND_HORIZONTAL) {
				_piece.x = _width - _piece.width - _padding.left - _padding.right;
				_piece.y = _height - _piece.height - _padding.top - _padding.bottom;
			}
		}
		override public function set enable(enable : Boolean) : void
		{
			super.enable = enable;
			if (enable != _enable) {
				if (enable) {
					_piece.skinDraw(SkinFlag.DEFAULT);
				} else {
					_piece.skinDraw(SkinFlag.DISABLE);
				}
			}
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_piece.resourceKill();
		}
	}
}
