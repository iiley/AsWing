/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table { 

import org.aswing.plaf.UIResource;
import org.aswing.table.GeneralTableCellFactory;

/**
 * @author iiley
 */
public class GeneralTableCellFactoryUIResource extends GeneralTableCellFactory implements UIResource{
	public function GeneralTableCellFactoryUIResource(cellClass:Class){
		super(cellClass);
	}
}
}