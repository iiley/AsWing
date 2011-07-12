package flash.text;
import flash.events.EventDispatcher;
import flash.TextField;
import flash.display.DisplayObject;
class TextField extends   flash.display.InteractiveObject {

	public var alwaysShowSelection : Bool;
	public var antiAliasType : AntiAliasType;
	public var autoSize : TextFieldAutoSize;
	public var background : Bool;
	public var backgroundColor : Int;
	public var border : Bool;
	public var borderColor : Int;
	public var bottomScrollV(default,null) : Int;
	public var caretIndex(default,null) : Int;
	public var condenseWhite : Bool;
	public var defaultTextFormat : TextFormat;
	public var displayAsPassword : Bool;
	public var embedFonts : Bool;
	public var gridFitType : GridFitType;
	public var htmlText : String;
	public var length(default,null) : Int;
	public var maxChars : Int;
	public var maxScrollH(default,null) : Int;
	public var maxScrollV(default,null) : Int;
	public var mouseWheelEnabled : Bool;
	public var multiline : Bool;
	public var numLines(default,null) : Int;
	public var restrict : String;
	public var scrollH : Int;
	public var scrollV : Int;
	public var selectable : Bool;
	public var selectedText(default,null) : String;
	public var selectionBeginIndex(default,null) : Int;
	public var selectionEndIndex(default,null) : Int;
	public var sharpness : Float;
	public var styleSheet : StyleSheet; 
	public var text(GetText,SetText):String;
	public var textColor : Int;
	public var textHeight(GetTextHeight,null) : Float;
	public var textWidth(GetTextWidth,null) : Float;
	public var thickness : Float;
	public var type : TextFieldType;
	public var useRichTextClipboard : Bool;
	public var wordWrap : Bool;
	//var target:flash.TextField;
	public function new() {
		super();
		name = "TextField " + DisplayObject.mNameID;
		target.name = name;
	}
	 
	function GetTextWidth():Float
	{
		return target.textWidth;
	}
	function GetTextHeight():Float
	{
		return target.textHeight;
	}
	function SetText(__text:String):String
	{
		target.text = __text;
		return  __text;
	}
	function GetText():String
	{
		return target.text;
	}
	override private function buildGui():Void
	{
			target = flash.Lib.current.createTextField("", flash.Lib.current.getNextHighestDepth(), 0, 0, 100, 20);
			
	}
 
	public function appendText(newText : String) : Void
	{
		target.text += newText;
	}
	public function copyRichText() : String 
	{
		return target.htmlText;
	}
	public function getCharBoundaries(charIndex : Int) : flash.geom.Rectangle<Float>
	{
		return null;
	}
	public function getCharIndexAtPoint(x : Float, y : Float) : Int
	{
		return -1;
	}
	public function getFirstCharInParagraph(charIndex : Int) : Int
	{
		return -1;
	}
	public function getImageReference(id : String) : flash.display.DisplayObject
	{
		return null;
	}
	public function getLineIndexAtPoint(x : Float, y : Float) : Int
	{
		return -1;
	}
	public function getLineIndexOfChar(charIndex : Int) : Int
	{
		return -1;
	}
	public function getLineLength(lineIndex : Int) : Int
	{
		return -1;
	}
	public function getLineMetrics(lineIndex : Int) : TextLineMetrics
	{
		return null;
	}
	public function getLineOffset(lineIndex : Int) : Int
	{
		return -1;
	}
	public function getLineText(lineIndex : Int) : String
	{
		return "";
	}
	public function getParagraphLength(charIndex : Int) : Int
	{
		return -1;
	}
	public function getRawText() : String
	{
		return "";
	}
	public function getTextFormat(beginIndex : Int = -1, endIndex : Int = -1) : TextFormat
	{
		return target.getTextFormat(beginIndex,endIndex);
	}
	public function getTextRuns(beginIndex : Int = 0, endIndex : Int = 2147483647) : Array<Dynamic>
	{
		return null;
	}
	public function getXMLText(beginIndex : Int = 0, endIndex : Int = 2147483647) : String
	{
		return "";
	}
	public function insertXMLText(beginIndex : Int, endIndex : Int, richText : String, pasting : Bool = false) : Void
	{
		
	}
	public function pasteRichText(richText : String) : Bool
	{
		return false;
	}
	public function replaceSelectedText(value : String) : Void
	{
		target.replaceSel(value);
	}
	public function replaceText(beginIndex : Int, endIndex : Int, newText : String) : Void
	{
		target.replaceText(beginIndex, endIndex, newText);
	}
	public function setSelection(beginIndex : Int, endIndex : Int) : Void
	{
		
	}
	public function setTextFormat(format : TextFormat, beginIndex : Int = -1, endIndex : Int = -1) : Void
	{
		target.setTextFormat(beginIndex, endIndex, format);
	}

}

 
