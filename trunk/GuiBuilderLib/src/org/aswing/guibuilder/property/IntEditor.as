package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JTextField;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.event.AWEvent;
import flash.events.Event;
import org.aswing.event.FocusKeyEvent;
import flash.ui.Keyboard;

public class IntEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var text:IntInput;
	
	public function IntEditor(){
		text = new IntInput("", "", 0, 6);
		text.addEventListener(AWEvent.ACT, __apply);
	}
		
	public function getDisplay():Component{
		return text;
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		if(noValueSet){
			text.setInputText("");
		}else{
			text.setInputText(v+"");
		}
	}	
	
	override protected function getEditorValue():*{
		if(text.isEmpty()){
			return ProModel.NONE_VALUE_SET;
		}
		return text.getInputInt();
	}
}
}