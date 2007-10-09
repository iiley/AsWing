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
public class IntPointEditor extends BasePropertyEditor implements PropertyEditor{
	
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
	
	public function getDisplay():Component{
		return pane;
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		if(noValueSet){
			xInput.setInputText("");
			yInput.setInputText("");
		}else{
			var p:IntPoint = v;
			xInput.setInputText(p.x+"");
			yInput.setInputText(p.y+"");
		}
	}	
	
	override protected function getEditorValue():*{
		if(xInput.isEmpty() || yInput.isEmpty()){
			return ProModel.NONE_VALUE_SET;
		}
		return new IntPoint(xInput.getInputInt(), yInput.getInputInt());
	}
}
}