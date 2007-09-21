package org.aswing.guibuilder.model{

import org.aswing.util.HashMap;	

/**
 * Definition manager
 * @author iiley
 */
public class Definition{
	
	public static const TAG_COM:String = "Com";
	
	private static var ins:Definition;
	
	public static function getIns():Definition{
		if(ins == null){
			new Definition();
		}
		return ins;
	}
	
	private var protypes:HashMap;
	private var components:HashMap;
	private var orderComponents:Array;
	
	public function Definition(){
		if(ins){
			throw new Error("Sington can't be instant more than once!");
		}
		ins = this;
		protypes = new HashMap();
		components = new HashMap();
		orderComponents = new Array();
	}
	
	public function init(xml:XML):void{
		//generate property types
		var typexml:* = xml.Types.Type;
		for each(var type:XML in typexml){
			var t:ProTypeDefinition = new ProTypeDefinition(type);
			protypes.put(t.getName(), t);
		}
		
		//generate components
		var baseCom:ComDefinition = new ComDefinition(xml.Components.BaseComponent, null);
		var baseCon:ComDefinition = new ComDefinition(xml.Components.BaseContainer, baseCom);
		components.put(baseCom.getName(), baseCom);
		components.put(baseCon.getName(), baseCon);
		
		var comxml:* = xml.Components.Com;
		for each(var cc:XML in comxml){
			var superName:String = cc.@sup;
			var c:ComDefinition = new ComDefinition(cc, getComDefinition(superName));
			components.put(c.getName(), c);
			if(cc.name() == TAG_COM){
				orderComponents.push(c);
			}
		}
	}
	
	public function getComDefinition(name:String):ComDefinition{
		return components.getValue(name);
	}
	
	public function getProTypeDefinition(type:String):ProTypeDefinition{
		return protypes.getValue(type);
	}
	
	/**
	 * Returns ComDefinition[]
	 */
	public function getComponents():Array{
		return orderComponents.concat();
	}
	
	/**
	 * Returns LayoutDefinition[]
	 */
	public function getLayouts():Array{
		
	}
}
}