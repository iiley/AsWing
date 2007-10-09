package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.ASColor;
import org.aswing.guibuilder.util.MathUtils;

public class ColorSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML):*{
		var str:String = xml.@value;
		var color:ASColor;
		if(str == "null"){
			color = null;
		}else{
			var strs:Array = str.split(",");
			color = new ASColor(
				MathUtils.parseInteger(strs[0], 16), 
				MathUtils.parseNumber(strs[1]));
		}
		return color;
	}
	
	public function encodeValue(value:*):XML{
		var color:ASColor = value;
		var xml:XML = <Value></Value>;
		if(color == null){
			xml.@value = "null";
		}else{
			xml.@value = color.getRGB().toString(16)+","+color.getAlpha();
		}
		return xml;
	}
	
	public function getCodeLines(value:*):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*):String{
		var color:ASColor = value;
		if(color == null){
			return "null";
		}
		return "new ASColor(0x" + color.getRGB().toString(16) + ", " + color.getAlpha() + ")";
	}
	
}
}