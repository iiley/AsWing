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
import org.aswing.guibuilder.code.CodeGenerator;

public class LayoutEditor extends BasePropertyEditor implements PropertyEditor{
	
	private var display:JButton;
	private var layoutChooser:LayoutChooser;
	private var layoutModel:LayoutModel;
	
	public function LayoutEditor(){
		display = new JButton("Default");
		display.addActionListener(__showChooser);
		layoutChooser = new LayoutChooser();
	}
	
	private function __showChooser(e:Event):void{
		layoutChooser.open(__choosed, layoutModel);
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
	
	override public function setEditorParam(param:String):void{
		display.setEnabled(param != "disabled");
	}
	
	override public function bindTo(p:ProModel):void{
		pro = p;
		if(pro != null){
			fillValue(p.getValueModel(), p.getValueModel() == null);
		}
	}	
	
	override public function applyProperty():void{
		super.applyProperty();
		pro.setValueModel(layoutModel);
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		layoutModel = v;
		if(layoutModel != null){
			display.setText(layoutModel.getName());
		}else{
			display.setText("Default");
		}
	}	
	
	override protected function getEditorValue():*{
		if(layoutModel != null){
			return layoutModel.getLayout();
		}else{
			return ProModel.NONE_VALUE_SET;
		}
	}
}
}