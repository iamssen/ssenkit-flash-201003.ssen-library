package ssen.flour.scroll 
{
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.IScrollContainer;
	import ssen.component.scroll.ScrollTrackBase;
	import ssen.core.display.GridType;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.display.skin.SkinSliceBitmap;
	
	import flash.geom.Rectangle;	
	/**
	 * @author SSen
	 */
	public class FlourScrollTrackNormalV extends ScrollTrackBase 
	{

		[Embed(source="asset/normal/vertical/thumb/default.png")]
		private static var defaultThumb : Class;

		[Embed(source="asset/normal/vertical/thumb/action.png")]
		private static var actionThumb : Class;

		[Embed(source="asset/normal/vertical/thumb/disable.png")]
		private static var disableThumb : Class;

		[Embed(source="asset/normal/vertical/track/default.png")]
		private static var defaultTrack : Class;

		[Embed(source="asset/normal/vertical/track/action.png")]
		private static var actionTrack : Class;

		[Embed(source="asset/normal/vertical/track/disable.png")]
		private static var disableTrack : Class;
		private static const WIDTH : int = 20;
		private var _track : SkinAssetSprite;
		private var _thumb : SkinSliceBitmap;

		
		public function FlourScrollTrackNormalV(height : Number,
											container : IScrollContainer = null,
											sec : Number = 0,
											isTrackHide : Boolean = false,
											trackMode : String = "point",
											minValue : Number = 0,
											maxValue : Number = 0)
		{
			_track = new SkinAssetSprite(true, 100, 100, SkinFlag.DEFAULT, defaultTrack);
			_track.addAsset(SkinFlag.ACTION, actionTrack);
			_track.addAsset(SkinFlag.DISABLE, disableTrack);
			
			_thumb = new SkinSliceBitmap(true, 100, 100, new Rectangle(0, 10, 20, 9), GridType.SCALE_3_GRID_VERTICAL, SkinFlag.DEFAULT, new defaultThumb().bitmapData);
			_thumb.addBitmapData(SkinFlag.OVER, new actionThumb().bitmapData);
			_thumb.addBitmapData(SkinFlag.ACTION, new actionThumb().bitmapData);
			_thumb.addBitmapData(SkinFlag.DISABLE, new disableThumb().bitmapData);
			
			addChildren(_track, _thumb);
			setting(_track, _thumb, DirectionMode.VERTICAL, WIDTH, height);
			if (container != null) init(container, sec, isTrackHide, trackMode, minValue, maxValue);
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_track.resourceKill();
			_thumb.resourceKill();
		}
	}
}
