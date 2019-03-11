package ssen.flour.buttons 
{
	import bmds.input.comboBoxButtonDefault;
	
	import ssen.component.buttons.SimpleSkinButton;
	import ssen.core.display.SkinMode;
	import ssen.core.display.SkinSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;	
	/**
	 * @author SSen
	 */
	public class FlourInputButtons extends SimpleSkinButton 
	{
		private var _defaultSkin : BitmapData;
		private var _overSkin : BitmapData;
		private var _downSkin : BitmapData;
		private var _disableSkin : BitmapData;
		private var _selectedSkin : BitmapData;
		
		public function FlourInputButtons(id : String)
		{
			_defaultSkin = new comboBoxButtonDefault(0, 0);
			_overSkin = new comboBoxButtonDefault(0, 0);
			_downSkin = new comboBoxButtonDefault(0, 0);
			_disableSkin = new comboBoxButtonDefault(0, 0);
			_selectedSkin = new comboBoxButtonDefault(0, 0);
			
			var skinDic : Dictionary = new Dictionary(true);
			skinDic[SkinMode.DEFAULT] = new Bitmap(_defaultSkin);
			skinDic[SkinMode.OVER] = new Bitmap(_overSkin);
			skinDic[SkinMode.ACTION] = new Bitmap(_downSkin);
			skinDic[SkinMode.DISABLE] = new Bitmap(_disableSkin);
			skinDic[SkinMode.SELECTED] = new Bitmap(_selectedSkin);
			
			var skin : SkinSprite = new SkinSprite(skinDic);
			
			super(skin);
		}
		
		override public function resourceKill() : void
		{
			super.resourceKill();
			
			//_defaultSkin.dispose();
		}
	}
}
