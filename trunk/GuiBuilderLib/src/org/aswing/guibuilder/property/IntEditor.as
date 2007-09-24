package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JTextField;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.event.AWEvent;
import flash.events.Event;

public class IntEditor implements PropertyEditor{
	
	private var text:JTextField;
	
	public function IntEditor(){
		text = new JTextField("", 6);
		text.setMaxChars(8);
		text.setRestrict("0123456789");
		text.addActionListener(__apply);
		text.addEventListener(AWEvent.FOCUS_LOST, __apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}	
	
	public function getDisplay():Component{
		return text;
	}
		
	public function parseValue(xml:XML):*{
		text.setText(xml.@value);
		return MathUtils.parseInteger(xml.@value);
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = text.getText();
		return xml;
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
		}else{
			apply(ProModel.NONE_VALUE_SET);
		}
	}
	
}
}