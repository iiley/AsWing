package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JButton;
import org.aswing.JPanel;
import org.aswing.JTextField;
import org.aswing.SoftBoxLayout;
import org.aswing.geom.IntDimension;
import org.aswing.event.AWEvent;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.util.MathUtils;

public class IntDimensionEditor implements PropertyEditor{
	
	protected var pane:JPanel;
	protected var widthInput:LabelInput;
	protected var heightInput:LabelInput;
	
	public function IntDimensionEditor(){
		pane = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		widthInput = new IntInput("w:", "", 0, 4);
		heightInput = new IntInput("h:", "", 0, 4);
		pane.appendAll(widthInput, heightInput);
		widthInput.addEventListener(AWEvent.ACT, __apply);
		heightInput.addEventListener(AWEvent.ACT, __apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function parseValue(xml:XML):*{
		var str:String = xml.@value;
		var strs:Array = str.split(",");
		var dim:IntDimension = new IntDimension(MathUtils.parseInteger(strs[0]), MathUtils.parseInteger(strs[1]));
		widthInput.setInputText(strs[0]);
		heightInput.setInputText(strs[1]);
		return dim;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = widthInput.getInputInt() + "," + heightInput.getInputInt();
		return xml;
	}	
	
	public function getDisplay():Component{
		return pane;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(widthInput.isEmpty() || heightInput.isEmpty()){
			apply(ProModel.NONE_VALUE_SET);
			return;
		}
		apply(new IntDimension(widthInput.getInputInt(), heightInput.getInputInt()));
	}
	
}
}