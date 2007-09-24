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

public class IntEditor implements PropertyEditor{
	
	private var text:IntInput;
	
	public function IntEditor(){
		text = new IntInput("", "", 0, 6);
		text.addEventListener(AWEvent.ACT, __apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function getDisplay():Component{
		return text;
	}
		
	public function parseValue(xml:XML):*{
		text.setInputText(xml.@value);
		return MathUtils.parseInteger(xml.@value);
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = text.getInputInt();
		return xml;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(!text.isEmpty()){
			apply(text.getInputInt());
		}else{
			apply(ProModel.NONE_VALUE_SET);
		}
	}
	
}
}