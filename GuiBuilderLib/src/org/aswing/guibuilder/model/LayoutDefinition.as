package org.aswing.guibuilder.model{

import org.aswing.util.Vector;
import org.aswing.util.Reflection;	

/**
 * Layout Definition
 */
public class LayoutDefinition{
	
	private var name:String;
	private var clazz:Class;
	private var className:String;
	private var superDef:LayoutDefinition;
	private var properties:Vector;
	
	public function LayoutDefinition(xml:*, superDef:LayoutDefinition){
		name = xml.@name;
		className = xml.@clazz;
		clazz = Reflection.getClass(className);
		
		properties = new Vector();
		if(superDef){
			properties.appendAll(superDef.getProperties());
		}
		var proxml:* = xml.Property;
		for each(var node:* in proxml){
			addProDef(new ProDefinition(node));
		}
	}
	
	private function addProDef(def:ProDefinition):void{
		for(var i:int=properties.size()-1; i>=0; i--){
			var pro:ProDefinition = properties.get(i);
			if(pro.getName() == def.getName()){
				properties.setElementAt(i, def); //replace super define
				return;
			}
		}
		properties.append(def);
	}
	
	public function getName():String{
		return name;
	}
	
	public function getSuperDefinition():LayoutDefinition{
		return superDef;
	}
	
	/**
	 * 
	 */
	public function getClass():Class{
		return clazz;
	}
	
	public function getClassName():String{
		return className;
	}
	
	/**
	 * ProDefinition[]
	 */
	public function getProperties():Array{
		return properties.toArray();
	}
	
	public function toString():String{
		return "LayoutDefintion[name:" + getName() + "]"
	}
}
}