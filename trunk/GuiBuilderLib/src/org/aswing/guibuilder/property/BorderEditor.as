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
		borderChooser.open(__choosed, (borderModel===DEFAULT ? null : borderModel));
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
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			borderModel = DEFAULT;
			button.setText("Default");
		}else if(v.getValue() == null){
			button.setText("null");
			borderModel = null;
		}else{
			borderModel = v as BorderModel;
			button.setText(borderModel.getName());
		}
	}	
	
	override protected function getEditorValue():ValueModel{
		if(borderModel === DEFAULT){
			return ProModel.NONE_VALUE_SET;
		}else if(borderModel != null){
			return borderModel;
		}else{
			return new SimpleValue(null);
		}
	}
}
}