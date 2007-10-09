package org.aswing.guibuilder.property{
	
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JCheckBox;
import org.aswing.JComboBox;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;

public class BooleanEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var combo:JComboBox;
	
	public function BooleanEditor(){
		combo = new JComboBox(["Default", "true", "false"]);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
	}
	
	public function getDisplay():Component{
		return combo;
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		var index:int = 0;
		if(!noValueSet){
			if(v){
				index = 1;
			}else{
				index = 2;
			}
		}
		combo.setSelectedIndex(index);
	}	
	
	override protected function getEditorValue():*{
		if(combo.getSelectedIndex() <= 0){
			return ProModel.NONE_VALUE_SET;
		}else{
			return combo.getSelectedIndex() == 1;
		}
	}
	
}
}