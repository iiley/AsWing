package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ProModel;

public class BooleanSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):*{
		var str:String = valueXML.@value;
		return (str.toLowerCase() == "true");
	}
	
	public function encodeValue(value:*, pro:ProModel):XML{
		var xml:XML = <Value></Value>;
		xml.@value = value+"";
		return xml;
	}
	
	public function getCodeLines(value:*, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*, pro:ProModel):String{
		return value+"";
	}
	
}
}