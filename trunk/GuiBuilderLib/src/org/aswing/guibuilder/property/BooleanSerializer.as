package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;

public class BooleanSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML):*{
		var str:String = xml.@value;
		return (str.toLowerCase() == "true");
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = combo.getSelectedItem();
		return xml;
	}
	
	public function getCodeLines(value:*):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*):String{
		return value+"";
	}
	
}
}