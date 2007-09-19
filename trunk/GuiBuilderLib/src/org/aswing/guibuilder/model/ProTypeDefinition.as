package org.aswing.guibuilder.model{

import org.aswing.util.Reflection;	

/**
 * Property Type Definition
 * @author iiley
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