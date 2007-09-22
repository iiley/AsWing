package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JButton;
import org.aswing.EmptyLayout;
import org.aswing.guibuilder.model.LayoutModel;
import flash.events.Event;
import org.aswing.guibuilder.LayoutChooser;

public class LayoutEditor implements PropertyEditor{
	
	private var display:JButton;
	
	private var layoutModel:LayoutModel;
	
	public function LayoutEditor(){
		display = new JButton("Default");
		display.addActionListener(__showChooser);
	}
	
	private function __showChooser(e:Event):void{
		LayoutChooser.getIns().open(__choosed);
	}
	private function __choosed(m:LayoutModel):void{
		if(m){
			layoutModel = m;
			applyProperty();
		}
	}
	
	public function getDisplay():Component{
		return display;
	}
	

	public function parseValue(xml:XML):*{
		
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		return xml;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		apply(layoutModel.getLayout());
	}
	
}
}