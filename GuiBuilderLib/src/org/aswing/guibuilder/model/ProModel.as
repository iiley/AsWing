package org.aswing.guibuilder.model{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.PropertySerializer;	

/**
 * Property Model
 * @author iiley
 */
public class ProModel{
	
	public static const NONE_VALUE_SET:Object = {};
	
	private var def:ProDefinition;
	protected var owner:Model;
	protected var value:*;
	protected var valueModel:*; //for some complex value like layout, border's model
	protected var noneValue:Boolean; //whether or not set this property a value
	protected var defaultValue:*;
	protected var valueXML:XML;
	protected var valueSerializer:PropertySerializer;
	
	public function ProModel(def:ProDefinition){
		this.def = def;
		noneValue = true;
		valueSerializer = def.createPropertySerializer();
	}
	
	public function getDef():ProDefinition{
		return def;
	}
	
	public function valueChanged(v:*):void{
		if(v === NONE_VALUE_SET){
			value = undefined;
			noneValue = true;
			owner.applyProperty(def.getName(), defaultValue, def.getAction());
		}else{
			value = v;
			noneValue = false;
			owner.applyProperty(def.getName(), v, def.getAction());
		}
	}
		
	public function getValue():*{
		if(noneValue){
			return NONE_VALUE_SET;
		}else{
			return value;
		}
	}
	
	/**
	 * For some complex value use, for example layout value, border value
	 */
	public function setValueModel(vm:*):void{
		valueModel = vm;
	}
	
	/**
	 * For some complex value use, for example layout value, border value
	 */	
	public function getValueModel():*{
		return valueModel;
	}
	
	public function isNoValueSet():Boolean{
		return noneValue;
	}
	
	public function bindTo(c:Model):void{
		owner = c;
		defaultValue = owner.captureProperty(def.getName());
		var defaultValueXML:XMLList = def.getDefaultValue();
		if(defaultValueXML != null && defaultValueXML.length() >0){
			valueXML = defaultValueXML[0];
			valueChanged(valueSerializer.decodeValue(valueXML));
		}
	}
	
	public function parse(xml:XML):void{
		var valueXML:XMLList = xml.Value;
		if(valueXML != null && valueXML.length() > 0){
			valueXML = valueXML[0];
			valueChanged(valueSerializer.decodeValue(valueXML));
		}
	}
	
	public function encodeXML():XML{
		if(noneValue){
			return null;
		}
		var xml:XML = <Property></Property>;
		xml.@name = getName();
		xml.@type = def.getName();
		xml.appendChild(valueSerializer.encodeValue(value));
		return xml;
	}
	
	/**
	 * (0, n-2) line are the property creation, last line is the property name, for example:
	 * [ "var border3:LineBorder = new LineBorder();", 
	 *   "border3.setThickness(4);", 
	 *   "border3"
	 * ]
	 */
	public function getCodeLines():Array{
		if(noneValue){
			return null;
		}
		return valueSerializer.getCodeLines(value);
	}
	
	/**
	 * Just one string to represent the value, for example "new ASColor(0xff0000, 1)";
	 * If just one string can't, return null, then getCodeLines will be called.
	 */
	public function isSimpleOneLine():String{
		if(noneValue){
			return null;
		}
		return valueSerializer.isSimpleOneLine(value);
	}
	
	public function getLabel():String{
		return def.getLabel();
	}
	
	public function getName():String{
		return def.getName();
	}
}
}