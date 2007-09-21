package org.aswing.guibuilder.model{

import org.aswing.*;
import org.aswing.util.Vector;	

/**
 * Component Model
 * @author iiley
 */
public class ComModel{
	
	public static const ID_NAME:String = "id";
	
	private static var id_counter:int = 0;
	
	private var def:ComDefinition;
	private var display:Component;
	private var children:Vector;
	private var properties:Vector;
	private var container:Boolean;
	private var parent:ComModel;
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
		
		initProModels();
	}
	
	private function initProModels():void{
		for(var i:int=0; i<properties.size(); i++){
			var pro:ProModel = properties.get(i);
			pro.bindTo(this);
		}
	}
	
	public function applyProperty(name:String, value:*, action:String):void{
		if(name == ID_NAME){
			//TODO change id
			return;
		}
		var o:Object = getDisplay();
		o["set"+name](value);
		if(action != null && action != ""){
			o[action]();
		}
	}
	
	public function getDisplay():Component{
		return display;
	}
	
	public function getParent():ComModel{
		return parent;
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
			mod.parent = this;
		}else{
			throw new Error("This is not a container, can add child!");
		}
	}
	
	public function removeChild(mod:ComModel):ComModel{
		if(!isContainer()){
			throw new Error("This is not a container, does not have child!");
		}
		if(mod.parent == this){
			children.remove(mod);
			mod.parent = null;
			return mod;
		}
		return null;
	}
	
	public function isContainer():Boolean{
		return container;
	}
	
	public function toString():String{
		return id + "-[" + def.getName() + "]";
	}
}
}