package ssen.flour.scroll 
{
	import bmds.scroll.scrollNormalThumbVAction;
	import bmds.scroll.scrollNormalThumbVDefault;
	import bmds.scroll.scrollNormalThumbVDisable;
	import bmds.scroll.scrollNormalTrackVAction;
	import bmds.scroll.scrollNormalTrackVDefault;
	import bmds.scroll.scrollNormalTrackVDisable;

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
	public class FlourScrollTrackNormalV extends ScrollTrackBase 
	{
		private static const GRID : Rectangle = new Rectangle(0, 10, 0, 9);
		private static const WIDTH : int = 20;
		private var _thumbDefault : BitmapData;
		private var _thumbAction : BitmapData;
		private var _thumbDisable : BitmapData;
		private var _trackDefault : BitmapData;
		private var _trackAction : BitmapData;
		private var _trackDisable : BitmapData;

		public function FlourScrollTrackNormalV(height : Number,
											container : IScrollContainer = null,
											sec : Number = 0,
											isTrackHide : Boolean = false,
											trackMode : String = "point",
											minValue : Number = 0,
											maxValue : Number = 0)
		{
			_thumbDefault = new scrollNormalThumbVDefault(0, 0);
			_thumbAction = new scrollNormalThumbVAction(0, 0);
			_thumbDisable = new scrollNormalThumbVDisable(0, 0);
			_trackDefault = new scrollNormalTrackVDefault(0, 0);
			_trackAction = new scrollNormalTrackVAction(0, 0);
			_trackDisable = new scrollNormalTrackVDisable(0, 0);
			
			var trackDic : Dictionary = new Dictionary(true);
			trackDic[SkinMode.DEFAULT] = new Bitmap(_trackDefault);
			trackDic[SkinMode.ACTION] = new Bitmap(_trackAction);
			trackDic[SkinMode.DISABLE] = new Bitmap(_trackDisable);
			var trackSkin : SkinSprite = new SkinSprite(trackDic);
			
			var thumbDic : Dictionary = new Dictionary(true);
			thumbDic[SkinMode.DEFAULT] = new GridBitmap(_thumbDefault, GRID, GridType.SCALE_3_GRID_VERTICAL, WIDTH, height);
			thumbDic[SkinMode.OVER] = new GridBitmap(_thumbAction, GRID, GridType.SCALE_3_GRID_VERTICAL, WIDTH, height);
			thumbDic[SkinMode.ACTION] = new GridBitmap(_thumbAction, GRID, GridType.SCALE_3_GRID_VERTICAL, WIDTH, height);
			thumbDic[SkinMode.DISABLE] = new GridBitmap(_thumbDisable, GRID, GridType.SCALE_3_GRID_VERTICAL, WIDTH, height);
			var thumbSkin : SkinGridBitmapSprite = new SkinGridBitmapSprite(thumbDic);
			
			addChildren(trackSkin, thumbSkin);
			setting(trackSkin, thumbSkin, DirectionMode.VERTICAL, WIDTH, height);
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
