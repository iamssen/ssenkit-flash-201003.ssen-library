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
	public class FlourSimpleSliderV extends SliderBase 
	{

		[Embed(source="asset/simple/vertical/thumb/default.png")]
		private static var defaultThumb : Class;

		[Embed(source="asset/simple/vertical/thumb/over.png")]
		private static var overThumb : Class;

		[Embed(source="asset/simple/vertical/thumb/action.png")]
		private static var actionThumb : Class;

		[Embed(source="asset/simple/vertical/thumb/disable.png")]
		private static var disableThumb : Class;

		[Embed(source="asset/simple/vertical/track/default.png")]
		private static var defaultTrack : Class;

		[Embed(source="asset/simple/vertical/track/action.png")]
		private static var actionTrack : Class;

		[Embed(source="asset/simple/vertical/track/disable.png")]
		private static var disableTrack : Class;
		private var _segment : BitmapData;
		private var _track : SkinAssetSprite;
		private var _thumb : SkinAssetSprite;

		
		public function FlourSimpleSliderV(height : int, minValue : Number, maxValue : Number, value : Number, trackStep : Object = null, thumbSegmentStep : Boolean = false)
		{
			_thumb = new SkinAssetSprite(true, 17, 12, SkinFlag.DEFAULT, defaultThumb);
			_thumb.addAsset(SkinFlag.OVER, overThumb);
			_thumb.addAsset(SkinFlag.ACTION, actionThumb);
			_thumb.addAsset(SkinFlag.DISABLE, disableThumb);
			
			_track = new SkinAssetSprite(true, 17, 1, SkinFlag.DEFAULT, defaultTrack);
			_track.addAsset(SkinFlag.ACTION, actionTrack);
			_track.addAsset(SkinFlag.DISABLE, disableTrack);
			_track.height = height;
			
			addChildren(_track, _thumb);
			_segment = new BitmapData(2, 1, false, 0xcacaca);
			setting(_track, _thumb, DirectionMode.VERTICAL, minValue, maxValue, value, -1, -1, trackStep, _segment, -6, thumbSegmentStep);
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
