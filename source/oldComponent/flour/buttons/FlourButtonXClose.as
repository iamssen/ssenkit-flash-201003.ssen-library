package ssen.flour.buttons 
{
	import ssen.component.buttons.SimpleSkinButton;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;	
	/**
	 * @author SSen
	 */
	public class FlourButtonXClose extends SimpleSkinButton 
	{

		[Embed(source="asset/xClose/default.png")]
		private static var defaultImage : Class;

		[Embed(source="asset/xClose/over.png")]
		private static var overImage : Class;

		[Embed(source="asset/xClose/down.png")]
		private static var downImage : Class;

		[Embed(source="asset/xClose/disable.png")]
		private static var disableImage : Class;
		private var _skin : SkinAssetSprite;

		
		public function FlourButtonXClose()
		{
			_skin = new SkinAssetSprite(false, 15, 15, SkinFlag.DEFAULT, defaultImage);
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
