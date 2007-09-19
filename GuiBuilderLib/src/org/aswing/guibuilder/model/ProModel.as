package org.aswing.guibuilder.model{

import org.aswing.guibuilder.PropertyEditor;	

/**
 * 属性模型
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
	
	public function getEditor():PropertyEditor{
		return editor;
	}
}
}