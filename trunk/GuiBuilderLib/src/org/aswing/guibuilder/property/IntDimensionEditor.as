package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JButton;

public class IntDimensionEditor implements PropertyEditor{
	
	private var temp:JButton;
	
	public function IntDimensionEditor(){
		temp = new JButton("Temp");
	}
	
	public function getDisplay():Component{
		return temp;
	}
	
	public function applyProperty(apply:Function):void{
	}
	
}
}