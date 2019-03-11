package ssen.flour.sliders 
{
	import bmds.sliders.sliderGrayHThumbAction;
	import bmds.sliders.sliderGrayHThumbDefault;
	import bmds.sliders.sliderGrayHThumbDisable;
	import bmds.sliders.sliderGrayHThumbOver;
	import bmds.sliders.sliderGrayHTrackAction;
	import bmds.sliders.sliderGrayHTrackDefault;
	import bmds.sliders.sliderGrayHTrackDisable;
	
	import ssen.component.scroll.DirectionMode;
	import ssen.component.sliders.SliderBase;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class FlourSimpleSliderH extends SliderBase 
	{
		private var _thumbDefault : BitmapData;
		private var _thumbOver : BitmapData;
		private var _thumbAction : BitmapData;
		private var _thumbDisable : BitmapData;
		private var _trackDefault : BitmapData;
		private var _trackAction : BitmapData;
		private var _trackDisable : BitmapData;
		private var _segment : BitmapData;

		public function FlourSimpleSliderH(width : int, minValue : Number, maxValue : Number, value : Number, trackStep : Object = null, thumbSegmentStep : Boolean = false)
		{
			_thumbDefault = new sliderGrayHThumbDefault(0, 0);
			_thumbOver = new sliderGrayHThumbOver(0, 0);
			_thumbAction = new sliderGrayHThumbAction(0, 0);
			_thumbDisable = new sliderGrayHThumbDisable(0, 0);
			_trackDefault = new sliderGrayHTrackDefault(0, 0);
			_trackAction = new sliderGrayHTrackAction(0, 0);
			_trackDisable = new sliderGrayHTrackDisable(0, 0);
			
			var thumbDic : Dictionary = new Dictionary(true);
			thumbDic[SkinMode.DEFAULT] = new Bitmap(_thumbDefault);
			thumbDic[SkinMode.OVER] = new Bitmap(_thumbOver);
			thumbDic[SkinMode.ACTION] = new Bitmap(_thumbAction);
			thumbDic[SkinMode.DISABLE] = new Bitmap(_thumbDisable);
			var trackDic : Dictionary = new Dictionary(true);
			trackDic[SkinMode.DEFAULT] = new Bitmap(_trackDefault);
			trackDic[SkinMode.ACTION] = new Bitmap(_trackAction);
			trackDic[SkinMode.DISABLE] = new Bitmap(_trackDisable);
			
			var thumb : SkinSprite = new SkinSprite(thumbDic);
			var track : SkinSprite = new SkinSprite(trackDic);
			track.width = width;
			addChildren(track, thumb);
			
			_segment = new BitmapData(1, 2, false, 0xcacaca);
			
			setting(track, thumb, DirectionMode.HORIZONTAL, minValue, maxValue, value, -1, -1, trackStep, _segment, -6, thumbSegmentStep);
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			
			_thumbDefault.dispose();
			_thumbOver.dispose();
			_thumbAction.dispose();
			_thumbDisable.dispose();
			_trackDefault.dispose();
			_trackAction.dispose();
			_trackDisable.dispose();
			_segment.dispose();
		}
	}
}
