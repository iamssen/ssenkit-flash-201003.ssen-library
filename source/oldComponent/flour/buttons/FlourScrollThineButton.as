package ssen.flour.buttons 
{
	import ssen.component.buttons.SimpleSkinButton;
	import ssen.component.scroll.DirectionMode;
	import ssen.component.scroll.ScrollBarButtonType;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFlag;		
	/**
	 * @author SSen
	 */
	public class FlourScrollThineButton extends SimpleSkinButton 
	{

		[Embed(source="asset/scrollThine/horizontal/down/default.png")]
		private static var hdDefault : Class;

		[Embed(source="asset/scrollThine/horizontal/down/action.png")]
		private static var hdAction : Class;

		[Embed(source="asset/scrollThine/horizontal/down/disable.png")]
		private static var hdDisable : Class;

		[Embed(source="asset/scrollThine/horizontal/pageDown/default.png")]
		private static var hpdDefault : Class;

		[Embed(source="asset/scrollThine/horizontal/pageDown/action.png")]
		private static var hpdAction : Class;

		[Embed(source="asset/scrollThine/horizontal/pageDown/disable.png")]
		private static var hpdDisable : Class;

		[Embed(source="asset/scrollThine/horizontal/pageUp/default.png")]
		private static var hpuDefault : Class;

		[Embed(source="asset/scrollThine/horizontal/pageUp/action.png")]
		private static var hpuAction : Class;

		[Embed(source="asset/scrollThine/horizontal/pageUp/disable.png")]
		private static var hpuDisable : Class;

		[Embed(source="asset/scrollThine/horizontal/up/default.png")]
		private static var huDefault : Class;

		[Embed(source="asset/scrollThine/horizontal/up/action.png")]
		private static var huAction : Class;

		[Embed(source="asset/scrollThine/horizontal/up/disable.png")]
		private static var huDisable : Class;

		[Embed(source="asset/scrollThine/vertical/down/default.png")]
		private static var vdDefault : Class;

		[Embed(source="asset/scrollThine/vertical/down/action.png")]
		private static var vdAction : Class;

		[Embed(source="asset/scrollThine/vertical/down/disable.png")]
		private static var vdDisable : Class;

		[Embed(source="asset/scrollThine/vertical/pageDown/default.png")]
		private static var vpdDefault : Class;

		[Embed(source="asset/scrollThine/vertical/pageDown/action.png")]
		private static var vpdAction : Class;

		[Embed(source="asset/scrollThine/vertical/pageDown/disable.png")]
		private static var vpdDisable : Class;

		[Embed(source="asset/scrollThine/vertical/pageUp/default.png")]
		private static var vpuDefault : Class;

		[Embed(source="asset/scrollThine/vertical/pageUp/action.png")]
		private static var vpuAction : Class;

		[Embed(source="asset/scrollThine/vertical/pageUp/disable.png")]
		private static var vpuDisable : Class;

		[Embed(source="asset/scrollThine/vertical/up/default.png")]
		private static var vuDefault : Class;

		[Embed(source="asset/scrollThine/vertical/up/action.png")]
		private static var vuAction : Class;

		[Embed(source="asset/scrollThine/vertical/up/disable.png")]
		private static var vuDisable : Class;
		private var _skin : SkinAssetSprite;

		
		public function FlourScrollThineButton(directionMode : String, scrollBarButtonType : String)
		{
			_skin = new SkinAssetSprite();
			
			if (directionMode == DirectionMode.VERTICAL) {
				switch (scrollBarButtonType) {
					case ScrollBarButtonType.UP : 
						_skin = getSkin(10, 8, vuDefault, vuAction, vuDisable);
						break;
					case ScrollBarButtonType.DOWN : 
						_skin = getSkin(10, 8, vdDefault, vdAction, vdDisable);
						break;
					case ScrollBarButtonType.PAGE_UP : 
						_skin = getSkin(10, 10, vpuDefault, vpuAction, vpuDisable);
						break;
					case ScrollBarButtonType.PAGE_DOWN : 
						_skin = getSkin(10, 10, vpdDefault, vpdAction, vpdDisable);
						break;
				}
			} else {
				switch (scrollBarButtonType) {
					case ScrollBarButtonType.UP : 
						_skin = getSkin(8, 10, huDefault, huAction, huDisable);
						break;
					case ScrollBarButtonType.DOWN : 
						_skin = getSkin(8, 10, hdDefault, hdAction, hdDisable);
						break;
					case ScrollBarButtonType.PAGE_UP : 
						_skin = getSkin(10, 10, hpuDefault, hpuAction, hpuDisable);
						break;
					case ScrollBarButtonType.PAGE_DOWN :
						_skin = getSkin(10, 10, hpdDefault, hpdAction, hpdDisable); 
						break;
				}
			}
			
			super(_skin);
		}
		private function getSkin(width : Number, height : Number, defaultImage : Class, actionImage : Class, disableImage : Class) : SkinAssetSprite
		{
			var skin : SkinAssetSprite = new SkinAssetSprite(true, width, height, SkinFlag.DEFAULT, defaultImage);
			skin.addAsset(SkinFlag.OVER, actionImage);
			skin.addAsset(SkinFlag.ACTION, actionImage);
			skin.addAsset(SkinFlag.SELECTED, defaultImage);
			skin.addAsset(SkinFlag.DISABLE, disableImage);
			
			return skin;
		}
		override public function resourceKill() : void
		{
			super.resourceKill();
			_skin.resourceKill();
		}
	}
}
