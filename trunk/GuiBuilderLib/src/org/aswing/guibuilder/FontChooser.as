package org.aswing.guibuilder{
	
import org.aswing.*;
import flash.events.Event;
import org.aswing.guibuilder.util.MathUtils;
import flash.text.Font;	

public class FontChooser{
	
	private static var ins:FontChooser;
	
	public static function getIns():FontChooser{
		if(ins == null){
			new FontChooser();
		}
		return ins;
	}
	
	private var nameCombo:JComboBox;
	private var sizeCombo:JComboBox;
	private var boldCheck:JCheckBox;
	private var italicCheck:JCheckBox;
	private var underlineCheck:JCheckBox;
	private var embedCheck:JCheckBox;
	
	private var okButton:JButton;
	private var cancelButton:JButton;
	private var dialog:JFrame;
	
	private var handler:Function;
	
	public function FontChooser(){
		if(ins){
			throw new Error("Sington Error!");
		}
		ins = this;
		
		var fonts:Array = Font.enumerateFonts(true);
		var fontNames:Array = [];
		for each(var ff:Font in fonts){
			fontNames.push(ff.fontName);
		}
		
		nameCombo = new JComboBox(fontNames);
		nameCombo.setPreferredWidth(120);
		nameCombo.setEditable(true);
		
		sizeCombo = new JComboBox([8, 9, 10, 11, 12, 14, 16, 24, 32, 48, 64]);
		sizeCombo.setSelectedIndex(3);
		sizeCombo.setPreferredWidth(50);
		sizeCombo.setEditable(true);
		
		boldCheck = new JCheckBox("Bold");
		boldCheck.setFont(boldCheck.getFont().changeBold(true));
		italicCheck = new JCheckBox("Italic");
		italicCheck.setFont(italicCheck.getFont().changeItalic(true));
		underlineCheck = new JCheckBox("Underline");
		underlineCheck.setFont(underlineCheck.getFont().changeUnderline(true));
		embedCheck = new JCheckBox("Embed");
		
		okButton = new JButton("OK");
		cancelButton = new JButton("Cancel");
		
		var pane:JPanel = new JPanel(new BorderLayout());
		var center:JPanel = new JPanel();
		center.appendAll(nameCombo, sizeCombo, boldCheck, italicCheck, underlineCheck, embedCheck);
		var bottom:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10));
		bottom.appendAll(okButton, cancelButton);
		pane.append(center, BorderLayout.CENTER);
		pane.append(bottom, BorderLayout.SOUTH);
		
		dialog = new JFrame(null, "Font Chooser", true);
		dialog.setContentPane(pane);
		dialog.setSizeWH(400, 300);
		AsWingUtils.centerLocate(dialog);
		
		okButton.addActionListener(__ok);
		cancelButton.addActionListener(__cancel);
	}
	
	private function __ok(e:Event):void{
		dialog.dispose();
		var name:String = nameCombo.getSelectedItem();
		var size:int = MathUtils.parseInteger(sizeCombo.getSelectedItem());
		handler(new ASFont(name, size, boldCheck.isSelected(), 
			italicCheck.isSelected(), underlineCheck.isSelected(), embedCheck.isSelected()));
	}
	
	private function __cancel(e:Event):void{
		dialog.dispose();
	}
	
	/**
	 * __handler(f:ASFont) null means canceled
	 */
	public function open(__handler:Function, f:ASFont):void{
		handler = __handler;
		if(f != null){
			nameCombo.setSelectedItem(f.getName());
			sizeCombo.setSelectedItem(f.getSize());
			boldCheck.setSelected(f.isBold());
			italicCheck.setSelected(f.isItalic());
			underlineCheck.setSelected(f.isUnderline());
			embedCheck.setSelected(f.isEmbedFonts());
		}
		dialog.show();
	}
	
}
}