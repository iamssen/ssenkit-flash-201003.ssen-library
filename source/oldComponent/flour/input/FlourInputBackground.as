package ssen.flour.input 
{
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;		
	/**
	 * @author SSen
	 */
	public class FlourInputBackground extends SkinAssetSprite 
	{

		[Embed(source="asset/inputBackground/default.png", scaleGridLeft="4", scaleGridTop="4", scaleGridRight="18", scaleGridBottom="17")]
		private static var defaultImage : Class;

		[Embed(source="asset/inputBackground/highlight.png", scaleGridLeft="4", scaleGridTop="4", scaleGridRight="18", scaleGridBottom="17")]
		private static var highlightImage : Class;

		[Embed(source="asset/inputBackground/disable.png", scaleGridLeft="4", scaleGridTop="4", scaleGridRight="18", scaleGridBottom="17")]
		private static var disableImage : Class;

		
		public function FlourInputBackground(interactiveObject : Boolean = true)
		{
			super(interactiveObject, 100, 100, SkinFlag.DEFAULT, defaultImage);
			addAsset(SkinFlag.OVER, defaultImage);
			addAsset(SkinFlag.ACTION, highlightImage);
			addAsset(SkinFlag.HIGHLIGHT, highlightImage);
			addAsset(SkinFlag.DISABLE, disableImage);
		}
	}
}
