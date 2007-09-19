package org.aswing.guibuilder.model{

import org.aswing.util.Reflection;
import org.aswing.Container;
import org.aswing.util.Vector;	

/**
 * Component definition
 * @author iiley
 */
public class ComDefinition{
	
	private var xml:XML;
	private var name:String;
	private var clazz:Class;
	private var container:Boolean;
	private var superDef:ComDefinition;
	private var properties:Vector;
	
	public function ComDefinition(xml:XML, superDef:ComDefinition){
		this.xml = xml;
		this.superDef = superDef;
		name = xml.@name;
		clazz = Reflection.getClass(xml.@clazz);
		
		var c:ComDefinition = this;
		while(c != null){
			if(c.getClass() == Container){
				container = true;
				break;
			}
			c = c.getSuperDefinition();
		}
		
		properties = new Vector();
		if(superDef){
			properties.appendAll(superDef.getProperties());
		}
		var proxml:* = xml.Property;
		for each(var node:* in proxml){
			properties.append(new ProDefinition(node));
		}
	}
	
	public function getName():String{
		return name;
	}
	
	public function getSuperDefinition():ComDefinition{
		return superDef;
	}
	
	/**
	 * 
	 */
	public function getClass():Class{
		return clazz;
	}
	
	/**
	 * ProDefinition[]
	 */
	public function getProperties():Array{
		return properties.toArray();
	}
	
	/**
	 * Return whether this component can has children.
	 */
	public function isContainer():Boolean{
		return container;
	}
}
}