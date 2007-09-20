package org.aswing.guibuilder.model{

import org.aswing.*;
import org.aswing.util.Vector;	

/**
 * Component Model
 * @author iiley
 */
public class ComModel{
	
	private static var id_counter:int = 0;
	
	private var def:ComDefinition;
	private var display:Component;
	private var children:Vector;
	private var properties:Vector;
	private var container:Boolean;
	private var id:String;
	
	public function ComModel(def:ComDefinition=null){
		if(def != null){
			create(def);
		}
		id = "com" + id_counter;
		id_counter++;
	}
	
	public function create(def:ComDefinition):void{
		this.def = def;
		children = new Vector();
		properties = new Vector();
		var clazz:Class = def.getClass();
		display = new clazz();
		container = def.isContainer();
		
		var pros:Array = def.getProperties();
		for(var i:int=0; i<pros.length; i++){
			properties.append(new ProModel(pros[i]));
		}
	}
	
	public function getDisplay():Component{
		return display;
	}
	
	/**
	 * ComModel[]
	 */
	public function getChildren():Array{
		return children.toArray();
	}
	
	public function getChild(index:int):ComModel{
		return children.get(index);
	}
	
	public function getChildCount():int{
		return children.size();
	}
	
	public function getChildIndex(child:*):int{
		return children.indexOf(child);
	}
	
	/**
	 * ProModel[]
	 */	
	public function getProperties():Array{
		return properties.toArray();
	}
		
	public function addChild(mod:ComModel, index:int=-1):void{
		if(isContainer()){
			children.append(mod, index);
			var con:Container = display as Container;
			con.insert(index, mod.getDisplay());
		}else{
			throw new Error("This is not a container, can add child!");
		}
	}
	
	public function isContainer():Boolean{
		return container;
	}
	
	public function toString():String{
		return id + "-[" + def.getName() + "]";
	}
}
}