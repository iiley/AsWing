package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JButton;
import org.aswing.EmptyLayout;

public class LayoutEditor implements PropertyEditor{
	
	private var display:JButton;
	
	private var emptyLayout:EmptyLayout;
	
	public function LayoutEditor(){
		display = new JButton("Default");
		emptyLayout = new EmptyLayout();
	}
	
	public function getDisplay():Component{
		return display;
	}
	
	public function applyProperty(apply:Function):void{
		apply(emptyLayout);
	}
	
}
}