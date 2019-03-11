package ssen.flour.buttons 
{
	import ssen.component.buttons.SimpleSkinButton;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;	
	/**
	 * @author SSen
	 */
	public class FlourInputButtons extends SimpleSkinButton 
	{

		[Embed(source="asset/comboBoxButton/default.png")]
		private static var defaultImage : Class;

		[Embed(source="asset/comboBoxButton/default.png")]
		private static var overImage : Class;

		[Embed(source="asset/comboBoxButton/default.png")]
		private static var downImage : Class;

		[Embed(source="asset/comboBoxButton/default.png")]
		private static var disableImage : Class;
		private var _skin : SkinAssetSprite;

		
		public function FlourInputButtons(id : String)
		{
			_skin = new SkinAssetSprite(false, 21, 23, SkinFlag.DEFAULT, defaultImage);
			_skin.addAsset(SkinFlag.OVER, overImage);
			_skin.addAsset(SkinFlag.ACTION, downImage);
			_skin.addAsset(SkinFlag.SELECTED, defaultImage);
			_skin.addAsset(SkinFlag.DISABLE, disableImage);
			
			super(_skin);
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_skin.resourceKill();
		}
	}
}
