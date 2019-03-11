package ssen.flour.buttons 
{
	import bmds.buttons.xCloseDefault;
	import bmds.buttons.xCloseDisable;
	import bmds.buttons.xCloseDown;
	import bmds.buttons.xCloseOver;

	import ssen.component.buttons.SimpleSkinButton;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSprite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;		
	/**
	 * @author SSen
	 */
	public class FlourButtonXClose extends SimpleSkinButton 
	{
		private var _defaultSkin : BitmapData;
		private var _overSkin : BitmapData;
		private var _downSkin : BitmapData;
		private var _disableSkin : BitmapData;

		public function FlourButtonXClose()
		{
			_defaultSkin = new xCloseDefault(0, 0);
			_overSkin = new xCloseOver(0, 0);
			_downSkin = new xCloseDown(0, 0);
			_disableSkin = new xCloseDisable(0, 0);
			
			var skinDic : Dictionary = new Dictionary(true);
			skinDic[SkinMode.DEFAULT] = new Bitmap(_defaultSkin);
			skinDic[SkinMode.OVER] = new Bitmap(_overSkin);
			skinDic[SkinMode.ACTION] = new Bitmap(_downSkin);
			skinDic[SkinMode.DISABLE] = new Bitmap(_disableSkin);
			skinDic[SkinMode.SELECTED] = new Bitmap(_defaultSkin);
			
			var skin : SkinSprite = new SkinSprite(skinDic);
			
			super(skin);
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			
			_defaultSkin.dispose();
			_overSkin.dispose();
			_downSkin.dispose();
			_disableSkin.dispose();
		}
	}
}
