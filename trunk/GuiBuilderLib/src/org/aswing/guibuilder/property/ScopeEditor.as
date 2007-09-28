package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.*;
import org.aswing.guibuilder.model.ComModel;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;

public class ScopeEditor implements PropertyEditor{
		
	private var combo:JComboBox;
	
	public function ScopeEditor(param:String=null){
		if(param == "none-enabled"){
			combo = new JComboBox([
								ComModel.SCOPE_PUBLIC, 
								ComModel.SCOPE_PRIVATE, 
								ComModel.SCOPE_PROTECTED, 
								ComModel.SCOPE_NONE]);
		}else{
			combo = new JComboBox([
								ComModel.SCOPE_PUBLIC, 
								ComModel.SCOPE_PRIVATE, 
								ComModel.SCOPE_PROTECTED]);
		}
		combo.setPreferredWidth(70);
		combo.addActionListener(__selection);
	}
	
	private function __selection(e:Event):void{
		applyProperty();
	}
	
	public function getDisplay():Component{
		return combo;
	}
	
	public function parseValue(xml:XML):*{
		combo.setSelectedItem(xml.@value);
		return xml.@value;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = value+"";
		return xml;
	}
	
	public function getCodeLines():Array{
		return null;
	}
	
	public function isSimpleOneLine():String{
		return combo.getSelectedItem()+"";
	}	
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(combo.getSelectedItem() == null){
			apply(ProModel.NONE_VALUE_SET);
		}else{
			apply(combo.getSelectedItem());
		}
	}
	
}
}