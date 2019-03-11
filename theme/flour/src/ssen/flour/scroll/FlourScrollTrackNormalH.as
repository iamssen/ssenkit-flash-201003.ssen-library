package ssen.flour.scroll 
{
	import bmds.scroll.scrollNormalThumbHAction;
	import bmds.scroll.scrollNormalThumbHDefault;
	import bmds.scroll.scrollNormalThumbHDisable;
	import bmds.scroll.scrollNormalTrackHAction;
	import bmds.scroll.scrollNormalTrackHDefault;
	import bmds.scroll.scrollNormalTrackHDisable;

	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.IScrollContainer;
	import ssen.component.scroll.ScrollTrackBase;
	import ssen.core.display.GridBitmap;
	import ssen.core.display.GridType;
	import ssen.core.display.SkinGridBitmapSprite;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSprite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;		
	/**
	 * @author SSen
	 */
	public class FlourScrollTrackNormalH extends ScrollTrackBase 
	{
		private static const GRID : Rectangle = new Rectangle(10, 0, 10, 0);
		private static const HEIGHT : int = 20;
		private var _thumbDefault : BitmapData;
		private var _thumbAction : BitmapData;
		private var _thumbDisable : BitmapData;
		private var _trackDefault : BitmapData;
		private var _trackAction : BitmapData;
		private var _trackDisable : BitmapData;

		public function FlourScrollTrackNormalH(width : Number,
											container : IScrollContainer = null,
											sec : Number = 0,
											isTrackHide : Boolean = false,
											trackMode : String = "point",
											minValue : Number = 0,
											maxValue : Number = 0)
		{
			_thumbDefault = new scrollNormalThumbHDefault(0, 0);
			_thumbAction = new scrollNormalThumbHAction(0, 0);
			_thumbDisable = new scrollNormalThumbHDisable(0, 0);
			_trackDefault = new scrollNormalTrackHDefault(0, 0);
			_trackAction = new scrollNormalTrackHAction(0, 0);
			_trackDisable = new scrollNormalTrackHDisable(0, 0);
			
			var trackDic : Dictionary = new Dictionary(true);
			trackDic[SkinMode.DEFAULT] = new Bitmap(_trackDefault);
			trackDic[SkinMode.ACTION] = new Bitmap(_trackAction);
			trackDic[SkinMode.DISABLE] = new Bitmap(_trackDisable);
			var trackSkin : SkinSprite = new SkinSprite(trackDic);
			
			var thumbDic : Dictionary = new Dictionary(true);
			thumbDic[SkinMode.DEFAULT] = new GridBitmap(_thumbDefault, GRID, GridType.SCALE_3_GRID_HORIZONTAL, width, HEIGHT);
			thumbDic[SkinMode.OVER] = new GridBitmap(_thumbAction, GRID, GridType.SCALE_3_GRID_HORIZONTAL, width, HEIGHT);
			thumbDic[SkinMode.ACTION] = new GridBitmap(_thumbAction, GRID, GridType.SCALE_3_GRID_HORIZONTAL, width, HEIGHT);
			thumbDic[SkinMode.DISABLE] = new GridBitmap(_thumbDisable, GRID, GridType.SCALE_3_GRID_HORIZONTAL, width, HEIGHT);
			var thumbSkin : SkinGridBitmapSprite = new SkinGridBitmapSprite(thumbDic);
			
			addChildren(trackSkin, thumbSkin);
			setting(trackSkin, thumbSkin, DirectionMode.HORIZONTAL, width, HEIGHT);
			if (container != null) init(container, sec, isTrackHide, trackMode, minValue, maxValue);
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_thumbDefault.dispose();
			_thumbAction.dispose();
			_thumbDisable.dispose();
			_trackDefault.dispose();
			_trackAction.dispose();
			_trackDisable.dispose();
		}
	}
}
