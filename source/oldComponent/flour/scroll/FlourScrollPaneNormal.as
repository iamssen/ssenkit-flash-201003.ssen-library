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
	public class FlourScrollPaneNormal extends ScrollPaneBase 
	{

		[Embed(source="asset/normal/piece/default.png")]
		private static var defaultPiece : Class;

		[Embed(source="asset/normal/piece/action.png")]
		private static var actionPiece : Class;

		[Embed(source="asset/normal/piece/disable.png")]
		private static var disablePiece : Class;
		private var _piece : SkinAssetSprite;

		
		/*
		 * TODO scrollTrack 들의 track skin 을 그라데이션으로 처리해서 piece 와 연결되어 보이게 한다
		 * TODO scrollTarck 들의 thumb 의 arrow 들을 아이콘으로 올리기
		 */
		public function FlourScrollPaneNormal(content : DisplayObject = null, width : Number = 300, height : Number = 250,
												directionMode : String = "verticalAndHorizontal", secX : Number = 0, secY : Number = 0,
												isTrackHide : Boolean = false, trackMode : String = "point")
		{
			// background setting
			_background = CreateBoxes.createTransparentShapeBox(width, height);
			addChildAt(_background, 0);
			// container setting
			_container = new ScrollContainer(content, width, height, true, secX, secY);
			addChildAt(_container, 1);
			// padding setting
			_padding = new Padding(0, 0, 0, 0);
			
			_width = width;
			_height = height;
			
			if (directionMode == DirectionMode.VERTICAL_AND_HORIZONTAL) {
				_directionMode = DirectionMode.VERTICAL_AND_HORIZONTAL;
				_scrollerH = new FlourScrollTrackNormalH(width);
				_scrollerV = new FlourScrollTrackNormalV(height);
				_scrollerH.init(_container, secX, isTrackHide, trackMode);
				_scrollerV.init(_container, secY, isTrackHide, trackMode);
				addChildren(_scrollerH, _scrollerV);
				
				_piece = new SkinAssetSprite(true, 20, 20, SkinFlag.DEFAULT, defaultPiece);
				_piece.addAsset(SkinFlag.ACTION, actionPiece);
				_piece.addAsset(SkinFlag.DISABLE, disablePiece);
				addChild(_piece);
			} else if (directionMode == DirectionMode.VERTICAL) {
				_directionMode = DirectionMode.VERTICAL;
				_scrollerV = new FlourScrollTrackNormalV(height);
				_scrollerV.init(_container, secY, isTrackHide, trackMode);
				addChild(DisplayObject(_scrollerV));
			} else if (directionMode == DirectionMode.HORIZONTAL) {
				_directionMode = DirectionMode.HORIZONTAL;
				_scrollerH = new FlourScrollTrackNormalH(width);
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
