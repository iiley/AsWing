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

public class NumberEditor extends BasePropertyEditor implements PropertyEditor{

	protected var text:NumberInput;
	private var min:Number;
	private var max:Number;
	
	public function NumberEditor(){
		text = new NumberInput("", "", 0, 6);
		text.addEventListener(AWEvent.ACT, __apply);
	}
	
	override public function setEditorParam(param:String):void{
		if(param == "" || param == null){
			text.setMinMax(Number.MIN_VALUE, Number.MAX_VALUE);
		}else{
			var strs:Array = param.split(",");
			min = MathUtils.parseNumber(strs[0]);
			max = MathUtils.parseNumber(strs[1]);
			text.setMinMax(min, max);
		}
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
		return text.getInputNumber();
	}
}
}