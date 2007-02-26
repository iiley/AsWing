/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import org.aswing.plaf.*;
	
/**
 * A component that lets the user switch between a group of components by
 * clicking on a tab with a given title and/or icon.
 * <p>
 * Tabs/components are added to a <code>TabbedPane</code> object by using the
 * <code>addTab</code> and <code>insertTab</code> methods.
 * A tab is represented by an index corresponding
 * to the position it was added in, where the first tab has an index equal to 0
 * and the last tab has an index equal to the tab count minus 1.
 * @author iiley
 */	
	
public class JTabbedPane extends AbstractTabbedPane
{
	
	private var tabPlacement:Number;
	
    /**
     * JTabbedPane()
     * <p>
     */
	public function JTabbedPane() {
		super();
		setName("JTabbedPane");
		tabPlacement = TOP;
		
		updateUI();
	}
	
    override public function updateUI():void{
    	setUI(TabbedPaneUI(UIManager.getUI(this)));
    }
	
	override public function getUIClassID():String{
		return "TabbedPaneUI";
	}
	
    /**
     * Sets the tab placement for this tabbedpane.
     * Possible values are:<ul>
     * <li><code>JTabbedPane.TOP</code>
     * <li><code>JTabbedPane.BOTTOM</code>
     * <li><code>JTabbedPane.LEFT</code>
     * <li><code>JTabbedPane.RIGHT</code>
     * </ul>
     * The default value, if not set, is <code>SwingConstants.TOP</code>.
     *
     * @param tabPlacement the placement for the tabs relative to the content
     */
    public function setTabPlacement(tabPlacement:Number):void {
    	if(this.tabPlacement != tabPlacement){
    		this.tabPlacement = tabPlacement;
    		revalidate();
    		repaint();
    	}
    }
    
    /**
     * Returns the placement of the tabs for this tabbedpane.
     * @see #setTabPlacement()
     */
    public function getTabPlacement():Number{
    	return tabPlacement;
    }
    
    /**
     * Not support this function.
     * @throws Error("Not supported setVisibleAt!")
     */
    override  public function setVisibleAt(index:Number, visible:Boolean):void{
    	throw new Error("Not supported setVisibleAt!");
    }	
	
}
}