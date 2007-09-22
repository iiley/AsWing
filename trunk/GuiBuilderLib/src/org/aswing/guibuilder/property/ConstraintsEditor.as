package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JComboBox;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;

public class ConstraintsEditor implements PropertyEditor{
	
	private var combo:JComboBox;
	
	public function ConstraintsEditor(){
		combo = new JComboBox(["Center", "North", "South", "East", "West"]);
		combo.setEditable(true);
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