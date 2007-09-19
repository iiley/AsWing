package org.aswing.guibuilder.model{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.util.Reflection;	

/**
 * 属性定义
 * @author iiley
 */
public class ProDefinition{
	
	private var xml:XML;
	private var name:String;
	private var proName:String;
	private var type:String;
	private var action:String;
	
	public function ProDefinition(xml:XML){
		this.xml = xml;
		name = xml.@name;
		proName = xml.@property;
		type = xml.@type;
		action = xml.@action;
	}
	
	public function getName():String{
		return name;
	}
	
	public function getProName():String{
		return proName;
	}
	
	public function getAction():String{
		return action;
	}
	
	public function getEditorClass():Class{
		return Definition.getIns().getProTypeDefinition(type).getEditorClass();
	}
	
}
}