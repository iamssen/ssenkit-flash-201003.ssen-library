package test.text 
{
	import flashx.textLayout.formats.FormatValue;

	import flash.text.engine.CFFHinting;

	import flashx.textLayout.formats.BlockProgression;
	import flashx.textLayout.formats.ITextLayoutFormat;

	import flash.text.engine.BreakOpportunity;
	import flash.text.engine.TextBaseline;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class TestFormat implements ITextLayoutFormat 
	{
		public function get color() : *
		{
			return 0x0000ff;
		}
		public function get backgroundColor() : *
		{
			return 0xaaaaaa;
		}
		public function get lineThrough() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get textAlpha() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get backgroundAlpha() : *
		{
			return 1;
		}
		public function get fontSize() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get baselineShift() : *
		{
			return 0;
		}
		public function get trackingLeft() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get trackingRight() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get lineHeight() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get breakOpportunity() : *
		{
			return BreakOpportunity.AUTO;
		}
		public function get digitCase() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get digitWidth() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get dominantBaseline() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get kerning() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get ligatureLevel() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get alignmentBaseline() : *
		{
			return TextBaseline.USE_DOMINANT_BASELINE;
		}
		public function get locale() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get typographicCase() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get fontFamily() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get textDecoration() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get fontWeight() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get fontStyle() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get whiteSpaceCollapse() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get renderingMode() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get cffHinting() : *
		{
			return CFFHinting.HORIZONTAL_STEM;
		}
		public function get fontLookup() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get textRotation() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get textIndent() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get paragraphStartIndent() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get paragraphEndIndent() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get paragraphSpaceBefore() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get paragraphSpaceAfter() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get textAlign() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get textAlignLast() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get textJustify() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get justificationRule() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get justificationStyle() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get direction() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get tabStops() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get leadingModel() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get columnGap() : *
		{
			return 20;
		}
		public function get paddingLeft() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get paddingTop() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get paddingRight() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get paddingBottom() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get columnCount() : *
		{
			return FormatValue.AUTO;
		}
		public function get columnWidth() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get firstBaselineOffset() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get verticalAlign() : *
		{
			// TODO: Implement me!!!
			return null;
		}
		public function get blockProgression() : *
		{
			return BlockProgression.TB;
		}
		public function get lineBreak() : *
		{
			// TODO: Implement me!!!
			return null;
		}
	}
}
