package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JButton;
import flash.events.Event;
import org.aswing.guibuilder.model.PackProModel;

public class PackEditor implements PropertyEditor{
	
	private var button:JButton;
	private var model:PackProModel;
	
	public function PackEditor(model:PackProModel){
		this.model = model;
		button = new JButton("pack");
		button.addActionListener(__apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function getDisplay():Component{
		return button;
	}
	
	public function setApplyFunction(apply:Function):void{
	}
	
	public function applyProperty():void{
		model.applyProperty();
	}
}
}