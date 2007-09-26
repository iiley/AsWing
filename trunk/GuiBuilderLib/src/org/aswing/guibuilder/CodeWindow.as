package org.aswing.guibuilder{
	
import org.aswing.JFrame;
import org.aswing.JTextArea;
import org.aswing.JScrollPane;
import org.aswing.AsWingUtils;
	

public class CodeWindow{
	
	private static var ins:CodeWindow;
	public static function getIns():CodeWindow{
		if(ins == null){
			new CodeWindow();
		}
		return ins;
	}
	
	private var dialog:JFrame;
	private var text:JTextArea;
	
	public function CodeWindow(){
		if(ins){
			throw new Error("Sington Error!");
		}
		ins = this;
		dialog = new JFrame(null, "CodePreview", false);
		text = new JTextArea();
		dialog.setContentPane(new JScrollPane(text));
		dialog.setSizeWH(600, 400);
		AsWingUtils.centerLocate(dialog);
	}
	
	public function showCode(title:String, code:String):void{
		dialog.show();
		dialog.setTitle(title);
		text.setText(code);
	}
}
}