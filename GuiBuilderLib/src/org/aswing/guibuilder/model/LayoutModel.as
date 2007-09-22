package org.aswing.guibuilder.model{

import org.aswing.LayoutManager;
import org.aswing.util.Vector;
import org.aswing.LayoutManager;	

/**
 * Layout Model
 * @author iiley
 */
public class LayoutModel implements Model{
	
	private var def:LayoutDefinition;
	private var properties:Vector;
	private var layout:LayoutManager;
	
	public function LayoutModel(def:LayoutDefinition){
		this.def = def;
		properties = new Vector();
		var pros:Array = def.getProperties();
		for(var i:int=0; i<pros.length; i++){
			properties.append(new ProModel(pros[i]));
		}
		
		var clazz:Class = def.getClass();
		layout = new clazz();
		for(i=0; i<properties.size(); i++){
			var pro:ProModel = properties.get(i);
			pro.bindTo(this);
		}
	}
	
	public function getLayout():LayoutManager{
		return layout;
	}
	
	public function getProperties():Array{
		return properties.toArray();
	}
	
	public function applyProperty(name:String, value:*, action:String):void{
		var o:Object = getLayout();
		o["set"+name](value);
		if(action != null && action != ""){
			o[action]();
		}
	}
	
	public function toString():String{
		return def.getName();
	}
}
}