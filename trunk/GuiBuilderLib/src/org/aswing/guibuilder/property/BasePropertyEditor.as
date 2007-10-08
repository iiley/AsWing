package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.Component;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.error.ImpMissError;

public class BasePropertyEditor{
	
	protected var pro:ProModel;
	protected var serializer:PropertySerializer;
	protected var valueXML:XML;
	protected var valueParsing:Boolean;
	
	public function BasePropertyEditor(){
		valueParsing = false;
	}
	
	protected function __apply(e:Event):void{
		if(!valueParsing){
			applyProperty();
		}
	}
	
	private function setValue(v:*):void{
		valueParsing = true;
		fillValue(v, v === ProModel.NONE_VALUE_SET):
		valueParsing = false;
	}
	
	protected function fillValue(v:*, noValueSet:Boolean):void{
		throw new ImpMissError();
	}
	
	protected function getEditorValue():*{
		throw new ImpMissError();
		return null;
	}
	
	public function bindTo(p:ProModel):void{
		pro = p;
		if(pro != null){
			setValue(pro.getValue());
		}
	}
	
	public function applyProperty():void{
		pro.valueChanged(getEditorValue());
	}
	
	public function setSerializer(ser:PropertySerializer):void{
		serializer = ser;
	}
}
}