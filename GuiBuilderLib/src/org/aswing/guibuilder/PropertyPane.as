package org.aswing.guibuilder{

import org.aswing.ext.Form;
import org.aswing.border.TitledBorder;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.Model;

public class PropertyPane extends Form{
	
	public function PropertyPane(){
		super();
		setPreferredWidth(100);
		setBorder(new TitledBorder(null, "Properties"));
	}
	
	public function setModel(model:Model):void{
		removeAll();
		if(model != null){
			var pros:Array = model.getProperties();
			for each(var pro:ProModel in pros){
				addEditor(pro.getName(), pro.getEditor());
			}
		}
	}
	
	private function addEditor(name:String, editor:PropertyEditor):void{
		addRow(createLeftLabel(name), editor.getDisplay());
	}
}
}