package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.geom.IntPoint;
import org.aswing.JPanel;
import org.aswing.SoftBoxLayout;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.guibuilder.model.ProModel;
import flash.events.Event;
import org.aswing.event.AWEvent;

/**
 * IntPoint editor
 */
public class IntPointEditor implements PropertyEditor{
	
	private var pane:JPanel;
	private var xInput:LabelInput;
	private var yInput:LabelInput;
	
	public function IntPointEditor(){
		pane = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		xInput = new IntInput("x:", "", 0, 4);
		yInput = new IntInput("y:", "", 0, 4);
		pane.appendAll(xInput, yInput);
		xInput.addEventListener(AWEvent.ACT, __apply);
		yInput.addEventListener(AWEvent.ACT, __apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function getDisplay():Component{
		return pane;
	}
	
	public function parseValue(xml:XML):*{
		var str:String = xml.@value;
		var strs:Array = str.split(",");
		xInput.setInputText(strs[0]);
		xInput.setInputText(strs[1]);
		return new IntPoint(MathUtils.parseInteger(strs[0]), MathUtils.parseInteger(strs[1]));
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = xInput.getInputInt()+","+yInput.getInputInt();
		return xml;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(xInput.isEmpty() || yInput.isEmpty()){
			apply(ProModel.NONE_VALUE_SET);
			return;
		}
		apply(new IntPoint(xInput.getInputInt(), yInput.getInputInt()));
	}
	
}
}