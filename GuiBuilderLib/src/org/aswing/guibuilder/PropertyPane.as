package org.aswing.guibuilder{

import org.aswing.ASFont;
import org.aswing.BorderLayout;
import org.aswing.JLabel;
import org.aswing.JPanel;
import org.aswing.JScrollPane;
import org.aswing.JViewport;
import org.aswing.border.TitledBorder;
import org.aswing.ext.Form;
import org.aswing.ext.FormRow;
import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ProDefinition;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.util.HashMap;
import org.aswing.util.HashSet;

public class PropertyPane extends JPanel{
	
	private var form:Form;
	private var editorsMap:HashMap;
	private var editorRowMap:HashMap;
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
		editorRowMap = new HashMap();
		curEditors = [];
	}
	
	public function setModel(model:Model):void{
		curEditors = [];
		var curEditorsSet:HashSet = new HashSet();
		if(model != null){
			var pros:Array = model.getProperties();
			for each(var pro:ProModel in pros){
				var editor:PropertyEditor = getCreateEditor(pro.getDef());
				editor.setEditorParam(pro.getDef().getEditorParam());
				editor.getDisplay().setToolTipText(pro.getDef().getTooltip());
				editor.bindTo(pro);
				curEditorsSet.add(editor);
			}
		}
		var editors:Array = editorsMap.values();
		for each(var ed:PropertyEditor in editors){
			setEditorVisible(ed, curEditorsSet.contains(ed));
		}
		form.revalidate();
	}
	
	private function setEditorVisible(editor:PropertyEditor, v:Boolean):void{
		var row:FormRow = editorRowMap.getValue(editor);
		if(row){
			row.setVisible(v);
		}
	}
	
	private function addEditor(label:String, editor:PropertyEditor):void{
		var jlabel:JLabel = form.createLeftLabel(label);
		jlabel.setFont(jlabel.getFont().changeBold(true));
		var row:FormRow = form.addRow(jlabel, editor.getDisplay());
		curEditors.push(editor);
		editorRowMap.put(editor, row);
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
		addEditor(def.getLabel(), editor);
		return editor;
	}
}
}