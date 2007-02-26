/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf
{
import org.aswing.geom.IntDimension;
import org.aswing.Component;
import org.aswing.LayoutManager;
import org.aswing.Container;

/**
 * Pluggable look and feel interface for JTabbedPane.
 * @author iiley
 */

public class TabbedPaneUI extends BaseComponentUI implements LayoutManager
{
	
	public function TabbedPaneUI() {
		super();
	}
		
	public function addLayoutComponent(comp:Component, constraints:Object):void
	{
	}
	
	public function invalidateLayout(target:Container):void
	{
	}
	
	public function minimumLayoutSize(target:Container):IntDimension
	{
    	return new IntDimension(0, 0);
	}
	
	public function maximumLayoutSize(target:Container):IntDimension
	{
    	return IntDimension.createBigDimension();
	}
	
	public function layoutContainer(target:Container):void
	{
	}
	
	public function removeLayoutComponent(comp:Component):void
	{
	}
	
	public function getLayoutAlignmentY(target:Container):Number
	{
    	return 0;
	}
	
	public function preferredLayoutSize(target:Container):IntDimension
	{
		return target.getSize();
	}
	
	public function getLayoutAlignmentX(target:Container):Number
	{
		return 0;
	}
	
}
}