package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.util.MathUtils;

public class IntSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML):*{
		return MathUtils.parseInteger(xml.@value);
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = value+"";
		return xml;
	}
	
	public function getCodeLines(value:*):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*):String{
		return value;
	}
	
}
}