package org.aswing.guibuilder.model{

import flash.display.DisplayObject;
import flash.display.Sprite;	

/**
 * UI File Model
 * @author iiley
 */
public class FileModel{
	
	private var name:String;
	private var root:ComModel;
	private var canvas:Sprite;
	
	public function FileModel(root:ComModel, name:String){
		this.root = root;
		this.name = name;
		canvas = new Sprite();
		canvas.mouseEnabled = false;
		canvas.addChild(root.getDisplay());
	}
	
	public function getDisplay():DisplayObject{
		return canvas;
	}
	
	public function getRoot():ComModel{
		return root;
	}
	
	public function getName():String{
		return name;
	}
	
	public function toString():String{
		return name;
	}
}
}