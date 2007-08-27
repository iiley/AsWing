package org.aswing.guibuilder{

import org.aswing.JWindow;
import org.aswing.AsWingManager;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import org.aswing.JTree;
import org.aswing.JPanel;
import org.aswing.JSplitPane;
import org.aswing.AssetPane;

public class Main extends JWindow{
	
	private var preview:Sprite;
	private var hiberarchyPane:HiberarchyPane;
	private var propertyPane:PropertyPane;
	
	public function Main(owner:DisplayObjectContainer){
		super(owner, false);
		AsWingManager.setRoot(this);
		
		preview = new Sprite();
		preview.mouseEnabled = false;
		var previewPane:AssetPane = new AssetPane(preview);
		
		hiberarchyPane = new HiberarchyPane();
		propertyPane = new PropertyPane();
		
		bottom = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, hiberarchyPane, propertyPane);
		
		pane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, false, previewPane, bottom);
		setContentPane(pane);
	}
	
}
}