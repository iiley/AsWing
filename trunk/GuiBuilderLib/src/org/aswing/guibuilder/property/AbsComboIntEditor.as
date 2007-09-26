package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.*;
import flash.events.Event;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.guibuilder.model.ProModel;

public class AbsComboIntEditor implements PropertyEditor{
	
	private var combo:JComboBox;
	
	public function AbsComboIntEditor(labels:Array){
		combo = new JComboBox(labels);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function parseValue(xml:XML):*{
		var index:int = MathUtils.parseInteger(xml.@value);
		combo.setSelectedIndex(index);
		return index;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = value+"";
		return xml;
	}
	
	public function getCodeLines():Array{
		return null;
	}
	
	public function isSimpleOneLine():String{
		return combo.getSelectedIndex()+"";
	}
	
	public function getDisplay():Component{
		return combo;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		var index:int = combo.getSelectedIndex();
		if(index >= 0){
			apply(index);
		}else{
			apply(ProModel.NONE_VALUE_SET);
		}
	}
}
}