package org.aswing.guibuilder{

import org.aswing.JButton;
import org.aswing.JCheckBox;
import org.aswing.JComboBox;
import org.aswing.JSeparator;
import org.aswing.JSpacer;
import org.aswing.JToolBar;
import org.aswing.JLabel;

public class ToolBarPane extends JToolBar{
	
	private var openButton:JButton;
	private var saveButton:JButton;
	private var closeButton:JButton;
	private var generateCodeButton:JButton;
	private var generateComCodeButton:JButton;
	private var revalidateButton:JButton;
	private var rangeCheck:JCheckBox;
	
	private var lafsCombo:JComboBox;
	private var aboutButton:JButton;
	
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
		generateComCodeButton = new JButton("Generate Selection");
		generateComCodeButton.setToolTipText("Generate selected component ui to ActionScript class.");
		revalidateButton = new JButton("Revalidate");
		revalidateButton.setToolTipText("Revalidate selected component to make the ui to be refreshed!");
		rangeCheck = new JCheckBox("View Range");
		rangeCheck.setToolTipText("Whether draw a background to indicate root component range");
		rangeCheck.setSelected(true);
		
		lafsCombo = new JComboBox();
		lafsCombo.setEditable(false);
		lafsCombo.setPreferredWidth(160);
		
		aboutButton = new JButton("About");
		
		appendAll(openButton, saveButton, closeButton, generateCodeButton, generateComCodeButton);
		append(new JSeparator(JSeparator.VERTICAL));
		append(rangeCheck, revalidateButton);
		append(JSpacer.createHorizontalSpacer(10));
		appendAll(new JLabel("LAF:"), lafsCombo);
		append(JSpacer.createHorizontalSpacer(10));
		append(aboutButton);
	}
	
	public function getRangeCheck():JCheckBox{
		return rangeCheck;
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
	
	public function getGenerateComCodeButton():JButton{
		return generateComCodeButton;
	}
	
	public function getRevalidateButton():JButton{
		return revalidateButton;
	}
	
	public function getLAFsCombo():JComboBox{
		return lafsCombo;
	}
	
	public function getAboutButton():JButton{
		return aboutButton;
	}
}
}