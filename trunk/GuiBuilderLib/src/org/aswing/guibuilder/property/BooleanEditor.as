package org.aswing.guibuilder.property{
	
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JCheckBox;
import org.aswing.JComboBox;
import flash.events.Event;

public class BooleanEditor implements PropertyEditor{
	
	protected var combo:JComboBox;
	
	public function BooleanEditor(){
		combo = new JComboBox(["None", "true", "false"]);
		combo.addActionListener(__apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function getDisplay():Component{
		return combo;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(combo.getSelectedIndex() > 0){
			apply(combo.getSelectedIndex() == 1);
		}
	}
	
}
}