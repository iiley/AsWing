package org.aswing.guibuilder.model{

import org.aswing.util.Reflection;	

/**
 * 属性类型定义
 */
public class ProTypeDefinition{
	
	private var name:String;
	private var editorClass:Class;
	
	public function ProTypeDefinition(xml:XML){
		name = xml.@name;
		editorClass = Reflection.getClass(xml.@editor);
	}
	
	public function getName():String{
		return name;
	}
	
	public function getEditorClass():Class{
		return editorClass;
	}
}
}