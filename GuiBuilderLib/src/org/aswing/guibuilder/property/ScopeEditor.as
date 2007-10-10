package org.aswing.guibuilder.property{

import org.aswing.*;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.ProModel;

public class ScopeEditor extends BasePropertyEditor implements PropertyEditor{
		
	private var combo:JComboBox;
	
	public function ScopeEditor(param:String=null){
		combo = new JComboBox();
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
	}
	
	override public function setEditorParam(param:String):void{
		if(param == "none-enabled"){
			combo.setListData([
								ComModel.SCOPE_PUBLIC, 
								ComModel.SCOPE_PRIVATE, 
								ComModel.SCOPE_PROTECTED, 
								ComModel.SCOPE_INTERNAL, 
								ComModel.SCOPE_NONE]);
		}else{
			combo.setListData([
								ComModel.SCOPE_PUBLIC, 
								ComModel.SCOPE_PRIVATE, 
								ComModel.SCOPE_PROTECTED, 
								ComModel.SCOPE_INTERNAL]);
		}
	}
	
	override protected function fillValue(v:*, noValueSet:Boolean):void{
		if(noValueSet){
			v = "";
		}
		combo.setSelectedItem(v);
	}	
	
	override protected function getEditorValue():*{
		var value:* = combo.getSelectedItem();
		if(value == null || value == ""){
			return ProModel.NONE_VALUE_SET;
		}else{
			return value;
		}
	}
	
	
	public function getDisplay():Component{
		return combo;
	}
}
}