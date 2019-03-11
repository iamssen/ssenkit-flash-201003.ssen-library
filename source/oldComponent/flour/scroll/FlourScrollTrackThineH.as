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
	public class FlourScrollTrackThineH extends ScrollTrackBase 
	{

		[Embed(source="asset/thine/horizontal/thumb/default.png")]
		private static var defaultThumb : Class;

		[Embed(source="asset/thine/horizontal/thumb/action.png")]
		private static var actionThumb : Class;

		[Embed(source="asset/thine/horizontal/thumb/disable.png")]
		private static var disableThumb : Class;
		private static const HEIGHT : Number = 10;
		private var _thumb : SkinAssetSprite;
		private var _track : SkinFillRect;

		
		public function FlourScrollTrackThineH(width : Number,
											container : IScrollContainer = null,
											sec : Number = 0,
											isTrackHide : Boolean = false,
											trackMode : String = "point",
											minValue : Number = 0,
											maxValue : Number = 0)
		{
			_track = new SkinFillRect(true, 10, HEIGHT, SkinFlag.DEFAULT, new GraphicsSolidFill(0xb3b3b3));
			_track.addFill(SkinFlag.ACTION, new GraphicsSolidFill(0xadadad));
			_track.addFill(SkinFlag.ACTION, new GraphicsSolidFill(0xc8c8c8));
			
			_thumb = new SkinAssetSprite(true, 10, HEIGHT, SkinFlag.DEFAULT, defaultThumb);
			_thumb.addAsset(SkinFlag.OVER, actionThumb);
			_thumb.addAsset(SkinFlag.ACTION, actionThumb);
			_thumb.addAsset(SkinFlag.DISABLE, disableThumb);
			
			addChildren(_track, _thumb);
			setting(_track, _thumb, DirectionMode.HORIZONTAL, width, HEIGHT);
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
