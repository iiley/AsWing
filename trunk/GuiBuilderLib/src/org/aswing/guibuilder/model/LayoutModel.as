package org.aswing.guibuilder.model{

import org.aswing.util.Vector;
import org.aswing.*;

/**
 * Layout Model
 * @author iiley
 */
public class LayoutModel implements Model{
	
	private var def:LayoutDefinition;
	private var properties:Vector;
	private var layout:LayoutManager;
	
	public function LayoutModel(def:LayoutDefinition=null){
		if(def != null){
			init(def);
		}
	}
	
	private function init(def:LayoutDefinition):void{
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
	
	public function parse(xml:*):void{
		var name:String = xml.@name;
		var ldef:LayoutDefinition = Definition.getIns().getLayoutDefinition(name);
		init(ldef);
		//properties
		var proxmls:* = xml.Properties.Property;
		for each(var proxml:* in proxmls){
			var pname:String = proxml.@name;
			var pro:ProModel = getPropertyModel(pname);
			if(pro){
				pro.parse(proxml);
			}
		}
	}
	
	public function encodeXML():XML{
		var xml:XML = <Layout></Layout>;
		xml.@name = getName();
		//properties
		var proXml:XML = <Properties></Properties>;
		xml.appendChild(proXml);
		var n:int = properties.size();
		for(var i:int=0; i<n; i++){
			var pro:ProModel = properties.get(i);
			var pxml:XML = pro.encodeXML();
			if(pxml != null){
				proXml.appendChild(pxml);
			}
		}
		return xml;
	}
	
	private function getPropertyModel(name:String):ProModel{
		var n:int = properties.size();
		for(var i:int=0; i<n; i++){
			var pro:ProModel = properties.get(i);
			if(pro.getName() == name){
				return pro;
			}
		}
		return null;
	}	
	
	public function getLayout():LayoutManager{
		return layout;
	}
	
	public function getDef():LayoutDefinition{
		return def;
	}
	
	public function getName():String{
		return def.getName();
	}
	
	/**
	 * ProModel[]
	 */
	public function getProperties():Array{
		return properties.toArray();
	}
	
	public function captureProperty(name:String):*{
		var o:Object = getLayout();
		var v:* = undefined;
		try{
			v = o["get"+name]();
		}catch(e:Error){
			try{
				v = o["is"+name]();
			}catch(e:Error){}
		}
		return v;
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