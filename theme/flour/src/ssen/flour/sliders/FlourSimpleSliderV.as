package ssen.flour.sliders 
{
	import bmds.sliders.sliderGrayVThumbAction;
	import bmds.sliders.sliderGrayVThumbDefault;
	import bmds.sliders.sliderGrayVThumbDisable;
	import bmds.sliders.sliderGrayVThumbOver;
	import bmds.sliders.sliderGrayVTrackAction;
	import bmds.sliders.sliderGrayVTrackDefault;
	import bmds.sliders.sliderGrayVTrackDisable;
	
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
	public class FlourSimpleSliderV extends SliderBase 
	{
		private var _thumbDefault : BitmapData;
		private var _thumbOver : BitmapData;
		private var _thumbAction : BitmapData;
		private var _thumbDisable : BitmapData;
		private var _trackDefault : BitmapData;
		private var _trackAction : BitmapData;
		private var _trackDisable : BitmapData;
		private var _segment : BitmapData;

		public function FlourSimpleSliderV(height : int, minValue : Number, maxValue : Number, value : Number, trackStep : Object = null, thumbSegmentStep : Boolean = false)
		{
			_thumbDefault = new sliderGrayVThumbDefault(0, 0);
			_thumbOver = new sliderGrayVThumbOver(0, 0);
			_thumbAction = new sliderGrayVThumbAction(0, 0);
			_thumbDisable = new sliderGrayVThumbDisable(0, 0);
			_trackDefault = new sliderGrayVTrackDefault(0, 0);
			_trackAction = new sliderGrayVTrackAction(0, 0);
			_trackDisable = new sliderGrayVTrackDisable(0, 0);
			
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
			track.height = height;
			addChildren(track, thumb);
			
			_segment = new BitmapData(2, 1, false, 0xcacaca);
			
			setting(track, thumb, DirectionMode.VERTICAL, minValue, maxValue, value, -1, -1, trackStep, _segment, -6, thumbSegmentStep);
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
