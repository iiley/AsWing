package org.aswing.guibuilder{

import org.aswing.ext.Form;
import org.aswing.border.TitledBorder;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.ProModel;

public class PropertyPane extends Form{
	
	public function PropertyPane(){
		super();
		setPreferredWidth(100);
		setBorder(new TitledBorder(null, "Properties"));
	}
	
	public function setComModel(comModel:ComModel):void{
		removeAll();
		if(comModel != null){
			var pros:Array = comModel.getProperties();
			for each(var pro:ProModel in pros){
				addEditor(pro.getName(), pro.getEditor());
			}
		}
	}
	
	private function addEditor(name:String, editor:PropertyEditor):void{
		addRow(createRightLabel(name), editor.getDisplay());
	}
}
}