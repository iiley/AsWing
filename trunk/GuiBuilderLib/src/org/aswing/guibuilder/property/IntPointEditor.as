package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.geom.IntPoint;
import org.aswing.JPanel;
import org.aswing.SoftBoxLayout;

/**
 * IntPoint editor
 */
public class IntPointEditor implements PropertyEditor{
	
	private var pane:JPanel;
	private var xInput:LabelInput;
	private var yInput:LabelInput;
	
	public function IntPointEditor(){
		pane = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		xInput = new LabelInput("x:", "", 0, 4);
		yInput = new LabelInput("y:", "", 0, 4);
		pane.appendAll(xInput, yInput);
	}
	
	public function getDisplay():Component{
		return pane;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(xInput.isEmpty() || yInput.isEmpty()){
			return;
		}
		apply(new IntPoint(xInput.getInputInt(), yInput.getInputInt()));
	}
	
}
}