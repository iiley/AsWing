package org.aswing.guibuilder.property{
	
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.*;
import org.aswing.guibuilder.model.*;
import org.aswing.guibuilder.property.*;
import flash.events.Event;
import flash.utils.getQualifiedClassName;
import org.aswing.guibuilder.BorderChooser;
import org.aswing.guibuilder.code.CodeGenerator;

public class BorderEditor implements PropertyEditor{
	
	private static var DEFAULT:BorderModel = new BorderModel();
	
	private var defaultRadio:JRadioButton;
	private var nullRadio:JRadioButton;
	private var button:JButton;
	private var pane:Container;
	
	private var borderModel:BorderModel;
	
	public function BorderEditor(){
		pane = new JPanel(new FlowLayout(FlowLayout.LEFT, 2, 0, false));
		button = new JButton("Default");
		defaultRadio = new JRadioButton("default");
		nullRadio = new JRadioButton("null");
		pane.appendAll(button, defaultRadio, nullRadio);
		defaultRadio.addActionListener(__default);
		nullRadio.addActionListener(__null);
		defaultRadio.setSelected(true);
		button.addActionListener(__showChooser);
	}
	
	private function __showChooser(e:Event):void{
		BorderChooser.getIns().open(__choosed, borderModel);
	}
	private function __choosed(m:BorderModel):void{
		if(m){
			nullRadio.setSelected(false);
			defaultRadio.setSelected(false);
			borderModel = m;
			applyProperty();
		}
	}
	
	private function __default(e:Event):void{
		nullRadio.setSelected(false);
		borderModel = DEFAULT;
		applyProperty();
	}
	
	private function __null(e:Event):void{
		defaultRadio.setSelected(false);
		borderModel = null;
		applyProperty();
	}	
	
	public function getDisplay():Component{
		return pane;
	}

	public function parseValue(xml:XML):*{
		if(xml.@value == "null"){
			return null;
		}
		var model:BorderModel = new BorderModel();
		model.parse(xml.children()[0]);
		borderModel = model;
		button.setText(model.getName());
		nullRadio.setSelected(false);
		defaultRadio.setSelected(false);
		return borderModel.getBorder();
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		if(value == null){
			xml.@value="null";
			return xml;
		}
		var model:BorderModel = null;
		var borderDef:BorderDefinition;
		if(value == borderModel.getBorder()){
			model = borderModel;
			borderDef = model.getDef();
		}
		if(model == null){
			var clazz:String = getQualifiedClassName(value);
			clazz = clazz.split("::").join(".");
			borderDef = Definition.getIns().getBorderDefinitionWithClassName(clazz);
			model = new BorderModel(borderDef);
		}
		xml.appendChild(model.encodeXML());
		return xml;
	}
		
	public function getCodeLines():Array{
		CodeGenerator.border_id_counter++;
		var id:String = "border" + CodeGenerator.border_id_counter;
		var clazz:String = borderModel.getDef().getShortClassName();
		var arr:Array = [];
		arr.push("var " + id + ":" + clazz + " = new " + clazz + "();");
		var pros:Array = borderModel.getProperties();
		for each(var pro:ProModel in pros){
			var simple:String = pro.isSimpleOneLine();
			if(simple != null){
				arr.push(id + ".set" + pro.getName() + "(" + simple + ");");
			}else{
				var proCodeLines:Array = pro.getCodeLines();
				if(proCodeLines != null){
					var n:int = proCodeLines.length - 1;
					for(var i:int=0; i<n; i++){
						arr.push(proCodeLines[i]);
					}
					arr.push(id + ".set" + pro.getName() + "(" + proCodeLines[n] + ");");
				}
			}
		}
		arr.push(id);
		return arr;
	}
	
	public function isSimpleOneLine():String{
		if(borderModel == null){
			return "null";
		}
		return null;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(borderModel == DEFAULT){
			button.setText("Default");
			apply(ProModel.NONE_VALUE_SET);
		}else if(borderModel != null){
			apply(borderModel.getBorder());
			button.setText(borderModel.getName());
		}else{
			button.setText("Null");
			apply(null);
		}
	}
	
	
}
}