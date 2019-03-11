package ssen.flour.buttons 
{
	import bmds.scroll.scrollThineHBtnDownAction;
	import bmds.scroll.scrollThineHBtnDownDefault;
	import bmds.scroll.scrollThineHBtnDownDisable;
	import bmds.scroll.scrollThineHBtnPageDownAction;
	import bmds.scroll.scrollThineHBtnPageDownDefault;
	import bmds.scroll.scrollThineHBtnPageDownDisable;
	import bmds.scroll.scrollThineHBtnPageUpAction;
	import bmds.scroll.scrollThineHBtnPageUpDefault;
	import bmds.scroll.scrollThineHBtnPageUpDisable;
	import bmds.scroll.scrollThineHBtnUpAction;
	import bmds.scroll.scrollThineHBtnUpDefault;
	import bmds.scroll.scrollThineHBtnUpDisable;
	import bmds.scroll.scrollThineVBtnDownAction;
	import bmds.scroll.scrollThineVBtnDownDefault;
	import bmds.scroll.scrollThineVBtnDownDisable;
	import bmds.scroll.scrollThineVBtnPageDownAction;
	import bmds.scroll.scrollThineVBtnPageDownDefault;
	import bmds.scroll.scrollThineVBtnPageDownDisable;
	import bmds.scroll.scrollThineVBtnPageUpAction;
	import bmds.scroll.scrollThineVBtnPageUpDefault;
	import bmds.scroll.scrollThineVBtnPageUpDisable;
	import bmds.scroll.scrollThineVBtnUpAction;
	import bmds.scroll.scrollThineVBtnUpDefault;
	import bmds.scroll.scrollThineVBtnUpDisable;

	import ssen.component.buttons.SimpleSkinButton;
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.ScrollBarButtonType;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSprite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class FlourScrollThineButton extends SimpleSkinButton 
	{
		private var _defaultSkin : BitmapData;
		private var _overSkin : BitmapData;
		private var _disableSkin : BitmapData;

		public function FlourScrollThineButton(directionMode : String, scrollBarButtonType : String)
		{
			if (directionMode == DirectionMode.VERTICAL) {
				switch (scrollBarButtonType) {
					case ScrollBarButtonType.UP : 
						_defaultSkin = new scrollThineVBtnUpDefault(0, 0);
						_overSkin = new scrollThineVBtnUpAction(0, 0);
						_disableSkin = new scrollThineVBtnUpDisable(0, 0);
						break;
					case ScrollBarButtonType.DOWN : 
						_defaultSkin = new scrollThineVBtnDownDefault(0, 0);
						_overSkin = new scrollThineVBtnDownAction(0, 0);
						_disableSkin = new scrollThineVBtnDownDisable(0, 0);
						break;
					case ScrollBarButtonType.PAGE_UP : 
						_defaultSkin = new scrollThineVBtnPageUpDefault(0, 0);
						_overSkin = new scrollThineVBtnPageUpAction(0, 0);
						_disableSkin = new scrollThineVBtnPageUpDisable(0, 0);
						break;
					case ScrollBarButtonType.PAGE_DOWN : 
						_defaultSkin = new scrollThineVBtnPageDownDefault(0, 0);
						_overSkin = new scrollThineVBtnPageDownAction(0, 0);
						_disableSkin = new scrollThineVBtnPageDownDisable(0, 0);
						break;
				}
			} else {
				switch (scrollBarButtonType) {
					case ScrollBarButtonType.UP : 
						_defaultSkin = new scrollThineHBtnUpDefault(0, 0);
						_overSkin = new scrollThineHBtnUpAction(0, 0);
						_disableSkin = new scrollThineHBtnUpDisable(0, 0);
						break;
					case ScrollBarButtonType.DOWN : 
						_defaultSkin = new scrollThineHBtnDownDefault(0, 0);
						_overSkin = new scrollThineHBtnDownAction(0, 0);
						_disableSkin = new scrollThineHBtnDownDisable(0, 0);
						break;
					case ScrollBarButtonType.PAGE_UP : 
						_defaultSkin = new scrollThineHBtnPageUpDefault(0, 0);
						_overSkin = new scrollThineHBtnPageUpAction(0, 0);
						_disableSkin = new scrollThineHBtnPageUpDisable(0, 0);
						break;
					case ScrollBarButtonType.PAGE_DOWN : 
						_defaultSkin = new scrollThineHBtnPageDownDefault(0, 0);
						_overSkin = new scrollThineHBtnPageDownAction(0, 0);
						_disableSkin = new scrollThineHBtnPageDownDisable(0, 0);
						break;
				}
			}
			
			var skinDic : Dictionary = new Dictionary(true);
			skinDic[SkinMode.DEFAULT] = new Bitmap(_defaultSkin);
			skinDic[SkinMode.OVER] = new Bitmap(_overSkin);
			skinDic[SkinMode.ACTION] = new Bitmap(_overSkin);
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
			_disableSkin.dispose();
		}
	}
}
