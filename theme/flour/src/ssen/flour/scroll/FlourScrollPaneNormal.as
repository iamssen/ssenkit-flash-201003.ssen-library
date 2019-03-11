package ssen.flour.scroll 
{
	import bmds.scroll.scrollNormalPanePieceAction;
	import bmds.scroll.scrollNormalPanePieceDefault;
	import bmds.scroll.scrollNormalPanePieceDisable;

	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.ScrollContainer;
	import ssen.component.scroll.ScrollPaneBase;
	import ssen.core.display.DisplayObjectEx;
	import ssen.core.display.ISkinObject;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSprite;
	import ssen.core.geom.Padding;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class FlourScrollPaneNormal extends ScrollPaneBase 
	{
		private var _pieceDefault : BitmapData;
		private var _pieceAction : BitmapData;
		private var _pieceDisable : BitmapData;
		private var _piece : ISkinObject;

		/*
		 * TODO scrollTrack 들의 track skin 을 그라데이션으로 처리해서 piece 와 연결되어 보이게 한다
		 * TODO scrollTarck 들의 thumb 의 arrow 들을 아이콘으로 올리기
		 */
		public function FlourScrollPaneNormal(content : DisplayObject = null, width : Number = 300, height : Number = 250,
												directionMode : String = "verticalAndHorizontal", secX : Number = 0, secY : Number = 0,
												isTrackHide : Boolean = false, trackMode : String = "point")
		{
			// background setting
			_background = DisplayObjectEx.createTransparentShapeBox(width, height);
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
				
				_pieceDefault = new scrollNormalPanePieceDefault(0, 0);
				_pieceAction = new scrollNormalPanePieceAction(0, 0);
				_pieceDisable = new scrollNormalPanePieceDisable(0, 0);
				var pieceDic : Dictionary = new Dictionary(true);
				pieceDic[SkinMode.DEFAULT] = new Bitmap(_pieceDefault);
				pieceDic[SkinMode.ACTION] = new Bitmap(_pieceAction);
				pieceDic[SkinMode.DISABLE] = new Bitmap(_pieceDisable);
				_piece = new SkinSprite(pieceDic);
			
				addChild(DisplayObject(_piece));
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
					_piece.skinning(SkinMode.DEFAULT);
				} else {
					_piece.skinning(SkinMode.DISABLE);
				}
			}
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_pieceDefault.dispose();
			_pieceAction.dispose();
			_pieceDisable.dispose();
		}
	}
}
