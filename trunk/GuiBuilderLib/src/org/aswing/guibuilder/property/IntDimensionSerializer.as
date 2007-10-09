package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.geom.IntDimension;
import org.aswing.guibuilder.model.ProModel;

public class IntDimensionSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):*{
		var str:String = xml.@value;
		var strs:Array = str.split(",");
		var dim:IntDimension = new IntDimension(MathUtils.parseInteger(strs[0]), MathUtils.parseInteger(strs[1]));
		return dim;
	}
	
	public function encodeValue(value:*, pro:ProModel):XML{
		var dim:IntDimension = value;
		var xml:XML = <Value></Value>;
		xml.@value = dim.width + "," + dim.height;
		return xml;
	}
	
	public function getCodeLines(value:*, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:*, pro:ProModel):String{
		var dim:IntDimension = value;
		return "new IntDimension(" + dim.width 
				+ ", " + dim.height + ")";
	}
	
}
}