package org.aswing.guibuilder.model{

import org.aswing.util.Vector;
import org.aswing.util.Reflection;	

/**
 * Aggregation class model definition.
 * @author iiley
 */
public class AbsAggDefinition{
	
	protected var xml:*;
	protected var name:String;
	protected var className:String;
	protected var clazz:Class;
	protected var superDef:AbsAggDefinition;
	protected var properties:Vector;
	
	public function AbsAggDefinition(xml:*, superDef:AbsAggDefinition){
		this.xml = xml;
		this.superDef = superDef;
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
	
	public function getClassName():String{
		return className;
	}
	
	public function getSuperDefinition():AbsAggDefinition{
		return superDef;
	}
	
	public function getClass():Class{
		return clazz;
	}
	
	/**
	 * ProDefinition[]
	 */
	public function getProperties():Array{
		return properties.toArray();
	}
		
}
}