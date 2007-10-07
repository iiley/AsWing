package org.aswing.guibuilder{

import org.aswing.ext.Form;
import org.aswing.border.TitledBorder;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.Model;
import org.aswing.BorderLayout;
import org.aswing.JScrollPane;
import org.aswing.JPanel;
import org.aswing.JViewport;
import org.aswing.JLabel;

public class PropertyPane extends JPanel{
	
	private var form:Form;
	
	public function PropertyPane(){
		super();
		form = new Form();
		setBorder(new TitledBorder(null, "Properties"));
		setLayout(new BorderLayout());
		var vp:JViewport = new JViewport(form);
		vp.setVerticalAlignment(JViewport.TOP);
		vp.setHorizontalAlignment(JViewport.LEFT);
		append(new JScrollPane(vp));
	}
	
	public function setModel(model:Model):void{
		form.removeAll();
		if(model != null){
			var pros:Array = model.getProperties();
			for each(var pro:ProModel in pros){
				addEditor(pro.getLabel(), pro.getEditor());
			}
		}
		form.revalidate();
	}
	
	private function addEditor(label:String, editor:PropertyEditor):void{
		var jlabel:JLabel = form.createLeftLabel(label);
		jlabel.setFont(jlabel.getFont().changeBold(true));
		form.addRow(jlabel, editor.getDisplay());
	}
}
}