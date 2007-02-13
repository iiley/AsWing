/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

/**
 * The default list cell factory for JList.
 * @see org.aswing.JList
 * @author iiley
 */
public class DefaultListCellFactory implements ListCellFactory{
	
	private var shareCelles:Boolean;
	private var sameHeight:Boolean;
	private var cellHeight:int;
	
	public function DefaultListCellFactory(shareCelles:Boolean=true, sameHeight:Boolean=true){
		this.shareCelles = shareCelles;
		this.sameHeight = sameHeight;
		cellHeight = -1;
	}
	
	public function createNewCell() : ListCell {
		return new DefaultListCell();
	}
	
	/**
	 * @return is same height for items
	 * @see ListCellFactory#isAllCellHasSameHeight()
	 */
	public function isAllCellHasSameHeight() : Boolean {
		return sameHeight;
	}
	
	/**
	 * @return is share cells for items.
	 * @see ListCellFactory#isShareCells()
	 */
	public function isShareCells() : Boolean {
		return shareCelles;
	}
	
	/**
	 * Returns the height for all cells.
	 * @see ListCellFactory#getCellHeight()
	 */
	public function getCellHeight() : int {
		if(cellHeight < 0){
			var cell:ListCell = createNewCell();
			cell.setCellValue("JjHhWpqQ1@|");
			cellHeight = cell.getCellComponent().getPreferredSize().height;
		}
		return cellHeight;
	}

}
}