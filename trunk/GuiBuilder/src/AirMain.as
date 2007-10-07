package{

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.FileFilter;

import org.aswing.JOptionPane;
import org.aswing.ListModel;
import org.aswing.guibuilder.*;
import org.aswing.guibuilder.model.FileModel;

public class AirMain extends Main{
	
	private var openFile:File;
	
	public function AirMain(owner:DisplayObjectContainer){
		super(owner);
		
		var file:File = File.applicationResourceDirectory;
		rootPath = file.nativePath+"/";
		workspacePath = rootPath+"workspace/";
		openFile = new File(workspacePath);
		openFile.addEventListener(Event.SELECT, __fileSelected);		
	}
	
	override protected function checkIsExists(className:String, pkgName:String):Boolean{
		var path:String = getXMLSavePath(className, pkgName);
		var file:File = new File(path);
		if(file.exists){
			cacheClassName = className;
			cachePkgName = pkgName;
			JOptionPane.showMessageDialog(
				"Warnning", 
				"Same name file is already exists! Override it?", 
				__override, this, true, null, 
				JOptionPane.YES|JOptionPane.CANCEL);
			return true;
		}
		return false;
	}
	
	override protected function save(file:FileModel):void{
		var path:String = file.getFilePath();
		if(path == null){
			path = getXMLSavePath(file.getName(), file.getPackageName());
			file.setFilePath(path);
		}
		var saveFile:File = new File(path);
		var xml:XML = file.exportXML();
		
		var stream:FileStream = new FileStream();
		if(!saveFile.exists){
			trace("create new file");
		}
		stream.open(saveFile, FileMode.WRITE);
		stream.writeUTFBytes(xml.toXMLString());
		stream.close();
	}
	
	override protected function open():void{
		openFile.browseForOpen("Select a UI xml file", [new FileFilter("AsWing UI (*.xml)", "*.xml")]);
	}
	
	private function __fileSelected(e:Event):void{
		trace("__fileSelected : " + openFile.nativePath);
		var stream:FileStream = new FileStream();
		stream.open(openFile, FileMode.READ);
		var str:String = stream.readUTFBytes(stream.bytesAvailable);
		stream.close();
		var xml:XML = new XML(str);
		if(isFileExists(xml.@name, xml.@packageName)){
			JOptionPane.showMessageDialog("Error", "The same name file is already opened!", null, this);
			return;
		}
		var fm:FileModel = FileModel.parseXML(xml);
		fm.setFilePath(openFile.nativePath);
		files.append(fm, 0);
		setCurrentFile(files.first());
	}
	
	override protected function loadSetting():void{
		var loadFile:File = new File(rootPath+"option.txt");
		if(loadFile.exists){
			var stream:FileStream = new FileStream();
			stream.open(loadFile, FileMode.READ);
			var str:String = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			var xml:XML = new XML(str);
			if(xml.LAF != null){
				var lafName:String = xml.LAF.@name;
				var model:ListModel = toolBarPane.getLAFsCombo().getModel();
				for(var i:int=0; i<model.getSize(); i++){
					var info:LookAndFeelInfo = model.getElementAt(i) as LookAndFeelInfo;
					if(info.getName() == lafName){
						toolBarPane.getLAFsCombo().setSelectedItem(info);
						return;
					}
				}
			}
		}
	}
	
	override protected function saveSetting():void{
		var saveFile:File = new File(rootPath+"option.txt");
		var xml:XML = <Option></Option>;
		var laf:XML = <LAF></LAF>;
		var lafName:String = "";
		if(toolBarPane.getLAFsCombo().getSelectedItem() != null){
			var info:LookAndFeelInfo = toolBarPane.getLAFsCombo().getSelectedItem() as LookAndFeelInfo;
			lafName = info.getName();
		}
		laf.@name = lafName;
		xml.appendChild(laf)
		
		var stream:FileStream = new FileStream();
		stream.open(saveFile, FileMode.WRITE);
		stream.writeUTFBytes(xml.toXMLString());
		stream.close();
	}	
}
}