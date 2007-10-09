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
		combo.addActionListener(__apply);
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		if(noValueSet){
			v = "";
		}
		combo.setSelectedItem(v);
	}	
	
	override protected function getEditorValue():*{
		var value:* = combo.getSelectedItem();
		if(value == null || value == ""){
			return ProModel.NONE_VALUE_SET;
		}else{
			return value;
		}
	}
	
	public function getDisplay():Component{
		return combo;
	}	
}
}