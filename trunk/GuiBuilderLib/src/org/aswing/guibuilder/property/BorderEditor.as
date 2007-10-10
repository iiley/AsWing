package org.aswing.guibuilder.property{
	
import flash.events.Event;

import org.aswing.*;
import org.aswing.guibuilder.BorderChooser;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.*;

public class BorderEditor extends BasePropertyEditor implements PropertyEditor{
	
	private static var DEFAULT:BorderModel = new BorderModel();
	
	private var defaultRadio:JRadioButton;
	private var nullRadio:JRadioButton;
	private var button:JButton;
	private var pane:Container;
	private var borderChooser:BorderChooser;
	
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
		borderChooser = new BorderChooser();
	}
	
	private function __showChooser(e:Event):void{
		borderChooser.open(__choosed, borderModel);
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
	
	override public function bindTo(p:ProModel):void{
		pro = p;
		if(pro != null){
			fillValue(p.getValueModel(), p.getValueModel() === DEFAULT);
		}
	}	
	
	override public function applyProperty():void{
		super.applyProperty();
		pro.setValueModel(borderModel);
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		borderModel = v;
		if(borderModel === DEFAULT){
			button.setText("Default");
		}else if(borderModel != null){
			button.setText(borderModel.getName());
		}else{
			button.setText("null");
		}
	}	
	
	override protected function getEditorValue():*{
		if(borderModel === DEFAULT){
			return ProModel.NONE_VALUE_SET;
		}else if(borderModel != null){
			return borderModel.getBorder();
		}else{
			return null;
		}
	}
}
}