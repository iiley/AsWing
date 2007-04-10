package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.tree.TreePath;
import org.aswing.plaf.basic.tree.ExpandControl;
import org.aswing.geom.IntRectangle;
import org.aswing.Component;
import org.aswing.plaf.UIResource;
import flash.display.DisplayObject;
import org.aswing.graphics.BitmapBrush;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

public class SkinTreeExpandControl implements ExpandControl, UIResource{
	
	protected var leafControlImage:DisplayObject;
	protected var folderExpandedControlImage:DisplayObject;
	protected var folderCollapsedControlImage:DisplayObject;
	protected var loaded:Boolean = false;
	protected var leafBitmapBuffer:BitmapData;
	protected var expandedBitmapBuffer:BitmapData;
	protected var collapsedBitmapBuffer:BitmapData;
	
	public function SkinTreeExpandControl(){
		leafBitmapBuffer = new BitmapData(1, 1, true, 0x00000000);
		expandedBitmapBuffer = new BitmapData(1, 1, true, 0x00000000);
		collapsedBitmapBuffer = new BitmapData(1, 1, true, 0x00000000);
	}
	
	public function paintExpandControl(c:Component, g:Graphics2D, bounds:IntRectangle, 
		totalChildIndent:int, path:TreePath, row:int, expanded:Boolean, leaf:Boolean):void{
		if(!loaded){
			leafControlImage = c.getUI().getInstance("Tree.leafControlImage") as DisplayObject;
			folderExpandedControlImage = c.getUI().getInstance("Tree.folderExpandedControlImage") as DisplayObject;
			folderCollapsedControlImage = c.getUI().getInstance("Tree.folderCollapsedControlImage") as DisplayObject;
			loaded = true;
		}
		
		var x:int = bounds.x - totalChildIndent;
		var y:int = bounds.y;
		var w:int = bounds.width;
		var h:int = bounds.height;
		var matrix:Matrix = new Matrix();
		matrix.translate(x, y);
		if(leaf){
			w = leafControlImage.width;
			if(w != leafBitmapBuffer.width || h != leafBitmapBuffer.height){
				leafControlImage.width = w;
				leafControlImage.height = h;
				leafBitmapBuffer = new BitmapData(w, h, true, 0x00000000);
				leafBitmapBuffer.draw(leafControlImage);
			}
			g.beginFill(new BitmapBrush(leafBitmapBuffer, matrix, false));
		}else if(expanded){
			w = folderExpandedControlImage.width;
			if(w != expandedBitmapBuffer.width || h != expandedBitmapBuffer.height){
				folderExpandedControlImage.width = w;
				folderExpandedControlImage.height = h;
				expandedBitmapBuffer = new BitmapData(w, h, true, 0x00000000);
				expandedBitmapBuffer.draw(folderExpandedControlImage);
			}
			g.beginFill(new BitmapBrush(expandedBitmapBuffer, matrix, false));
		}else{
			w = folderCollapsedControlImage.width;
			if(w != collapsedBitmapBuffer.width || h != collapsedBitmapBuffer.height){
				folderCollapsedControlImage.width = w;
				folderCollapsedControlImage.height = h;
				collapsedBitmapBuffer = new BitmapData(w, h, true, 0x00000000);
				collapsedBitmapBuffer.draw(folderCollapsedControlImage);
			}
			g.beginFill(new BitmapBrush(collapsedBitmapBuffer, matrix, false));
		}
		g.rectangle(x, y, w, h);
		g.endFill();
	}
	
}
}