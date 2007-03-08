/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table { 
	
import org.aswing.Component;
import org.aswing.geom.*;
import org.aswing.JLabel;
import org.aswing.JTable;
import org.aswing.table.TableCell;

/**
 * Default table cell to render text
 * @author iiley
 */
public class DefaultTextCell extends JLabel implements TableCell{
	
	protected var value:*;
	
	public function DefaultTextCell(){
		super();
		setHorizontalAlignment(LEFT);
		setOpaque(true);
	}
	
	/**
	 * Simpler this method to speed up performance
	 */
	/*public function setBounds(b:Rectangle):void{
		if(!b.equals(bounds)){
			if(b.width != bounds.width || b.height != bounds.height){
				repaint();
			}
			bounds.setRect(b);
			valid = false;
		}
	}*/
	/**
	 * Simpler this method to speed up performance
	 */
	/*public function invalidate():void {
		valid = false;
	}*/
	/**
	 * Simpler this method to speed up performance
	 */
	/*public function revalidate():void {
		valid = false;
	}*/
	
	//**********************************************************
	//				  Implementing TableCell
	//**********************************************************
	public function setCellValue(value:*) : void {
		this.value = value;
		setText(value.toString());
	}
	
	public function getCellValue():*{
		return value;
	}
	
	public function setTableCellStatus(table:JTable, isSelected:Boolean, row:int, column:int):void{
		if(isSelected){
			setBackground(table.getSelectionBackground());
			setForeground(table.getSelectionForeground());
		}else{
			setBackground(table.getBackground());
			setForeground(table.getForeground());
		}
		setFont(table.getFont());
	}
	
	public function getCellComponent() : Component {
		return this;
	}
	
	override public function toString():String{
		return "TextCell[label:" + super.toString() + "]\n";
	}
}
}