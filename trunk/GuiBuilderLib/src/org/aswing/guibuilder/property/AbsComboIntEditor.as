package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.*;
import flash.events.Event;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.guibuilder.model.ProModel;

public class AbsComboIntEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var combo:JComboBox;
	
	public function AbsComboIntEditor(labels:Array){
		combo = new JComboBox(labels);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
		combo.setListCellFactory(new DefaultComboBoxListCellFactory(false, false));
	}
	
	public function getDisplay():Component{
		return combo;
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		var index:int = v;
		if(noValueSet){
			index = 0;
		}
		combo.setSelectedIndex(index);
	}	
	
	override protected function getEditorValue():*{
		if(combo.getSelectedIndex() <= 0){
			return ProModel.NONE_VALUE_SET;
		}else{
			return combo.getSelectedIndex();
		}
	}
}
}