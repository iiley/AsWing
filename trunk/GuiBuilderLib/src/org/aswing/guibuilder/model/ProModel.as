package org.aswing.guibuilder.model{

import org.aswing.guibuilder.PropertyEditor;	

/**
 * Property Model
 * @author iiley
 */
public class ProModel{
	
	public static const NONE_VALUE_SET:Object = {};
	
	private var def:ProDefinition;
	protected var editor:PropertyEditor;
	protected var owner:Model;
	protected var value:*;
	protected var noneValue:Boolean; //whether or not set this property a value
	protected var defaultValue:*;
	
	public function ProModel(def:ProDefinition){
		this.def = def;
		if(def != null){
			var clazz:Class = def.getEditorClass();
			if(def.getEditorParam() != "" && def.getEditorParam() != null){
				editor = new clazz(def.getEditorParam());
			}else{
				editor = new clazz();
			}
			editor.setApplyFunction(__apply);
		}
		noneValue = true;
	}
	
	private function __apply(v:*):void{
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
	
	public function bindTo(c:Model):void{
		owner = c;
		defaultValue = owner.captureProperty(def.getName());
		var defaultValueXML:XMLList = def.getDefaultValue();
		if(defaultValueXML != null && defaultValueXML.length() >0){
			__apply(editor.parseValue(defaultValueXML[0]));
		}
	}
	
	public function parse(xml:XML):void{
		var valueXML:XMLList = xml.Value;
		if(valueXML != null && valueXML.length() > 0){
			__apply(editor.parseValue(valueXML[0]));
		}
	}
	
	public function encodeXML():XML{
		if(noneValue){
			return null;
		}
		var xml:XML = <Property></Property>;
		xml.@name = getName();
		xml.@type = def.getName();
		xml.appendChild(editor.encodeValue(value));
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
		return editor.getCodeLines();
	}
	
	/**
	 * Just one string to represent the value, for example "new ASColor(0xff0000, 1)";
	 * If just one string can't, return null, then getCodeLines will be called.
	 */
	public function isSimpleOneLine():String{
		if(noneValue){
			return null;
		}
		return editor.isSimpleOneLine();
	}
	
	public function getLabel():String{
		return def.getLabel();
	}
	
	public function getName():String{
		return def.getName();
	}
	
	public function getEditor():PropertyEditor{
		return editor;
	}
}
}