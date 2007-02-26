/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic
{
import org.aswing.*;
import org.aswing.border.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;
import org.aswing.plaf.basic.icon.ArrowIcon;
import org.aswing.util.*;

public class BasicTabbedPaneUI extends TabbedPaneUI
{
	private static var topBlankSpace:Number = 4;
	
    private var shadow:ASColor;
    private var darkShadow:ASColor;
    private var highlight:ASColor;
    private var lightHighlight:ASColor;
    private var arrowShadowColor:ASColor;
    private var arrowLightColor:ASColor;
    
	private var tabbedPane:JTabbedPane;
	private var tabBarSize:IntDimension;
	private var maxTabSize:IntDimension;
	private var prefferedSize:IntDimension;
	private var minimumSize:IntDimension;
	private var tabBoundArray:Array;
	private var drawnTabBoundArray:Array;
	private var baseLineThickness:Number;
	private var maxTabWidth:Number;
	//both the 2 values are just the values considering when placement is TOP
	private var tabBorderInsets:Insets;
	
	private var textFields:Array;
	private var textFieldsBevel:Array;
	private var toolTip:JToolTip;
	private var tabbedPaneListener:Object;
	private var toolTipTrigger:Object;
	
	private var firstIndex:Number; //first viewed tab index
	private var lastIndex:Number;  //last perfectly viewed tab index
	private var prevButton:AbstractButton;
	private var nextButton:AbstractButton;
	private var itemPane:JPanel;
	private var isSuppliedPress:Boolean;
	
	
	private var tabMC:AWSprite; //tabMC
	private var tabMaskMC:AWSprite;  //遮罩
	private var itemDecorator:GroundDecorator; //tabItem
	
	public function BasicTabbedPaneUI() {
		super();
		tabBorderInsets = new Insets(2, 2, 0, 2);
		textFields = new Array();
		textFieldsBevel = new Array();
		firstIndex = 0;
		lastIndex = 0;
		isSuppliedPress = false;
	}

    override public function installUI(c:Component):void{
		tabbedPane = JTabbedPane(c);
		tabbedPane.setLayout(this);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override  public function uninstallUI(c:Component):void{
		tabbedPane = JTabbedPane(c);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
    protected function getPropertyPrefix():String {
        return "TabbedPane.";
    }
    
	private function installDefaults():void{
		var pp:String = getPropertyPrefix();
		var table:UIDefaults = UIManager.getLookAndFeelDefaults();
		shadow = table.getColor(pp+"shadow");
		darkShadow = table.getColor(pp+"darkShadow");
		highlight = table.getColor(pp+"light");
		lightHighlight = table.getColor(pp+"highlight");
		arrowShadowColor = table.getColor(pp+"arrowShadowColor");
		arrowLightColor = table.getColor(pp+"arrowLightColor");
		
		baseLineThickness = table.getNumber(pp+"baseLineThickness");
		maxTabWidth = table.getNumber(pp+"maxTabWidth");
		
		var tabMargin:Insets = table.getInsets(pp+"tabMargin");
		if(tabMargin == null) tabMargin = new InsetsUIResource(1, 1, 1, 1);    	
		var i:Insets = tabbedPane.getMargin();
		if (i == null || i is UIResource) {
	    	tabbedPane.setMargin(tabMargin);
		}
		
        LookAndFeel.installBorderAndBFDecorators(tabbedPane, pp );
        LookAndFeel.installColorsAndFont(tabbedPane, pp);
        LookAndFeel.installBasicProperties(tabbedPane, pp);
	}
    
    private function uninstallDefaults():void{
    	LookAndFeel.uninstallBorderAndBFDecorators(tabbedPane);
    }
    
	private function installComponents():void{
		prevButton.setFocusable(false);
		prevButton.setVisible(false);
		nextButton.setFocusable(false);
		nextButton.setVisible(false);
		toolTip = new JToolTip();
		toolTip.setTargetComponent(tabbedPane);
		tabMC = new AWSprite();
		itemPane = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
    }
	private function uninstallComponents():void{
    	toolTip.setTargetComponent(null);
    	toolTip.disposeToolTip();
    }
	
	private function installListeners():void{
	}
    private function uninstallListeners():void{
    }
    //----------
   	override public function paintFocus(c:Component, g:Graphics2D, b:IntRectangle):void{
    	super.paintFocus(c, g, b);
    } 
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
    	super.paint(c, g, b);
    }
    
    /**
     * Returns whether the tab painted out of tabbedPane bounds or not viewable or viewable.<br>
     * @return -1 , viewable whole area;
     *         0, viewable but end out of bounds
     *         1, not viewable in the bounds. 
     */
    private function drawTabWithFullInfosAt(index:Number, paneBounds:IntRectangle, bounds:IntRectangle,
     g:Graphics2D, tabBarBounds:IntRectangle, offsetPoint:IntPoint, transformedTabMargin:Insets):Number{
    	return -1;
    }
    
    /**
     * override this method to draw different tab base line for your LAF
     */
    private function drawBaseLine(tabBarBounds:IntRectangle, g:Graphics2D, fullB:IntRectangle):void{
    }
    
    private function drawTabAt(index:Number, bounds:IntRectangle, paneBounds:IntRectangle, g:Graphics2D, transformedTabMargin:Insets):void{
    }
    
    private function getTabColor(index:Number):ASColor{
    	return tabbedPane.getBackground();
    }
    
    /**
     * override this method to draw different tab border for your LAF.<br>
     * Note, you must call setDrawnTabBounds() to set the right bounds for each tab in this method
     */
    private function drawTabBorderAt(index:Number, b:IntRectangle, paneBounds:IntRectangle, g:Graphics2D):void{
    }
    //----------------------------LayoutManager Implementation-----------------------------
    
    override public function addLayoutComponent(comp:Component, constraints:Object):void{
    	tabbedPane.repaint();
    }
	
    override public function removeLayoutComponent(comp:Component):void{
    	tabbedPane.repaint();
    }
	
    override public function preferredLayoutSize(target:Container):IntDimension{
    	return null;
    }

    override public function minimumLayoutSize(target:Container):IntDimension{
    	return null;
    }
	    
    override public function layoutContainer(target:Container):void{
    }
    
    override public function invalidateLayout(target:Container):void{
    	if(target != tabbedPane){
    		trace("Error : BasicTabbedPaneUI Can't layout " + target);
    		return;
    	}
    	prefferedSize = null;
    	minimumSize = null;
    	tabBarSize = null;
    	tabBoundArray = null;
    }	
	
}
}