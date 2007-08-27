package org.aswing.guibuilder{

import org.aswing.ext.Form;

public class PropertyPane extends Form{
	
	public function PropertyPane(){
		super();
	}
	
	public function addEditor(name:String, editor:PropertyEditor):void{
		addRow(createRightLabel(name), editor.getDisplay());
	}
}
}