package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;

public class StringSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML):*{
		return xml.@value;
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
		return "\"" + value + "\"";
	}
	
}
}