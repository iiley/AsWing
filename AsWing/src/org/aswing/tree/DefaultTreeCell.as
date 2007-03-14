/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree { 

import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.Icon;
import org.aswing.JLabel;
import org.aswing.JTree;
import org.aswing.tree.TreeCell;
import org.aswing.tree.TreeFolderIcon;
import org.aswing.tree.TreeLeafIcon;

/**
 * @author iiley
 */
public class DefaultTreeCell extends JLabel implements TreeCell {
	
	private static var EXPANDED_FOLDER_ICON:Icon;
	private static var COLLAPSED_FOLDER_ICON:Icon;
	private static var LEAF_ICON:Icon;
	
	private var value:*;
	
	public function DefaultTreeCell(){
		super();
		setHorizontalAlignment(LEFT);
		setOpaque(true);
		
		if(EXPANDED_FOLDER_ICON == undefined){
			EXPANDED_FOLDER_ICON = new TreeFolderIcon();
			COLLAPSED_FOLDER_ICON = EXPANDED_FOLDER_ICON;
			LEAF_ICON = new TreeLeafIcon();
		}
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function setComBounds(b:IntRectangle):void{
		if(!b.equals(bounds)){
			bounds.setRect(b);
			locate();
	    	valid = false;
		}
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	override public function invalidate():void {
		clearPreffeSizeCaches();
    	valid = false;
    }
    
    /**
	 * Simpler this method to speed up performance
	 */
    override public function revalidate():void {
    	valid = false;
    }
    
    /**
     * do nothing, because paintImmediately will be called in by Tree
     * @see #paintImmediately()
     */
    override public function repaint():void{
    	//do nothing, because paintImmediately will be called in by Tree
    }
    
    public function getExpandedFolderIcon():Icon{
    	return EXPANDED_FOLDER_ICON;
    }
    public function getCollapsedFolderIcon():Icon{
    	return COLLAPSED_FOLDER_ICON;
    }
    public function getLeafIcon():Icon{
    	return LEAF_ICON;
    }
    
	//**********************************************************
	//                  Implementing TableCell
	//**********************************************************
	public function setCellValue(value:*) : void {
		this.value = value;
		setText(value.toString());
	}
	
	public function getCellValue():*{
		return value;
	}
	
	public function setTreeCellStatus(tree : JTree, selected : Boolean, expanded : Boolean, leaf : Boolean, row : int) : void {
		if(selected){
			setBackground(tree.getSelectionBackground());
			setForeground(tree.getSelectionForeground());
		}else{
			setBackground(tree.getBackground());
			setForeground(tree.getForeground());
		}
		setFont(tree.getFont());
		if(leaf){
			setIcon(getLeafIcon());
		}else if(expanded){
			setIcon(getExpandedFolderIcon());
		}else{
			setIcon(getCollapsedFolderIcon());
		}
	}
	
	public function getCellComponent() : Component {
		return this;
	}
	
	override public function toString():String{
		return "TreeCell[label:" + super.toString() + "]\n";
	}
}
}