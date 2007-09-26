package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JTextField;
import flash.events.Event;
import org.aswing.event.AWEvent;
import org.aswing.guibuilder.model.ProModel;

public class StringEditor implements PropertyEditor{
	
	private var text:JTextField;
	
	public function StringEditor(){
		text = new JTextField("", 8);
		text.addActionListener(__apply);
		text.addEventListener(AWEvent.FOCUS_LOST, __apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function parseValue(xml:XML):*{
		var str:String = xml.@value;
		text.setText(str);
		return str;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = value+"";
		return xml;
	}
	
	public function getDisplay():Component{
		return text;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		var label:String = text.getText();
		if(label != null && label != ""){
			apply(label);
		}else{
			apply(ProModel.NONE_VALUE_SET);
		}
	}
	
}
}