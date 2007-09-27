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

public class NumberEditor implements PropertyEditor{

	protected var text:NumberInput;
	private var min:Number;
	private var max:Number;
	
	public function NumberEditor(param:String=null){
		text = new NumberInput("", "", 0, 6);
		text.addEventListener(AWEvent.ACT, __apply);
		if(param != null){
			var strs:Array = param.split(",");
			min = MathUtils.parseNumber(strs[0]);
			max = MathUtils.parseNumber(strs[1]);
			text.setMinMax(min, max);
		}
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function getDisplay():Component{
		return text;
	}
		
	public function parseValue(xml:XML):*{
		text.setInputText(xml.@value);
		return MathUtils.parseNumber(xml.@value);
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = text.getInputNumber();
		return xml;
	}

	public function getCodeLines():Array{
		return null;
	}
	
	public function isSimpleOneLine():String{
		return text.getInputNumber()+"";
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(!text.isEmpty()){
			apply(text.getInputNumber());
		}else{
			apply(ProModel.NONE_VALUE_SET);
		}
	}
	
}
}