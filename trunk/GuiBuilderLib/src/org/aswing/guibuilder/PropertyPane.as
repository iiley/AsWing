package org.aswing.guibuilder{

import org.aswing.BorderLayout;
import org.aswing.JLabel;
import org.aswing.JPanel;
import org.aswing.JScrollPane;
import org.aswing.JViewport;
import org.aswing.border.TitledBorder;
import org.aswing.ext.Form;
import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ProDefinition;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.util.HashMap;

public class PropertyPane extends JPanel{
	
	private var form:Form;
	private var editorsMap:HashMap;
	private var curEditors:Array;
	
	public function PropertyPane(){
		super();
		form = new Form();
		setBorder(new TitledBorder(null, "Properties"));
		setLayout(new BorderLayout());
		var vp:JViewport = new JViewport(form);
		vp.setVerticalAlignment(JViewport.TOP);
		vp.setHorizontalAlignment(JViewport.LEFT);
		append(new JScrollPane(vp));
		
		editorsMap = new HashMap();
		curEditors = [];
	}
	
	public function setModel(model:Model):void{
		form.removeAll();
		curEditors = [];
		if(model != null){
			var pros:Array = model.getProperties();
			for each(var pro:ProModel in pros){
				var editor:PropertyEditor = getCreateEditor(pro.getDef());
				editor.setEditorParam(pro.getDef().getEditorParam());
				editor.getDisplay().setToolTipText(pro.getDef().getTooltip());
				editor.bindTo(pro);
				addEditor(pro.getLabel(), editor);
			}
		}
		form.revalidate();
	}
	
	private function addEditor(label:String, editor:PropertyEditor):void{
		var jlabel:JLabel = form.createLeftLabel(label);
		jlabel.setFont(jlabel.getFont().changeBold(true));
		form.addRow(jlabel, editor.getDisplay());
		curEditors.push(editor);
	}
	
	public function applyPropertiesEdited():void{
		for each(var editor:PropertyEditor in curEditors){
			editor.applyProperty();
		}
	}
	
	public function getCreateEditor(def:ProDefinition):PropertyEditor{
		if(editorsMap.containsKey(def.getName())){
			return editorsMap.getValue(def.getName());
		}
		var editor:PropertyEditor = def.createPropertyEditor();
		editorsMap.put(def.getName(), editor);
		return editor;
	}
}
}