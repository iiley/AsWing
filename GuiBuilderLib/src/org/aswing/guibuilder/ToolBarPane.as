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
	private var closeButton:JButton;
	private var generateCodeButton:JButton;
	
	public function ToolBarPane(){
		super(JToolBar.HORIZONTAL);
		
		openButton = new JButton("Open");
		saveButton = new JButton("Save");
		closeButton = new JButton("Close");
		generateCodeButton = new JButton("Generate AS Code");
		
		appendAll(openButton, saveButton, closeButton, generateCodeButton);
	}
	
	public function getOpenButton():JButton{
		return openButton;
	}
	
	public function getSaveButton():JButton{
		return saveButton;
	}
	
	public function getCloseButton():JButton{
		return closeButton;
	}
	
	public function getGenerateCodeButton():JButton{
		return generateCodeButton;
	}
}
}