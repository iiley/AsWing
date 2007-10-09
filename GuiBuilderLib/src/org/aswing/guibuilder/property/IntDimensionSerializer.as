package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.geom.IntDimension;

public class IntDimensionSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML):*{
		var str:String = xml.@value;
		var strs:Array = str.split(",");
		var dim:IntDimension = new IntDimension(MathUtils.parseInteger(strs[0]), MathUtils.parseInteger(strs[1]));
		return dim;
	}
	
	public function encodeValue(value:*):XML{
		var dim:IntDimension = value;
		var xml:XML = <Value></Value>;
		xml.@value = dim.width + "," + dim.height;
		return xml;
	}
	
	public function getCodeLines(value:*):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*):String{
		var dim:IntDimension = value;
		return "new IntDimension(" + dim.width 
				+ ", " + dim.height + ")";
	}
	
}
}