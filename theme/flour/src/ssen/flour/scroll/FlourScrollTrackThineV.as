package ssen.flour.scroll 
{
	import bmds.scroll.scrollThineVThumbAction;
	import bmds.scroll.scrollThineVThumbDefault;
	import bmds.scroll.scrollThineVThumbDisable;
	
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.IScrollContainer;
	import ssen.component.scroll.ScrollTrackBase;
	import ssen.core.display.DisplayObjectEx;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class FlourScrollTrackThineV extends ScrollTrackBase 
	{
		private static const WIDTH : Number = 10;
		private var _thumbDefault : BitmapData;
		private var _thumbAction : BitmapData;
		private var _thumbDisable : BitmapData;

		public function FlourScrollTrackThineV(height : Number,
											container : IScrollContainer = null,
											sec : Number = 0,
											isTrackHide : Boolean = false,
											trackMode : String = "point",
											minValue : Number = 0,
											maxValue : Number = 0)
		{
			_thumbDefault = new scrollThineVThumbDefault(0, 0);
			_thumbAction = new scrollThineVThumbAction(0, 0);
			_thumbDisable = new scrollThineVThumbDisable(0, 0);
			
			var trackDic : Dictionary = new Dictionary(true);
			trackDic[SkinMode.DEFAULT] = DisplayObjectEx.createColorShapeBox(0xd8d8d8, 50, 50);
			trackDic[SkinMode.ACTION] = DisplayObjectEx.createColorShapeBox(0xcfcfcf, 50, 50);
			trackDic[SkinMode.DISABLE] = DisplayObjectEx.createColorShapeBox(0xe3e3e3, 50, 50);
			var trackSkin : SkinSprite = new SkinSprite(trackDic);
			trackSkin.width = WIDTH;
			
			var thumbDic : Dictionary = new Dictionary(true);
			thumbDic[SkinMode.DEFAULT] = new Bitmap(_thumbDefault);
			thumbDic[SkinMode.OVER] = new Bitmap(_thumbAction);
			thumbDic[SkinMode.ACTION] = new Bitmap(_thumbAction);
			thumbDic[SkinMode.DISABLE] = new Bitmap(_thumbDisable);
			var thumbSkin : SkinSprite = new SkinSprite(thumbDic);
			thumbSkin.width = WIDTH;
			
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
		}
	}
}
