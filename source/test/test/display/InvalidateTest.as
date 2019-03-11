package test.display 
{
	import ssen.core.display.CreateGraphicsStroke;
	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.display.skin.SkinAssetSprite;
	import ssen.core.display.skin.SkinFillRect;
	import ssen.core.display.skin.SkinFlag;
	import ssen.core.display.skin.SkinRoundFillRect;

	import flash.display.GraphicsSolidFill;
	import flash.events.MouseEvent;
	/**
	 * @author ssen
	 */
	public class InvalidateTest extends SSenSprite 
	{

		[Embed(source="asset/left_default.png")]
		private static var LeftDefaultImage : Class;

		[Embed(source="asset/left_over.png")]
		public static var LeftOverImage : Class;
		private var _asset : SkinAssetSprite;
		private var _rect : SkinFillRect;
		private var _round : SkinRoundFillRect;

		
		public function InvalidateTest()
		{
			_asset = new SkinAssetSprite(true, 7, 12, SkinFlag.DEFAULT, LeftDefaultImage);
			_asset.addAsset(SkinFlag.OVER, LeftOverImage);
			_asset.moveXY(10, 10);
			_asset.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			_asset.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
			
			_rect = new SkinFillRect(true, 15, 15, SkinFlag.DEFAULT, new GraphicsSolidFill(0xeeeeee), CreateGraphicsStroke.solid(2, 0x000000));
			_rect.addFill(SkinFlag.OVER, new GraphicsSolidFill(0x00ff00), CreateGraphicsStroke.solid(1, 0xaaaaaa));
			_rect.position = _asset.nextPosition();
			_rect.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			_rect.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
			
			_round = new SkinRoundFillRect(true, 20, 20, 5, 5, SkinFlag.DEFAULT, new GraphicsSolidFill(0xeeeeee), CreateGraphicsStroke.solid(2, 0x000000, 1, true));
			_round.addFill(SkinFlag.OVER, new GraphicsSolidFill(0xff0000), CreateGraphicsStroke.solid(1, 0xaaaaaa, 1, true));
			_round.position = _rect.nextPosition();
			_round.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0, true);
			_round.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0, true);
			
			addChildren(_asset, _rect, _round);
		}
		private function mouseOut(event : MouseEvent) : void
		{
			_asset.skinDraw(SkinFlag.DEFAULT);
			_rect.skinDraw(SkinFlag.DEFAULT);
			_round.skinDraw(SkinFlag.DEFAULT);
		}
		private function mouseOver(event : MouseEvent) : void
		{
			_asset.skinDraw(SkinFlag.OVER);
			_rect.skinDraw(SkinFlag.OVER);
			_round.skinDraw(SkinFlag.OVER);
		}
	}
}
