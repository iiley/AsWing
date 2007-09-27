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
	private var revalidateButton:JButton;
	
	public function ToolBarPane(){
		super(JToolBar.HORIZONTAL);
		
		openButton = new JButton("Open");
		openButton.setToolTipText("Open a exists ui file.");
		saveButton = new JButton("Save");
		saveButton.setToolTipText("Save to the folder where GuiBuilder is installed.");
		closeButton = new JButton("Close");
		closeButton.setToolTipText("Close present file.");
		generateCodeButton = new JButton("Generate AS Code");
		generateCodeButton.setToolTipText("Generate present ui to ActionScript class.");
		revalidateButton = new JButton("Revalidate");
		revalidateButton.setToolTipText("Revalidate selected component to make the ui to be refreshed!");
		
		appendAll(openButton, saveButton, closeButton, generateCodeButton);
		append(new JSeparator(JSeparator.HORIZONTAL));
		append(revalidateButton);
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
	
	public function getRevalidateButton():JButton{
		return revalidateButton;
	}
}
}