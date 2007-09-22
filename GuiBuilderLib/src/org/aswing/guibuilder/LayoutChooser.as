package org.aswing.guibuilder{
	
import org.aswing.*;
import org.aswing.guibuilder.model.Definition;
import org.aswing.guibuilder.model.LayoutDefinition;
import org.aswing.guibuilder.model.LayoutModel;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
	

public class LayoutChooser{
	
	private static var ins:LayoutChooser;
	
	public static function getIns():LayoutChooser{
		if(ins == null){
			new LayoutChooser();
		}
		return ins;
	}
	
	private var dialog:JFrame;
	private var layoutList:JList;
	private var propertyPane:PropertyPane;
	private var okButton:JButton;
	private var cancelButton:JButton;
	private var handler:Function;
	
	public function LayoutChooser(){
		if(ins){
			throw new Error("Sington can't be instansted more than once!");
		}
		ins = this;
		
		dialog = new JFrame(null, "Layout Chooser", true);
		var pane:Container = dialog.getContentPane();
		layoutList = new JList();
		layoutList.setSelectionMode(JList.SINGLE_SELECTION);
		layoutList.setVisibleCellWidth(120);
		propertyPane = new PropertyPane();
		dialog.setSizeWH(400, 300);
		okButton = new JButton("OK");
		cancelButton = new JButton("Cancel");
		pane.append(new JScrollPane(layoutList), BorderLayout.WEST);
		pane.append(propertyPane, BorderLayout.CENTER);
		var buttons:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 20));
		buttons.appendAll(okButton, cancelButton);
		pane.append(buttons, BorderLayout.SOUTH);
		
		layoutList.addSelectionListener(__layoutSelection);
		okButton.addActionListener(__ok);
		cancelButton.addActionListener(__cancel);
	}
	
	private function __ok(e:Event):void{
		dialog.dispose();
		var model:LayoutModel = layoutList.getSelectedValue();
		var pros:Array = model.getProperties();
		for each(var pro:ProModel in pros){
			pro.getEditor().applyProperty();
		}
		handler(model);
	}
	
	private function __cancel(e:Event):void{
		dialog.dispose();
	}
	
	private function __layoutSelection(e:Event):void{
		propertyPane.setModel(layoutList.getSelectedValue());
	}
	
	/**
	 * __handler(layoutModel:LayoutModel) null means canceled
	 */
	public function open(__handler:Function, curModel:LayoutModel):void{
		reloadData(curModel);
		dialog.show();
		handler = __handler;
	}
	
	public function reloadData(curModel:LayoutModel):void{
		var layDefs:Array = Definition.getIns().getLayouts();
		var layouts:Array = new Array();
		var selectedCur:Boolean = false;
		for each(var layDef:LayoutDefinition in layDefs){
			var m:LayoutModel = new LayoutModel(layDef);
			if(curModel != null && curModel.getName() == m.getName()){
				m = curModel;
				selectedCur = true; 
			}
			layouts.push(m);
		}
		layoutList.setListData(layouts);
		if(selectedCur){
			layoutList.setSelectedValue(curModel);
		}else{
			layoutList.setSelectedIndex(0);
		}
	}
}
}