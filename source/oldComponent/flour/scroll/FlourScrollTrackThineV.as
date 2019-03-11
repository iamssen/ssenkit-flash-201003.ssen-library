package ssen.flour.scroll 
{
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.IScrollContainer;
	import ssen.component.scroll.ScrollTrackBase;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFillRect;
	import ssen.core.display.skin.SkinFlag;
	
	import flash.display.GraphicsSolidFill;	
	/**
	 * @author SSen
	 */
	public class FlourScrollTrackThineV extends ScrollTrackBase 
	{

		[Embed(source="asset/thine/vertical/thumb/default.png")]
		private static var defaultThumb : Class;

		[Embed(source="asset/thine/vertical/thumb/action.png")]
		private static var actionThumb : Class;

		[Embed(source="asset/thine/vertical/thumb/disable.png")]
		private static var disableThumb : Class;
		private static const WIDTH : Number = 10;
		private var _thumb : SkinAssetSprite;
		private var _track : SkinFillRect;

		
		public function FlourScrollTrackThineV(height : Number,
											container : IScrollContainer = null,
											sec : Number = 0,
											isTrackHide : Boolean = false,
											trackMode : String = "point",
											minValue : Number = 0,
											maxValue : Number = 0)
		{
			_track = new SkinFillRect(true, WIDTH, 10, SkinFlag.DEFAULT, new GraphicsSolidFill(0xd8d8d8));
			_track.addFill(SkinFlag.ACTION, new GraphicsSolidFill(0xcfcfcf));
			_track.addFill(SkinFlag.ACTION, new GraphicsSolidFill(0xe3e3e3));
			
			_thumb = new SkinAssetSprite(true, WIDTH, 10, SkinFlag.DEFAULT, defaultThumb);
			_thumb.addAsset(SkinFlag.OVER, actionThumb);
			_thumb.addAsset(SkinFlag.ACTION, actionThumb);
			_thumb.addAsset(SkinFlag.DISABLE, disableThumb);
			
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
