package org.aswing.guibuilder.property{

import flash.events.Event;

import org.aswing.JCheckBox;
import org.aswing.geom.IntDimension;
import org.aswing.guibuilder.model.ProModel;

public class PreferSizeEditor extends IntDimensionEditor{
	
	private var check:JCheckBox;
	
	public function PreferSizeEditor(){
		super();
		check = new JCheckBox("Auto");
		check.setSelected(true);
		pane.append(check);
		check.addActionListener(__checkChanged);
		
		widthInput.setEditable(!check.isSelected());
		heightInput.setEditable(!check.isSelected());
	}
	
	private function __checkChanged(e:Event):void{
		widthInput.setEditable(!check.isSelected());
		heightInput.setEditable(!check.isSelected());
		applyProperty();
	}
	
	override protected function getEditorValue():*{
		if(check.isSelected() || widthInput.isEmpty() || heightInput.isEmpty()){
			return ProModel.NONE_VALUE_SET;
		}
		return new IntDimension(widthInput.getInputInt(), heightInput.getInputInt());
	}
}
}