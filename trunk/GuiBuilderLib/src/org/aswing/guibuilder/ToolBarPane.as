package org.aswing.guibuilder{

import flash.events.Event;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import org.aswing.JButton;
import org.aswing.JComboBox;
import org.aswing.JOptionPane;
import org.aswing.JSeparator;
import org.aswing.JSpacer;
import org.aswing.JToolBar;
import org.aswing.LoadIcon;

public class ToolBarPane extends JToolBar{
	
	private var openButton:JButton;
	private var saveButton:JButton;
	private var closeButton:JButton;
	private var generateCodeButton:JButton;
	private var revalidateButton:JButton;
	
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
		revalidateButton = new JButton("Revalidate");
		revalidateButton.setToolTipText("Revalidate selected component to make the ui to be refreshed!");
		
		lafsCombo = new JComboBox();
		lafsCombo.setEditable(false);
		lafsCombo.setPreferredWidth(160);
		
		aboutButton = new JButton("About");
		
		appendAll(openButton, saveButton, closeButton, generateCodeButton);
		append(new JSeparator(JSeparator.HORIZONTAL));
		append(revalidateButton);
		append(new JSeparator(JSeparator.HORIZONTAL));
		append(JSpacer.createHorizontalSpacer(10));
		append(lafsCombo);
		append(JSpacer.createHorizontalSpacer(10));
		append(aboutButton);
		
		aboutButton.addActionListener(__showAbout);
	}
	
	private function __showAbout(e:Event):void{
		var op:JOptionPane = JOptionPane.showMessageDialog(
			"About AsWing GuiBuilder", 
			"Version:1.0\nDate:2007-10-7\nCreated by aswing.org", 
			__about, 
			this, true, new LoadIcon("icons/app_32.png", 32, 32), 
			JOptionPane.OK|JOptionPane.CANCEL);
		op.getOkButton().setText("Open AsWing Home");
		op.getCancelButton().setText("Close");
		op.getOkButton().revalidate();
	}
	
	private function __about(result:int):void{
		if(result == JOptionPane.OK){
			navigateToURL(new URLRequest("http://www.aswing.org"), "_blank");
		}
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
	
	public function getLAFsCombo():JComboBox{
		return lafsCombo;
	}
}
}