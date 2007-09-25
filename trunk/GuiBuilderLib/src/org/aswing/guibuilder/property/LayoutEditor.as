package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JButton;
import org.aswing.EmptyLayout;
import org.aswing.guibuilder.model.LayoutModel;
import flash.events.Event;
import org.aswing.guibuilder.LayoutChooser;
import org.aswing.guibuilder.model.ProModel;
import flash.utils.getQualifiedClassName;
import org.aswing.guibuilder.model.Definition;
import org.aswing.guibuilder.model.LayoutDefinition;

public class LayoutEditor implements PropertyEditor{
	
	private var display:JButton;
	
	private var layoutModel:LayoutModel;
	
	public function LayoutEditor(){
		display = new JButton("Default");
		display.addActionListener(__showChooser);
	}
	
	private function __showChooser(e:Event):void{
		LayoutChooser.getIns().open(__choosed, layoutModel);
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
		var model:LayoutModel = new LayoutModel();
		model.parse(xml.children()[0]);
		layoutModel = model;
		display.setText(model.getName());
		return layoutModel.getLayout();
	}
	
	public function encodeValue(value:*):XML{
		var model:LayoutModel = null;
		var layoutDef:LayoutDefinition;
		if(value == layoutModel.getLayout()){
			model = layoutModel;
			layoutDef = model.getDef();
		}
		var xml:XML = <Value></Value>;
		if(model == null){
			var clazz:String = getQualifiedClassName(value);
			clazz = clazz.split("::").join(".");
			layoutDef = Definition.getIns().getLayoutDefinitionWithClassName(clazz);
			model = new LayoutModel(layoutDef);
		}
		xml.appendChild(model.encodeXML());
		return xml;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(layoutModel != null){
			apply(layoutModel.getLayout());
			display.setText(layoutModel.getName());
		}else{
			display.setText("Default");
			apply(ProModel.NONE_VALUE_SET);
		}
	}
	
}
}