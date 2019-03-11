package test.text 
{
	import ssen.core.display.CreateBoxes;

	import flash.display.Shape;

	import flashx.textLayout.operations.ApplyElementStyleNameOperation;
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.ElementRange;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.DivElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.events.FlowOperationEvent;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.undo.UndoManager;

	import ssen.core.display.expanse.SSenSprite;
	import ssen.core.events.RespondEvent;
	import ssen.core.net.ResourceLoader;
	import ssen.debug.TestButtonGroup;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.engine.FontLookup;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class EditManagerTest extends SSenSprite 
	{
		private var _tf : TextFlow;
		private var _um : UndoManager;
		private var _em : EditManager;
		private var _container : SSenSprite;
		private var _tg : TestButtonGroup;
		private var _loader : ResourceLoader;
		private var _tlf : TextLayoutFormat;
		private var _tlf2 : TextLayoutFormat;

		
		public function EditManagerTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		private function addedToStage(event : Event) : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_loader = new ResourceLoader();
			_loader.addEventListener(RespondEvent.RESPOND, respond, false, 0, true);
			_loader.load(new URLRequest("NanumGothic.swf"), new LoaderContext(false, loaderInfo.applicationDomain));
		}
		private function respond(event : RespondEvent) : void
		{
			if (event.success) {
				var nanumGothic : Class = _loader.contentLoaderInfo.applicationDomain.getDefinition("ssen.library.fonts.NanumGothic") as Class;
				nanumGothic["initialize"]();
				
				start();
			}
		}
		private function start() : void
		{
			_tlf = new TextLayoutFormat();
			_tlf.color = 0x555555;
			_tlf.fontSize = 12;
			_tlf.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlf.fontFamily = "Monaco, nanumGothic CFF";
			
			_tlf2 = new TextLayoutFormat();
			_tlf2.color = 0x00ff00;
			_tlf2.fontSize = 17;
			_tlf2.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlf2.fontFamily = "Monaco, nanumGothic CFF";
			
			_tf = new TextFlow();
			_tf.addEventListener(FlowOperationEvent.FLOW_OPERATION_BEGIN, operation);
			_tf.addEventListener(FlowOperationEvent.FLOW_OPERATION_END, operation);
			_um = new UndoManager();
			_em = new EditManager(_um);
			_tf.interactionManager = _em;
			_tf.hostFormat = _tlf;
			_container = new SSenSprite();
			_container.moveXY(10, 10);
			
			var d : DivElement = new DivElement();
			var p : ParagraphElement = new ParagraphElement();
			var s : SpanElement = new SpanElement();
			s.text = "This is sample text for the EditManager example.";
			p.addChild(s);
			d.addChild(p);
			_tf.addChild(d);    
			
			_tf.flowComposer.addController(new ContainerController(_container, 400, 300));
			_tf.flowComposer.updateAllControllers();
			
			_tg = new TestButtonGroup("set style name", setStyleName, "get xml", getXML, "selection", selection, "insert graphics", insertGraphics);
			_tg.position = _container.nextPositionBr();
			
			addChildren(_container, _tg);
		}
		private function selection() : void
		{
			_em.selectRange(1, 5);
			_em.setFocus();
		}
		private function operation(event : FlowOperationEvent) : void
		{
			trace(event.operation, !(event.operation is ApplyElementStyleNameOperation) || ApplyElementStyleNameOperation(event.operation).newStyleName);
		}
		private function getXML() : void
		{
			trace(TextConverter.export(_tf, TextConverter.FXG_FORMAT, ConversionType.XML_TYPE));
			trace(TextConverter.export(_tf, TextConverter.HTML_FORMAT, ConversionType.XML_TYPE));
			trace(TextConverter.export(_tf, TextConverter.PLAIN_TEXT_FORMAT, ConversionType.STRING_TYPE));
		}
		private function setStyleName() : void
		{
			_em.applyLeafFormat(_tlf2);
			_em.setFocus();
			
//			var selection : SelectionState = _em.getSelectionState();
//			var selectionRange : ElementRange = ElementRange.createElementRange(_tf, selection.absoluteStart, selection.absoluteEnd);
//			_em.changeStyleName("testStyle", selectionRange.firstParagraph, selection.absoluteStart, selection.absoluteEnd, selection);
//			trace(_em.editingMode, selectionRange.firstParagraph.getText(), selectionRange.firstParagraph, selection.absoluteStart, selection.absoluteEnd);
		}
		private function insertGraphics() : void
		{
			_em.insertInlineGraphic(CreateBoxes.createColorSpriteBox(0xff0000, 100, 100), 50, 50);
//			_em.insertInlineGraphic(new CustomInlineGraphic(0xff0000, 100, 100), 50, 50);
		}
	}
}
