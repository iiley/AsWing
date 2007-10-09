package org.aswing.guibuilder.property{

public class IntEmuEditor extends AbsComboIntEditor{
	
	public function IntEmuEditor(labels:String){
		super();
	}
	
	public function setEditorParam(param:String):void{
		combo.setListData(param.split(","));
	}
	
}
}