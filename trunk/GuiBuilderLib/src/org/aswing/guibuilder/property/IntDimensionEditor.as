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

public class IntDimensionEditor extends BasePropertyEditor implements PropertyEditor{
	
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
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		if(noValueSet){
			widthInput.setInputText("");
			heightInput.setInputText("");
		}else{
			var dim:IntDimension = v;
			widthInput.setInputText(dim.width+"");
			heightInput.setInputText(dim.height+"");
		}
	}	
	
	override protected function getEditorValue():*{
		if(widthInput.isEmpty() || heightInput.isEmpty()){
			return ProModel.NONE_VALUE_SET;
		}
		return new IntDimension(widthInput.getInputInt(), heightInput.getInputInt());
	}
}
}