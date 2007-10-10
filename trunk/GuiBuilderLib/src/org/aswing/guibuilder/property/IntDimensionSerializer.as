package org.aswing.guibuilder.property{

import org.aswing.geom.IntDimension;
import org.aswing.guibuilder.DefaultValueHelper;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.util.MathUtils;

public class IntDimensionSerializer implements PropertySerializer, DefaultValueHelper{
	
	public function decodeValue(valueXML:XML, pro:ProModel):*{
		var str:String = valueXML.@value;
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
	
	public function getDefaultValue(propertyName:String, model:Model):*{
		if(model is ComModel && propertyName == "PreferSize"){
			return null;
		}else{
			throw new Error("It is not default value helped!");
			return null;
		}
	}
	
	public function isNeedHelp(propertyName:String, model:Model):Boolean{
		if(model is ComModel && propertyName == "PreferSize"){
			return true;
		}
		return false;
	}
}
}