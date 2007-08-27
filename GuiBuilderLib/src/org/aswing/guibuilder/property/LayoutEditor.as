package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JButton;

public class LayoutEditor implements PropertyEditor{
	
	private var display:JButton;
	
	public function LayoutEditor(){
		display = new JButton("Default");
	}
	
	public function getDisplay():Component{
		return display;
	}
	
	public function applyProperty(apply:Function):void{
	}
	
}
}