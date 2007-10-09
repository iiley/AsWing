package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.*;

public class BorderSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):*{
		var model:BorderModel;
		if(pro.getValueModel() != null){
			model = pro.getValueModel();
		}else{
			model = new BorderModel();
		}
		model.parse(xml.children()[0]);
		return model.getBorder();
	}
	
	public function encodeValue(value:*, pro:ProModel):XML{
		var xml:XML = <Value></Value>;
		if(value == null){
			xml.@value="null";
			return xml;
		}
		var model:BorderModel = pro.getValueModel();
		var borderDef:BorderDefinition = model.getDef();
		xml.appendChild(model.encodeXML());
		return xml;
	}
	
	public function getCodeLines(value:*, pro:ProModel):Array{
		var borderModel:BorderModel = pro.getValueModel();
		var id:String = "border" + (CodeGenerator.border_id_counter++);
		var clazz:String = borderModel.getDef().getShortClassName();
		var arr:Array = [];
		arr.push("var " + id + ":" + clazz + " = new " + clazz + "();");
		var pros:Array = borderModel.getProperties();
		for each(var pro:ProModel in pros){
			var simple:String = pro.isSimpleOneLine();
			if(simple != null){
				arr.push(id + ".set" + pro.getName() + "(" + simple + ");");
			}else{
				var proCodeLines:Array = pro.getCodeLines();
				if(proCodeLines != null){
					var n:int = proCodeLines.length - 1;
					for(var i:int=0; i<n; i++){
						arr.push(proCodeLines[i]);
					}
					arr.push(id + ".set" + pro.getName() + "(" + proCodeLines[n] + ");");
				}
			}
		}
		arr.push(id);
		return arr;
	}
	
	public function isSimpleOneLine(value:*, pro:ProModel):String{
		return null;
	}
	
}
}