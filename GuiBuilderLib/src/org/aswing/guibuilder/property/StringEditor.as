package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JTextField;

public class StringEditor implements PropertyEditor{
	
	private var text:JTextField;
	
	public function StringEditor(){
		text = new JTextField("", 8);
		text.setMaxChars(32);
	}
	
	public function getDisplay():Component{
		return text;
	}
	
	public function applyProperty(apply:Function):void{
		var label:String = text.getText();
		if(label != null && label != ""){
			apply(label);
		}
	}
	
}
}