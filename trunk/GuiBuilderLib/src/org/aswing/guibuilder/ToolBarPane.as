package org.aswing.guibuilder{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.BorderLayout;
import org.aswing.JToolBar;
import org.aswing.JButton;
import org.aswing.JSeparator;

public class ToolBarPane extends JToolBar{
	
	private var openButton:JButton;
	private var saveButton:JButton;
	
	public function ToolBarPane(){
		super(JToolBar.HORIZONTAL);
		
		openButton = new JButton("Open");
		saveButton = new JButton("Save");
		
		appendAll(openButton, saveButton);
	}
	
	public function getOpenButton():JButton{
		return openButton;
	}
	
	public function getSaveButton():JButton{
		return saveButton;
	}
}
}