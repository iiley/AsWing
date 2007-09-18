package org.aswing.guibuilder{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.BorderLayout;
import org.aswing.JToolBar;
import org.aswing.JButton;
import org.aswing.JSeparator;

public class ToolBarPane extends JToolBar{
	
	private var newPanelButton:JButton;
	private var openButton:JButton;
	private var saveButton:JButton;
	
	public function ToolBarPane(){
		super(JToolBar.HORIZONTAL);
		
		newPanelButton = new JButton("New Pane");
		openButton = new JButton("Open");
		saveButton = new JButton("Save");
		
		append(newPanelButton);
		append(new JSeparator(JSeparator.VERTICAL));
		appendAll(openButton, saveButton);
	}
	
	public function getNewPanelButton():JButton{
		return newPanelButton;
	}
	
	public function getOpenButton():JButton{
		return openButton;
	}
	
	public function getSaveButton():JButton{
		return saveButton;
	}
}
}