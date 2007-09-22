package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JCheckBox;
import flash.events.Event;
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
	
	override public function applyProperty():void{
		if(check.isSelected()){
			apply(null);
			apply(ProModel.NONE_VALUE_SET);
		}else{
			super.applyProperty();
		}
	}
	
}
}