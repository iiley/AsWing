package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.geom.IntPoint;

public class IntPointSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML):*{
		var str:String = xml.@value;
		var strs:Array = str.split(",");
		return new IntPoint(MathUtils.parseInteger(strs[0]), MathUtils.parseInteger(strs[1]));
	}
	
	public function encodeValue(value:*):XML{
		var p:IntPoint = value;
		var xml:XML = <Value></Value>;
		xml.@value = p.x + "," + p.y;
		return xml;
	}
	
	public function getCodeLines(value:*):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*):String{
		var p:IntPoint = value;
		return "new IntPoint(" + p.x + ", " + p.y + ")";
	}
	
}
}