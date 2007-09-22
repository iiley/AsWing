package org.aswing.guibuilder.model{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.util.Reflection;	

/**
 * Property Definition
 * @author iiley
 */
public class ProDefinition{
	
	private var xml:XML;
	private var name:String;
	private var label:String;
	private var type:String;
	private var action:String;
	private var defaultValue:XMLList;
	
	public function ProDefinition(xml:XML){
		this.xml = xml;
		label = xml.@label;
		name = xml.@name;
		type = xml.@type;
		action = xml.@action;
		defaultValue = xml.Value;
	}
	
	public function getName():String{
		return name;
	}
	
	public function getLabel():String{
		return label;
	}
	
	public function getDefaultValue():XMLList{
		return defaultValue;
	}
	
	public function getAction():String{
		return action;
	}
	
	public function getEditorClass():Class{
		return Definition.getIns().getProTypeDefinition(type).getEditorClass();
	}
	
}
}