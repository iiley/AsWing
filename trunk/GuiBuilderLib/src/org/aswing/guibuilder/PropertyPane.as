package org.aswing.guibuilder{

import org.aswing.ext.Form;
import org.aswing.border.TitledBorder;

public class PropertyPane extends Form{
	
	public function PropertyPane(){
		super();
		setPreferredWidth(100);
		setBorder(new TitledBorder(null, "Properties"));
	}
	
	public function addEditor(name:String, editor:PropertyEditor):void{
		addRow(createRightLabel(name), editor.getDisplay());
	}
}
}