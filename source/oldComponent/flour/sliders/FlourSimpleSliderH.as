package ssen.flour.sliders 
{
	import ssen.component.scroll.DirectionMode;
	import ssen.component.sliders.SliderBase;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;
	
	import flash.display.BitmapData;	
	/**
	 * @author SSen
	 */
	public class FlourSimpleSliderH extends SliderBase 
	{

		[Embed(source="asset/simple/horizontal/thumb/default.png")]
		private static var defaultThumb : Class;

		[Embed(source="asset/simple/horizontal/thumb/over.png")]
		private static var overThumb : Class;

		[Embed(source="asset/simple/horizontal/thumb/action.png")]
		private static var actionThumb : Class;

		[Embed(source="asset/simple/horizontal/thumb/disable.png")]
		private static var disableThumb : Class;

		[Embed(source="asset/simple/horizontal/track/default.png")]
		private static var defaultTrack : Class;

		[Embed(source="asset/simple/horizontal/track/action.png")]
		private static var actionTrack : Class;

		[Embed(source="asset/simple/horizontal/track/disable.png")]
		private static var disableTrack : Class;
		private var _segment : BitmapData;
		private var _track : SkinAssetSprite;
		private var _thumb : SkinAssetSprite;

		
		public function FlourSimpleSliderH(width : int, minValue : Number, maxValue : Number, value : Number, trackStep : Object = null, thumbSegmentStep : Boolean = false)
		{
			_thumb = new SkinAssetSprite(true, 12, 17, SkinFlag.DEFAULT, defaultThumb);
			_thumb.addAsset(SkinFlag.OVER, overThumb);
			_thumb.addAsset(SkinFlag.ACTION, actionThumb);
			_thumb.addAsset(SkinFlag.DISABLE, disableThumb);
			
			_track = new SkinAssetSprite(true, 1, 17, SkinFlag.DEFAULT, defaultTrack);
			_track.addAsset(SkinFlag.ACTION, actionTrack);
			_track.addAsset(SkinFlag.DISABLE, disableTrack);
			_track.width = width;
			
			addChildren(_track, _thumb);
			_segment = new BitmapData(1, 2, false, 0xcacaca);
			setting(_track, _thumb, DirectionMode.HORIZONTAL, minValue, maxValue, value, -1, -1, trackStep, _segment, -6, thumbSegmentStep);
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_thumb.resourceKill();
			_track.resourceKill();
			_segment.dispose();
		}
	}
}
