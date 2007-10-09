package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JTextField;
import flash.events.Event;
import org.aswing.event.AWEvent;
import org.aswing.guibuilder.model.ProModel;

public class StringEditor extends BasePropertyEditor implements PropertyEditor{
	
	private var text:JTextField;
	
	public function StringEditor(){
		text = new JTextField("", 8);
		text.addActionListener(__apply);
		text.addEventListener(AWEvent.FOCUS_LOST, __apply);
	}
		
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		if(noValueSet){
			text.setText("");
		}else{
			text.setText(v);
		}
	}
	
	override protected function getEditorValue():*{
		var label:String = text.getText();
		if(label != null && label != ""){
			return label;
		}else{
			return ProModel.NONE_VALUE_SET;
		}
	}
	
	public function getDisplay():Component{
		return text;
	}
}
}