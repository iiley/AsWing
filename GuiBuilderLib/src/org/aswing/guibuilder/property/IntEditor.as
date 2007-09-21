package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JTextField;

public class IntEditor implements PropertyEditor{
	
	private var text:JTextField;
	
	public function IntEditor(){
		text = new JTextField("", 6);
		text.setMaxChars(8);
		text.setRestrict("0123456789");
	}
	
	public function getDisplay():Component{
		return text;
	}
	
	public function parseValue(str:String):*{
		text.setText(str);
		return parseInt(str);
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		var label:String = text.getText();
		if(label != null && label != ""){
			var value:int = parseInt(label);
			apply(value);
		}
	}
	
}
}