package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.LayoutModel;

public class LayoutSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):*{
		var model:LayoutModel;
		if(pro.getValueModel() != null){
			model = pro.getValueModel();
		}else{
			model = new LayoutModel();
		}
		model.parse(xml.children()[0]);
		return model.getLayout();
	}
	
	public function encodeValue(value:*, pro:ProModel):XML{
		var model:LayoutModel = pro.getValueModel();
		var layoutDef:LayoutDefinition = model.getDef();
		var xml:XML = <Value></Value>;
		xml.appendChild(model.encodeXML());
		return xml;
	}
	
	public function getCodeLines(value:*, pro:ProModel):Array{
		var layoutModel:LayoutModel = pro.getValueModel();
		var id:String = "layout" + (CodeGenerator.border_id_counter++);
		var clazz:String = layoutModel.getDef().getShortClassName();
		var arr:Array = [];
		arr.push("var " + id + ":" + clazz + " = new " + clazz + "();");
		var pros:Array = layoutModel.getProperties();
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