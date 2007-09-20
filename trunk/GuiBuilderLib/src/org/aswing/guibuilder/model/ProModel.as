package org.aswing.guibuilder.model{

import org.aswing.guibuilder.PropertyEditor;	

/**
 * Property Model
 * @author iiley
 */
public class ProModel{
	
	private var def:ProDefinition;
	private var editor:PropertyEditor;
	
	public function ProModel(def:ProDefinition){
		this.def = def;
		var clazz:Class = def.getEditorClass();
		editor = new clazz();
	}
	
	public function getName():String{
		return def.getName();
	}
	
	public function getEditor():PropertyEditor{
		return editor;
	}
}
}