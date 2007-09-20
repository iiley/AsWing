package org.aswing.guibuilder{

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

public class Main extends JWindow{
	
	private var preview:Sprite;
	private var toolBarPane:ToolBarPane;
	private var filePane:FilePane;
	private var hiberarchyPane:HiberarchyPane;
	private var propertyPane:PropertyPane;
	
	private var files:VectorListModel;
	private var curFile:FileModel;
	private var curCom:ComModel;
	
	public function Main(owner:DisplayObjectContainer){
		super(owner, false);
		AsWingManager.setRoot(this);
		
		files = new VectorListModel();
		
		preview = new Sprite();
		preview.mouseEnabled = false;
		var previewPane:AssetPane = new AssetPane(preview);
		previewPane.setBackground(ASColor.GRAY.brighter());
		previewPane.setBorder(new BevelBorder(null, BevelBorder.LOWERED));
		
		toolBarPane = new ToolBarPane();
		filePane = new FilePane();
		hiberarchyPane = new HiberarchyPane();
		propertyPane = new PropertyPane();
		
		var pane:JPanel = new JPanel(new BorderLayout());
		pane.append(toolBarPane, BorderLayout.NORTH);
		var centerCenter:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, previewPane, propertyPane);
		centerCenter.setResizeWeight(0.7);
		var center:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, filePane, centerCenter);
		center.setResizeWeight(0.2);
		center.setOneTouchExpandable(true);
		var main:JSplitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, false, center, hiberarchyPane);
		main.setResizeWeight(0.7);
		pane.append(main, BorderLayout.CENTER);
		
		setContentPane(pane);
		
		initModels();
	}
	
	private function initModels():void{
		new TextLoader("def.xml", __defLoaded).execute();
	}
	
	private function __defLoaded(text:String):void{
		if(text != null){
			filePane.getList().setModel(files);
			Definition.getIns().init(new XML(text));
			
			initHandlers();
		}else{
			JOptionPane.showMessageDialog("Error", "Can't find definition file!", null, this);
		}
	}
	
	private function initHandlers():void{
		toolBarPane.getNewPanelButton().addActionListener(__newPanel);
		filePane.getList().addEventListener(SelectionEvent.LIST_SELECTION_CHANGED, __fileSelection);
		hiberarchyPane.getAddButton().addActionListener(__addChildCom);
		hiberarchyPane.getRemoveButton().addActionListener(__removeChildCom);
		hiberarchyPane.getUpButton().addActionListener(__upChildCom);
		hiberarchyPane.getDownButton().addActionListener(__downChildCom);
	}
	
	private function __addChildCom(e:Event):void{
		
	}
	private function __removeChildCom():void{
		
	}
	private function __upChildCom():void{
		
	}
	private function __downChildCom():void{
		
	}
	
	private function __fileSelection(e:SelectionEvent):void{
		setCurrentFile(filePane.getList().getSelectedValue());
	}
	
	private function __comSelection(e:TreeSelectionEvent):void{
		setCurrentCom(e.getPath().getLastPathComponent());
	}
	
	private function __newPanel(e:Event):void{
		JOptionPane.showInputDialog("New Panel", "Please input the name:", __newPanelInputed, "MyPanel", this);
	}
	
	private function __newPanelInputed(text:String):void{
		if(text == "" || text == null){
			return;
		}
		for(var i:int=0; i<files.size(); i++){
			var f:FileModel = files.get(i);
			if(f.getName() == text){
				JOptionPane.showMessageDialog("Error", "The name is already exists!", null, this);
				return;
			}
		}
		files.append(new FileModel(createPanelModel(), text), 0);
		setCurrentFile(files.first());
	}
	
	private function createPanelModel():ComModel{
		return new ComModel(Definition.getIns().getComDefinition("JPanel"));
	}
	
	private function setCurrentFile(file:FileModel):void{
		if(curFile != file){
			curFile = file;
			filePane.getList().setSelectedValue(file);
			hiberarchyPane.getTree().setModel(file);
			if(preview.numChildren > 0){
				preview.removeChildAt(0);
			}
			preview.addChild(file.getDisplay());
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
		propertyPane.setComModel(comModel);
		hiberarchyPane.setOperatable(comModel != null);
	}
}
}