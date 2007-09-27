package {

import org.aswing.JWindow;
import org.aswing.AsWingManager;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import org.aswing.JTree;
import org.aswing.JPanel;
import org.aswing.JSplitPane;
import org.aswing.AssetPane;
import org.aswing.BorderLayout;
import flash.events.Event;
import org.aswing.VectorListModel;
import org.aswing.JOptionPane;
import org.aswing.guibuilder.model.FileModel;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.Definition;
import org.aswing.guibuilder.util.TextLoader;
import org.aswing.event.ListItemEvent;
import org.aswing.event.SelectionEvent;
import org.aswing.event.TreeSelectionEvent;
import org.aswing.border.BevelBorder;
import org.aswing.ASColor;
import org.aswing.guibuilder.model.ComDefinition;
import org.aswing.tree.TreePath;
import org.aswing.guibuilder.*;
import flash.filesystem.File;
import flash.filesystem.FileStream;
import flash.net.FileFilter;
import flash.filesystem.FileMode;
import org.aswing.JMenu;
import org.aswing.SoftBox;
import org.aswing.JMenuBar;
import org.aswing.JMenuItem;
import org.aswing.JSeparator;
import org.aswing.border.EmptyBorder;
import org.aswing.Insets;
import org.aswing.tree.DefaultTreeModel;
import org.aswing.tree.DefaultMutableTreeNode;
import org.aswing.tree.TreeModel;
import flash.system.fscommand;
import org.aswing.guibuilder.code.CodeGenerator;

public class Main extends JWindow{
	
	private var preview:Sprite;
	private var newMenu:JMenu;
	private var toolBarPane:ToolBarPane;
	private var filePane:FilePane;
	private var hiberarchyPane:HiberarchyPane;
	private var propertyPane:PropertyPane;
	private var componentMenu:ComponentMenu;
	
	private var emptyTreeModel:TreeModel;
	
	private var files:VectorListModel;
	private var curFile:FileModel;
	private var curCom:ComModel;
	private var workspacePath:String;
	
	public function Main(owner:DisplayObjectContainer){
		super(owner, false);
		AsWingManager.setRoot(this);
		
		emptyTreeModel = new DefaultTreeModel(new DefaultMutableTreeNode("Empty"));
		files = new VectorListModel();
		
		preview = new Sprite();
		preview.mouseEnabled = false;
		var previewPane:AssetPane = new AssetPane(preview);
		previewPane.setBackground(ASColor.GRAY.brighter());
		previewPane.setBorder(new BevelBorder(null, BevelBorder.LOWERED));
		
		toolBarPane = new ToolBarPane();
		toolBarPane.getSaveButton().setEnabled(false);
		var menuBar:JMenuBar = new JMenuBar();
		newMenu = new JMenu("New");
		menuBar.addMenu(newMenu);
		filePane = new FilePane();
		hiberarchyPane = new HiberarchyPane();
		propertyPane = new PropertyPane();
		componentMenu = new ComponentMenu();
		
		var pane:JPanel = new JPanel(new BorderLayout());
		var topBar:SoftBox = SoftBox.createHorizontalBox(2);
		topBar.setOpaque(true);
		topBar.setBorder(new EmptyBorder(null, new Insets(2, 4, 0, 0)));
		topBar.appendAll(menuBar, new JSeparator(JSeparator.VERTICAL), toolBarPane);
		pane.append(topBar, BorderLayout.NORTH);
		var centerCenter:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, previewPane, propertyPane);
		centerCenter.setResizeWeight(0.6);
		var center:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, filePane, centerCenter);
		center.setResizeWeight(0.2);
		center.setOneTouchExpandable(true);
		var main:JSplitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, false, center, hiberarchyPane);
		main.setResizeWeight(0.7);
		pane.append(main, BorderLayout.CENTER);
		
		setContentPane(pane);
		
		initModels();
		
		var file:File = File.applicationResourceDirectory;
		workspacePath = file.nativePath+"/workspace/";
		openFile = new File(workspacePath);
		openFile.addEventListener(Event.SELECT, __fileSelected);
	}
	
	private function initModels():void{
		new TextLoader("def.xml", __defLoaded).execute();
	}
	
	private function __defLoaded(text:String):void{
		if(text != null){
			filePane.getList().setModel(files);
			Definition.getIns().init(new XML(text));
			
			var components:Array = Definition.getIns().getComponents();
			componentMenu.setComponents(components);
			
			for(var i:int=0; i<components.length; i++){
				var cmp:ComDefinition = components[i];
				if(cmp.isContainer()){
					var menu:JMenuItem = newMenu.addMenuItem(cmp.getName());
					menu.addActionListener(__newPane);
					menu.putClientProperty("comDef", cmp);
				}
			}
			
			initHandlers();
		}else{
			JOptionPane.showMessageDialog("Error", "Can't find definition file!", null, this);
		}
	}
	
	private var curCreateComDef:ComDefinition;
	private function __newPane(e:Event):void{
		var menu:JMenuItem = e.currentTarget as JMenuItem;
		curCreateComDef = menu.getClientProperty("comDef");
		ClassNameChooser.getIns().open(__newComSelected);
	}
	
	private var cacheClassName:String;
	private var cachePkgName:String;
	private function __newComSelected(className:String, pkgName:String):void{
		if(isFileExists(className, pkgName)){
			JOptionPane.showMessageDialog("Error", "The name is already exists!", null, this);
			return;
		}
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
			return;
		}
		createNewFile(className, pkgName);
	}
	
	private function createNewFile(className:String, pkgName:String):void{
		files.append(new FileModel(new ComModel(curCreateComDef), className, pkgName), 0);
		setCurrentFile(files.first());
	}
	
	private function __override(result:int):void{
		if(result == JOptionPane.YES){
			createNewFile(cacheClassName, cachePkgName);
		}
	}
	
	private function initHandlers():void{
		toolBarPane.getSaveButton().addActionListener(__save);
		toolBarPane.getOpenButton().addActionListener(__open);
		toolBarPane.getCloseButton().addActionListener(__close);
		toolBarPane.getGenerateCodeButton().addActionListener(__generateCode);
		toolBarPane.getRevalidateButton().addActionListener(__revalidateSelection);
		filePane.getList().addEventListener(SelectionEvent.LIST_SELECTION_CHANGED, __fileSelection);
		hiberarchyPane.getAddChildButton().addActionListener(__addChildCom);
		hiberarchyPane.getAddBelowButton().addActionListener(__addChildComBelow);
		hiberarchyPane.getRemoveButton().addActionListener(__removeChildCom);
		hiberarchyPane.getUpButton().addActionListener(__upChildCom);
		hiberarchyPane.getDownButton().addActionListener(__downChildCom);
		hiberarchyPane.getLeftButton().addActionListener(__leftChildCom);
		hiberarchyPane.getRightButton().addActionListener(__rightChildCom);
		componentMenu.setItemSelectionHandler(__addChildComSelected);
		
		hiberarchyPane.getTree().setModel(emptyTreeModel);
		toolBarPane.getCloseButton().setEnabled(false);
		toolBarPane.getGenerateCodeButton().setEnabled(false);
	}
	
	private function __close(e:Event):void{
		if(curFile != null){
			files.remove(curFile);
			setCurrentFile(null);
		}
	}
	
	private function __revalidateSelection(e:Event):void{
		if(curCom != null){
			curCom.getDisplay().revalidate();
		}
	}
	
	private function __generateCode(e:Event):void{
		if(curFile != null){
			var generator:CodeGenerator = new CodeGenerator(curFile);
			var code:String = generator.generateCode();
			CodeWindow.getIns().showCode(
				curFile.getPackageName() + "." + curFile.getName(), 
				code);
		}
	}
	
	private function getXMLSavePath(className:String, pkgName:String):String{
		var pkg:String = pkgName.split(".").join("/");
		return workspacePath + pkg + "/" + className + ".xml";
	}
	
	private function __save(e:Event):void{
		if(curFile != null){
			var path:String = curFile.getFilePath();
			if(path == null){
				path = getXMLSavePath(curFile.getName(), curFile.getPackageName());
				curFile.setFilePath(path);
			}
			var saveFile:File = new File(path);
			var xml:XML = curFile.exportXML();
			
			var stream:FileStream = new FileStream();
			if(!saveFile.exists){
				trace("create new file");
			}
			stream.open(saveFile, FileMode.WRITE);
			stream.writeUTFBytes(xml.toXMLString());
			stream.close();
		}
	}
	
	private var openFile:File;
	private function __open(e:Event):void{
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
	
	private function __addChildComSelected(def:ComDefinition):void{
		if(curCom){
			if(isAddBelow || !curCom.isContainer()){
				var index:int = curCom.getParent().getChildIndex(curCom) + 1;
				curFile.addComponent(curCom.getParent(), new ComModel(def), index);
				var selRow:int = hiberarchyPane.getTree().getSelectionRows()[0];
				hiberarchyPane.getTree().setSelectionRow(selRow+1);
			}else{
				curFile.addComponent(curCom, new ComModel(def));
				hiberarchyPane.getTree().expandPath(new TreePath(curFile.getPath(curCom)));
			}
		}
	}
	
	private var isAddBelow:Boolean = false;
	private function __addChildCom(e:Event):void{
		isAddBelow = false;
		componentMenu.show(hiberarchyPane.getAddChildButton(), 0, 0);
	}
	
	private function __addChildComBelow(e:Event):void{
		isAddBelow = true;
		componentMenu.show(hiberarchyPane.getAddBelowButton(), 0, 0);
	}
	
	private function __removeChildCom(e:Event):void{		
		if(curCom){
			if(curCom == curFile.getRoot()){
				JOptionPane.showMessageDialog("Tip", "Can't delete root component!", null, this);
			}else{
				var parent:ComModel = curCom.getParent();
				curFile.removeComponent(curCom);
				hiberarchyPane.getTree().setSelectionPath(new TreePath(curFile.getPath(parent)));
			}
		}
	}
	private function __upChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var par:ComModel = curCom.getParent();
		var index:int = par.getChildIndex(mod);
		var path:TreePath = hiberarchyPane.getTree().getSelectionPath();
		curFile.removeComponent(mod);
		curFile.addComponent(par, mod, index-1);
		hiberarchyPane.getTree().setSelectionPath(path);
	}
	private function __downChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var par:ComModel = curCom.getParent();
		var index:int = par.getChildIndex(mod);
		var path:TreePath = hiberarchyPane.getTree().getSelectionPath();
		curFile.removeComponent(mod);
		index++;
		if(index > par.getChildCount()){
			index=0;
		}
		curFile.addComponent(par, mod, index);
		hiberarchyPane.getTree().setSelectionPath(path);
	}
	private function __leftChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var leftPar:ComModel = getLeftContainer(mod);
		if(leftPar != null){
			curFile.removeComponent(mod);
			curFile.addComponent(leftPar, mod);
		}
	}
	private function __rightChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var rightPar:ComModel = this.getRightContainer(mod);
		if(rightPar != null){
			curFile.removeComponent(mod);
			curFile.addComponent(rightPar, mod);
		}
	}
	
	private function __fileSelection(e:SelectionEvent):void{
		setCurrentFile(filePane.getList().getSelectedValue());
	}
	
	private function __comSelection(e:TreeSelectionEvent):void{
		if(hiberarchyPane.getTree().getSelectionPath() != null){
			setCurrentCom(hiberarchyPane.getTree().getSelectionPath().getLastPathComponent());
		}else{
			setCurrentCom(null);
		}
	}
		
	private function isFileExists(name:String, pkg:String):Boolean{
		for(var i:int=0; i<files.size(); i++){
			var f:FileModel = files.get(i);
			if(f.getName() == name && f.getPackageName() == pkg){
				return true;
			}
		}
		return false;
	}
	
	private function createPanelModel():ComModel{
		return new ComModel(Definition.getIns().getComDefinition("JPanel"));
	}
	
	private function setCurrentFile(file:FileModel):void{
		toolBarPane.getCloseButton().setEnabled(file != null);
		toolBarPane.getSaveButton().setEnabled(file != null);
		toolBarPane.getGenerateCodeButton().setEnabled(file != null);
		if(curFile != file){
			curFile = file;
			filePane.getList().setSelectedValue(file);
			if(preview.numChildren > 0){
				preview.removeChildAt(0);
			}
			if(file != null){
				hiberarchyPane.getTree().setModel(file);
				preview.addChild(file.getDisplay());
				file.revalidate();
			}else{
				hiberarchyPane.getTree().setModel(emptyTreeModel);
			}
			setCurrentCom(null);
			if(file != null){
				hiberarchyPane.getTree().addEventListener(TreeSelectionEvent.TREE_SELECTION_CHANGED, __comSelection);
				hiberarchyPane.getTree().setSelectionRow(0);
			}else{
				hiberarchyPane.getTree().removeEventListener(TreeSelectionEvent.TREE_SELECTION_CHANGED, __comSelection);
			}
		}
	}
	
	private function setCurrentCom(comModel:ComModel):void{
		this.curCom = comModel;
		propertyPane.setModel(comModel);
		hiberarchyPane.setOperatable(comModel != null);
		if(comModel != null){
			if(comModel == curFile.getRoot()){
				hiberarchyPane.setOperatable(false);
				hiberarchyPane.getAddChildButton().setEnabled(true);
			}
			
			hiberarchyPane.getAddChildButton().setEnabled(curCom.isContainer());
			
			if(getLeftContainer(curCom) != null){
				hiberarchyPane.getLeftButton().setEnabled(true);
			}else{
				hiberarchyPane.getLeftButton().setEnabled(false);
			}
			
			if(getRightContainer(curCom) != null){
				hiberarchyPane.getRightButton().setEnabled(true);
			}else{
				hiberarchyPane.getRightButton().setEnabled(false);
			}
			
			hiberarchyPane.revalidate();
		}
	}
	
	private function getLeftContainer(c:ComModel):ComModel{
		var parent:ComModel = curCom.getParent();
		if(parent != null){
			return parent.getParent();
		}
		return null;
	}
	
	private function getRightContainer(c:ComModel):ComModel{
		var parent:ComModel = curCom.getParent();
		if(parent != null){
			var n:int = parent.getChildCount();
			for(var i:int=0; i<n; i++){
				if(parent.getChild(i).isContainer()){
					return parent.getChild(i);
				}
			}
		}
		return null;
	}
}
}