package org.aswing.guibuilder.model{

import org.aswing.guibuilder.PropertyEditor;	

/**
 * Property Model
 * @author iiley
 */
public class ProModel{
	
	private var def:ProDefinition;
	private var editor:PropertyEditor;
	private var comModel:ComModel;
	
	public function ProModel(def:ProDefinition){
		this.def = def;
		var clazz:Class = def.getEditorClass();
		editor = new clazz();
		editor.setApplyFunction(__apply);
	}
	
	private function __apply(v:*):void{
		comModel.applyProperty(def.getProName(), v, def.getAction());
	}
	
	public function bindTo(c:ComModel):void{
		comModel = c;
		if(def.getDefaultValue() != ""){
			var v:* = editor.parseValue(def.getDefaultValue());
			__apply(v);
		}
	}
	
	public function getName():String{
		return def.getName();
	}
	
	public function getEditor():PropertyEditor{
		return editor;
	}
}
}