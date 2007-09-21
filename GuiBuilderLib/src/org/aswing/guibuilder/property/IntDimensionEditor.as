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

public class IntDimensionEditor implements PropertyEditor{
	
	protected var pane:JPanel;
	protected var widthInput:LabelInput;
	protected var heightInput:LabelInput;
	
	public function IntDimensionEditor(){
		pane = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		widthInput = new LabelInput("w:", "", 0, 4);
		heightInput = new LabelInput("h:", "", 0, 4);
		pane.appendAll(widthInput, heightInput);
		widthInput.addEventListener(AWEvent.ACT, __apply);
		heightInput.addEventListener(AWEvent.ACT, __apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function parseValue(str:String):*{
		var strs:Array = str.split(",");
		var dim:IntDimension = new IntDimension(parseInt(strs[0]), parseInt(strs[1]));
		widthInput.setInputText(strs[0]);
		heightInput.setInputText(strs[1]);
		return dim;
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
			return;
		}
		apply(new IntDimension(widthInput.getInputInt(), heightInput.getInputInt()));
	}
	
}
}