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

public class Main extends JWindow{
	
	private var preview:Sprite;
	private var toolBarPane:ToolBarPane;
	private var filePane:FilePane;
	private var hiberarchyPane:HiberarchyPane;
	private var propertyPane:PropertyPane;
	
	private var files:VectorListModel;
	
	public function Main(owner:DisplayObjectContainer){
		super(owner, false);
		AsWingManager.setRoot(this);
		
		files = new VectorListModel();
		
		preview = new Sprite();
		preview.mouseEnabled = false;
		var previewPane:AssetPane = new AssetPane(preview);
		
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
		
		initHandlers();
	}
	
	private function initModels():void{
		filePane.getList().setModel(files);
	}
	
	private function initHandlers():void{
		toolBarPane.getNewPanelButton().addActionListener(__newPanel);
	}
	
	private function __newPanel(e:Event):void{
		
	}
}
}