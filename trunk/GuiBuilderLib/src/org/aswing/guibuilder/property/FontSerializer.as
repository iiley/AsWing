package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.ASFont;

public class FontSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML):*{
		if(xml.@value == "null"){
			return null;
		}
		var name:String = xml.@name;
		var size:int = MathUtils.parseInteger(xml.@size);
		var bold:Boolean = (xml.@bold == "true");
		var italic:Boolean = (xml.@italic == "true");
		var underline:Boolean = (xml.@underline == "true");
		var embedFonts:Boolean = (xml.@embedFonts == "true");
		var f:ASFont = new ASFont(name, size, bold, italic, underline, embedFonts);
		return font;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		if(value == null){
			xml.@value="null";
			return xml;
		}
		var f:ASFont = value;
		xml.@name = f.getName();
		xml.@size = f.getSize()+"";
		xml.@bold = f.isBold()+"";
		xml.@italic = f.isItalic()+"";
		xml.@underline = f.isUnderline()+"";
		xml.@embedFonts = f.isEmbedFonts()+"";
		return xml;
	}
	
	public function getCodeLines(value:*):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*):String{
		var font:ASFont = value;
		if(font == null){
			return "null";
		}
		return "new ASFont(\"" + font.getName()
				+ "\", " + font.getSize() 
				+ ", " + font.isBold() 
				+ ", " + font.isItalic() 
				+ ", " + font.isUnderline()
				+ ", " + font.isEmbedFonts()
				 + ")";
	}
	
}
}