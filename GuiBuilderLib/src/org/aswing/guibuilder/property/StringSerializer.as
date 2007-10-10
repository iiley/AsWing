package org.aswing.guibuilder.property{

import org.aswing.guibuilder.DefaultValueHelper;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ProModel;

public class StringSerializer implements PropertySerializer, DefaultValueHelper{
	
	public function decodeValue(valueXML:XML, pro:ProModel):*{
		return valueXML.@value+"";
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
		return "\"" + value + "\"";
	}
	
	public function getDefaultValue(propertyName:String, model:Model):*{
		if(model is ComModel && propertyName == ComModel.ID_NAME){
			return ComModel(model).getID();
		}else{
			throw new Error("It is not default value helped!");
			return null;
		}
	}
	
	public function isNeedHelp(propertyName:String, model:Model):Boolean{
		if(model is ComModel && propertyName == ComModel.ID_NAME){
			return true;
		}
		return false;
	}
}
}