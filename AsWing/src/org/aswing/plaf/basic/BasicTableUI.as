/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic { 

import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;
import org.aswing.table.*;
import org.aswing.event.*;
import flash.ui.Keyboard;
import flash.events.MouseEvent;
import flash.events.Event;

/**
 * @author iiley
 */
public class BasicTableUI extends BaseComponentUI implements TableUI{
	
	private var table:JTable;
	
	public function BasicTableUI() {
		super();
		focusRow = 0;
		focusColumn = 0;
	}
	
	override public function installUI(c:Component):void {
		table = JTable(c);
		installDefaults();
		installListeners();
	}
	
	protected function getPropertyPrefix():String {
		return "Table.";
	}
	
	protected function installDefaults():void {
		var pp:String = getPropertyPrefix();
		LookAndFeel.installColorsAndFont(table, pp);
		LookAndFeel.installBorderAndBFDecorators(table, pp);
		LookAndFeel.installBasicProperties(table, pp);
		
		var sbg:ASColor = table.getSelectionBackground();
		if (sbg == null || sbg is UIResource) {
			table.setSelectionBackground(getColor(pp+"selectionBackground"));
		}

		var sfg:ASColor = table.getSelectionForeground();
		if (sfg == null || sfg is UIResource) {
			table.setSelectionForeground(getColor(pp+"selectionForeground"));
		}

		var gridColor:ASColor = table.getGridColor();
		if (gridColor == null || gridColor is UIResource) {
			table.setGridColor(getColor(pp+"gridColor"));
		}
	}
	
	protected function installListeners():void{
		table.addEventListener(MouseEvent.MOUSE_DOWN, __onTablePress);
		table.addEventListener(ReleaseEvent.RELEASE, __onTableRelease);
		//TODO imp clicked
		//tableListener[JTable.ON_CLICKED] = Delegate.create(this, __onTableClicked);
		table.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onTableKeyDown);
		table.addEventListener(MouseEvent.MOUSE_WHEEL, __onTableMouseWheel);
	}
	
	override public function uninstallUI(c:Component):void {
		uninstallDefaults();
		uninstallListeners();
	}
	
	protected function uninstallDefaults():void {
		LookAndFeel.uninstallBorderAndBFDecorators(table);
	}
	
	protected function uninstallListeners():void{
		table.removeEventListener(MouseEvent.MOUSE_DOWN, __onTablePress);
		table.removeEventListener(ReleaseEvent.RELEASE, __onTableRelease);
		table.removeEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __onTableKeyDown);
		table.removeEventListener(MouseEvent.MOUSE_WHEEL, __onTableMouseWheel);
		table.removeEventListener(MouseEvent.MOUSE_MOVE, __onTableMouseMove);
	}
	
	protected function __onTablePress(e:Event):void{
		selectMousePointed();
		table.addEventListener(MouseEvent.MOUSE_MOVE, __onTableMouseMove);
		var editor:TableCellEditor = table.getCellEditor();
		if(editor != null && editor.isCellEditing()){
			table.getCellEditor().stopCellEditing();
		}
	}
	
	private function __onTableClicked(source:JTable, clickCount:int):void{
		var p:IntPoint = getMousePosOnTable();
		var row:int = table.rowAtPoint(p);
		var column:int = table.columnAtPoint(p);
		if(table.editCellAt(row, column, clickCount)){
		}
	}
	
	private function __onTableRelease(e:Event):void{
		table.removeEventListener(MouseEvent.MOUSE_MOVE, __onTableMouseMove);
	}
	
	private function __onTableMouseMove(e:Event):void{
		addSelectMousePointed();
	}
	
	private function __onTableMouseWheel(e:MouseEvent):void{
		if(!table.isEnabled()){
			return;
		}
		var viewPos:IntPoint = table.getViewPosition();
		viewPos.y -= e.delta*table.getVerticalUnitIncrement();
		table.setViewPosition(viewPos);
	}
	
	private function selectMousePointed():void{
		var p:IntPoint = getMousePosOnTable();
		var row:int = table.rowAtPoint(p);
		var column:int = table.columnAtPoint(p);
		if ((column == -1) || (row == -1)) {
			return;
		}
		makeSelectionChange(row, column);
	}
	
	private function addSelectMousePointed():void{
		var p:IntPoint = getMousePosOnTable();
		var row:int = table.rowAtPoint(p);
		var column:int = table.columnAtPoint(p);
		if ((column == -1) || (row == -1)) {
			return;
		}
		table.changeSelection(row, column, false, true);
	}
	
	private function makeSelectionChange(row:int, column:int):void {
		recordFocusIndecis(row, column);
		var ctrl:Boolean = KeyboardManager.getInstance().isKeyDown(getAdditionSelectionKey());
		var shift:Boolean = KeyboardManager.getInstance().isKeyDown(getIntervalSelectionKey());

		// Apply the selection state of the anchor to all cells between it and the
		// current cell, and then select the current cell.
		// For mustang, where API changes are allowed, this logic will moved to
		// JTable.changeSelection()
		if (ctrl && shift) {
			var rm:ListSelectionModel = table.getSelectionModel();
			var cm:ListSelectionModel = table.getColumnModel().getSelectionModel();
			var anchorRow:int = rm.getAnchorSelectionIndex();
			var anchorCol:int = cm.getAnchorSelectionIndex();

			if (table.isCellSelected(anchorRow, anchorCol)) {
				rm.addSelectionInterval(anchorRow, row);
				cm.addSelectionInterval(anchorCol, column);
			} else {
				rm.removeSelectionInterval(anchorRow, row);
				rm.addSelectionInterval(row, row);
				rm.setAnchorSelectionIndex(anchorRow);
				cm.removeSelectionInterval(anchorCol, column);
				cm.addSelectionInterval(column, column);
				cm.setAnchorSelectionIndex(anchorCol);
			}
		} else {
			table.changeSelection(row, column, ctrl, !ctrl && shift);
		}
	}	
	
	private function changeSelection(rowIndex:int, columnIndex:int, toggle:Boolean, extend:Boolean):void{
		recordFocusIndecis(rowIndex, columnIndex);
		table.changeSelection(rowIndex, columnIndex, toggle, extend);
	}
	
	private function getMousePosOnTable():IntPoint{
		var p:IntPoint = table.getMousePosition();
		return table.getLogicLocationFromPixelLocation(p);
	}
	
	private function getIntervalSelectionKey():uint{
		return Keyboard.SHIFT;
	}
	private function getAdditionSelectionKey():uint{
		return Keyboard.CONTROL;
	}	
	private function getEditionKey():uint{
		return Keyboard.ENTER;
	}
	private function getSelectionKey():uint{
		return Keyboard.SPACE;
	}
		
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
		super.paint(c, g, b);
		//table.clearChildrenGraphics();
		//g = table.getChildrenGraphics();
		var rowCount:int = table.getRowCount();
		var columnCount:int = table.getColumnCount();
		if (rowCount <= 0 || columnCount <= 0) {
			return;
		}
		var extentSize:IntDimension = table.getExtentSize();
		var viewPos:IntPoint = table.getViewPosition();
		viewPos.x = Math.round(viewPos.x);
		viewPos.y = Math.round(viewPos.y);
		var startX:int = Math.round(b.x - viewPos.x);
		var startY:int = Math.round(b.y - viewPos.y + table.getHeaderHeight());
				
		var vb:IntRectangle = new IntRectangle();
		vb.setSize(extentSize);
		vb.setLocation(viewPos);
		var upperLeft:IntPoint = vb.getLocation();
		var lowerRight:IntPoint = vb.rightBottom();
		var rMin:int = table.rowAtPoint(upperLeft);
		var rMax:int = table.rowAtPoint(lowerRight);
		if (rMin == -1) {
			rMin = 0;
		}
		if (rMax == -1) {
			rMax = rowCount - 1;
		}
		var cMin:int = table.columnAtPoint(upperLeft);
		var cMax:int = table.columnAtPoint(lowerRight);
		if (cMin == -1) {
			cMin = 0;
		}
		if (cMax == -1) {
			cMax = columnCount - 1;
		}
		
		var minCell:IntRectangle = table.getCellRect(rMin, cMin, true);
		var maxCell:IntRectangle = table.getCellRect(rMax, cMax, true);
		var damagedArea:IntRectangle = minCell.union(maxCell);
		damagedArea.setLocation(damagedArea.getLocation().move(startX, startY));
		
		var pen:Pen = new Pen(table.getGridColor(), 1);
		var brush:IBrush = new SolidBrush(table.getSelectionBackground());
		if (table.getShowHorizontalLines()) {
			var x1:Number = damagedArea.x + 0.5;
			var x2:Number = damagedArea.x + damagedArea.width - 1;
			var y:Number = damagedArea.y + 0.5;
			
			g.drawLine(pen, x1, y, x2, y);
			var rh:int = table.getRowHeight();
			for (var row:Number = rMin; row <= rMax; row++) {
				y += rh;
				if(row == rowCount - 1){
					y -= 1;
				}
				g.drawLine(pen, x1, y, x2, y);
			}
		}
		if (table.getShowVerticalLines()) {
			var cm:TableColumnModel = table.getColumnModel();
			var x:Number = damagedArea.x + 0.5;
			var y1:Number = damagedArea.y + 0.5;
			var y2:Number = y1 + damagedArea.height -1;
			g.drawLine(pen, x, y1, x, y2);
			for (var column:Number = cMin; column <= cMax; column++) {
				var w:Number = cm.getColumn(column).getWidth();
				x += w;
				if(column == columnCount - 1){
					x -= 1;
				}
				g.drawLine(pen, x, y1, x, y2);
			}
		}		
	}	
	//******************************************************************
	//						Focus and Keyboard control
	//******************************************************************
	private function __onTableKeyDown(e:FocusKeyEvent):void{
		if(!table.isEnabled()){
			return;
		}
		var rDir:Number = 0;
		var cDir:Number = 0;
		var code:uint = e.keyCode;
		if(code == Keyboard.LEFT){
			cDir = -1;
		}else if(code == Keyboard.RIGHT){
			cDir = 1;
		}else if(code == Keyboard.UP){
			rDir = -1;
		}else if(code == Keyboard.DOWN){
			rDir = 1;
		}
		if(cDir != 0 || rDir != 0){
			moveFocus(rDir, cDir);
			FocusManager.getCurrentManager().setTraversing(true);
			table.paintFocusRect();
			return;
		}
		if(code == getSelectionKey()){
			table.changeSelection(focusRow, focusColumn, true, false);
		}else if(code == getEditionKey()){
			table.editCellAt(focusRow, focusColumn, -1);
		}
	}
	
	private function recordFocusIndecis(row:int, column:int):void{
		focusRow = row;
		focusColumn = column;
	}
	
	private function restrictRow(row:int):int{
		return Math.max(0, Math.min(table.getRowCount()-1, row));;
	}
	
	private function restrictColumn(column:int):int{
		return Math.max(0, Math.min(table.getColumnCount()-1, column));
	}
	
	private function moveFocus(rDir:Number, cDir:Number):void{
		var ctrl:Boolean = KeyboardManager.getInstance().isKeyDown(getAdditionSelectionKey());
		var shift:Boolean = KeyboardManager.getInstance().isKeyDown(getIntervalSelectionKey());
		var rm:ListSelectionModel = table.getSelectionModel();
		var cm:ListSelectionModel = table.getColumnModel().getSelectionModel();
		var anchorRow:Number = rm.getAnchorSelectionIndex();
		var anchorCol:Number = cm.getAnchorSelectionIndex();
		
		var oldRow:Number = restrictRow(focusRow);
		var oldColumn:Number = restrictColumn(focusColumn);
		focusRow += rDir;
		focusRow = restrictRow(focusRow);
		focusColumn += cDir;
		focusColumn = restrictColumn(focusColumn);
		
		if(!ctrl){
			changeSelection(focusRow, focusColumn, ctrl, !ctrl && shift);
		}
		table.ensureCellIsVisible(focusRow, focusColumn);
	}
	
	private var focusRow:int;
	private var focusColumn:int;

	override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):void{
		paintCurrentCellFocus(g);
	}
	
	private function paintCurrentCellFocus(g:Graphics2D):void{
		paintCellFocusWithRowColumn(g, focusRow, focusColumn);
	}
	
	protected function paintCellFocusWithRowColumn(g:Graphics2D, row:int, column:int):void{
		var rect:IntRectangle = table.getCellRect(row, column, true);
		rect.setLocation(table.getPixelLocationFromLogicLocation(rect.getLocation()));
		g.drawRectangle(new Pen(getDefaultFocusColorOutter(), 2), rect.x, rect.y, rect.width, rect.height);
	}

	//******************************************************************
	//							 Size Methods
	//******************************************************************

	protected function createTableSize(width:int):IntDimension {
		var height:int = 0;
		var rowCount:int = table.getRowCount();
		if (rowCount > 0 && table.getColumnCount() > 0) {
			var r:IntRectangle = table.getCellRect(rowCount - 1, 0, true);
			height = r.y + r.height;
		}
		height += table.getTableHeader().getPreferredHeight();
		return new IntDimension(width, height);
	}
		
	/**
	 * Returns the view size.
	 */	
	public function getViewSize(table:JTable):IntDimension{
		var width:int = 0;
		var enumeration:Array = table.getColumnModel().getColumns();
		for(var i:int=0; i<enumeration.length; i++){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getPreferredWidth();
		}
		
		var d:IntDimension = createTableSize(width);
		if(table.getAutoResizeMode() != JTable.AUTO_RESIZE_OFF){
			d.width = table.getExtentSize().width;
		}else{
			d.width = table.getColumnModel().getTotalColumnWidth();
		}
		d.height -= table.getTableHeader().getHeight();
				
		return d;
	}

	/**
	 * Return the minimum size of the table. The minimum height is the
	 * row height times the number of rows.
	 * The minimum width is the sum of the minimum widths of each column.
	 */
	override public function getMinimumSize(c:Component):IntDimension {
		var width:int = 0;
		var enumeration:Array = table.getColumnModel().getColumns();
		for(var i:int=0; i<enumeration.length; i++){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getMinWidth();
		}
		return table.getInsets().getOutsideSize(new IntDimension(width, 0));
	}

	/**
	 * Return the preferred size of the table. The preferred height is the
	 * row height times the number of rows.
	 * The preferred width is the sum of the preferred widths of each column.
	 */
	override public function getPreferredSize(c:Component):IntDimension {
		var width:int = 0;
		var enumeration:Array = table.getColumnModel().getColumns();
		for(var i:int=0; i<enumeration.length; i++){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getPreferredWidth();
		}
		return table.getInsets().getOutsideSize(createTableSize(width));
		//return table.getInsets().getOutsideSize(getViewSize(JTable(c)));
	}

	/**
	 * Return the maximum size of the table. The maximum height is the
	 * row heighttimes the number of rows.
	 * The maximum width is the sum of the maximum widths of each column.
	 */
	override public function getMaximumSize(c:Component):IntDimension {
		var width:int = 0;
		var enumeration:Array = table.getColumnModel().getColumns();
		for(var i:int=0; i<enumeration.length; i++){
			var aColumn:TableColumn = enumeration[i];
			width += aColumn.getMaxWidth();
		}
		return table.getInsets().getOutsideSize(createTableSize(width));
	}	
	
	public function toString():String{
		return "BasicTableUI[]";
	}

}
}