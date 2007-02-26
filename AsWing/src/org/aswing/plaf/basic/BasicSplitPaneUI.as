package org.aswing.plaf.basic
{
import flash.events.*;

import org.aswing.*;
import org.aswing.event.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;
import org.aswing.plaf.basic.splitpane.*;
import flash.display.Sprite;
import flash.geom.Point;

public class BasicSplitPaneUI extends SplitPaneUI implements LayoutManager
{
	
	private var sp:JSplitPane;
	private var divider:Divider;
	private var lastContentSize:IntDimension;
	private var spLis:Object;
	private var mouseLis:Object;
	private var vSplitCursor:Cursor;
	private var hSplitCursor:Cursor;
	private var presentDragColor:ASColor;
	
	private var startDragPos:IntPoint;
	private var startLocation:Number;
	private var startDividerPos:IntPoint;
	private var dragRepresentationMC:Sprite;
	private var pressFlag:Boolean;  //the flag for pressed left or right collapseButton	
	
	public function BasicSplitPaneUI() {
		super();
	}
	
    protected function getPropertyPrefix():String {
        return "SplitPane.";
    }
    
    override public function installUI(c:Component):void {
        sp = JSplitPane(c);
        installDefaults();
        installComponents();
        installListeners();
    }

    override public function uninstallUI(c:Component):void {
        sp = JSplitPane(c);
        uninstallDefaults();
        uninstallComponents();
        uninstallListeners();
    }
    
    private function installDefaults():void {
    	var pp:String = getPropertyPrefix();
        LookAndFeel.installColorsAndFont(sp, pp);
        LookAndFeel.installBorderAndBFDecorators(sp, pp);
        LookAndFeel.installBasicProperties(sp, pp);
        presentDragColor = UIManager.getColor(pp+"presentDragColor");
        lastContentSize = new IntDimension();
        sp.setLayout(this);
    }

    private function uninstallDefaults():void {
        LookAndFeel.uninstallBorderAndBFDecorators(sp);
    }
	
	private function installComponents():void{
		vSplitCursor = createSplitCursor(true);
		hSplitCursor = createSplitCursor(false);
		divider = createDivider();
		sp.append(divider, JSplitPane.DIVIDER);
		
		divider.addEventListener(MouseEvent.MOUSE_DOWN, __div_pressed);
		divider.addEventListener(ReleaseEvent.RELEASE, __div_released);
		divider.addEventListener(MouseEvent.ROLL_OVER, __div_rollover);
		divider.addEventListener(MouseEvent.ROLL_OUT, __div_rollout);
		
		divider.getCollapseLeftButton().addEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseRightButton().addEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseLeftButton().addEventListener(MouseEvent.ROLL_OUT, __div_rollover);
		divider.getCollapseRightButton().addEventListener(MouseEvent.ROLL_OUT, __div_rollover);		
		divider.getCollapseLeftButton().addActionListener(__collapseLeft);
		divider.getCollapseRightButton().addActionListener(__collapseRight);
	}
	
	private function uninstallComponents():void{
		sp.remove(divider);
		divider.removeEventListener(MouseEvent.MOUSE_DOWN, __div_pressed);
		divider.removeEventListener(ReleaseEvent.RELEASE, __div_released);
		divider.removeEventListener(MouseEvent.ROLL_OVER, __div_rollover);
		divider.removeEventListener(MouseEvent.ROLL_OUT, __div_rollout);
		
		divider.getCollapseLeftButton().removeEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseRightButton().removeEventListener(MouseEvent.ROLL_OVER, __div_rollout);
		divider.getCollapseLeftButton().removeEventListener(MouseEvent.ROLL_OUT, __div_rollover);
		divider.getCollapseRightButton().removeEventListener(MouseEvent.ROLL_OUT, __div_rollover);
		divider.getCollapseLeftButton().removeActionListener(__collapseLeft);
		divider.getCollapseRightButton().removeActionListener(__collapseRight);
		divider = null;
	}
	
	private function installListeners():void{
		sp.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __on_splitpane_key_down);
		sp.addEventListener(InteractiveEvent.STATE_CHANGED, __div_location_changed);
	}
	
	private function uninstallListeners():void{
		sp.removeEventListener(KeyboardEvent.KEY_DOWN, __on_splitpane_key_down);
		sp.removeEventListener(InteractiveEvent.STATE_CHANGED, __div_location_changed);
	}
	
	/**
	 * Override this method to return a different splitCursor for your UI<br>
	 * Credit to Kristof Neirynck for added this.
	 */
	private function createSplitCursor(vertical:Boolean):Cursor{
		var result:Cursor;
		if(vertical){
			result = new Cursor(Cursor.V_RESIZE_CURSOR);
		}else{
			result = new Cursor(Cursor.H_RESIZE_CURSOR);
		}
		return result;
	}
	
	/**
	 * Override this method to return a different divider for your UI
	 */
	private function createDivider():Divider{
		return new Divider(sp);
	}
    
	/**
	 * Override this method to return a different default divider size for your UI
	 */
    private function getDefaultDividerSize():Number{
    	return 10;
    }
    /**
	 * Override this method to return a different default DividerDragingRepresention for your UI
	 */
    private function paintDividerDragingRepresention(g:Graphics2D):void{
		g.fillRectangle(new SolidBrush(presentDragColor.changeAlpha(0.4)), 0, 0, divider.getWidth(), divider.getHeight());
    }
	
    /**
     * Messaged to relayout the JSplitPane based on the preferred size
     * of the children components.
     */
    override public function resetToPreferredSizes(jc:JSplitPane):void{
    	var loc:Number = jc.getDividerLocation();
    	if(isVertical()){
    		if(jc.getLeftComponent() == null){
    			loc = 0;
    		}else{
    			loc = jc.getLeftComponent().getPreferredHeight();
    		}
    	}else{
    		if(jc.getLeftComponent() == null){
    			loc = 0;
    		}else{
    			loc = jc.getLeftComponent().getPreferredWidth();
    		}
    	}
		loc = Math.max(
			getMinimumDividerLocation(), 
			Math.min(loc, getMaximumDividerLocation()));
		jc.setDividerLocation(loc);
    }
    
	override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
		super.paint(c, g, b);
		divider.paintImmediately();
	}    
    
    public function layoutWithLocation(location:int):void{
    	var rect:IntRectangle = sp.getSize().getBounds(0, 0);
    	rect = sp.getInsets().getInsideBounds(rect);
    	var lc:Component = sp.getLeftComponent();
    	var rc:Component = sp.getRightComponent();
    	var dvSize:Number = getDividerSize();
    	var lcSize:Number = 0;
    	var rcSize:Number = 0;
    	location = Math.floor(location);
    	if(location < 0){
    		//collapse left
			if(isVertical()){
				divider.setComBoundsXYWH(rect.x, rect.y, rect.width, dvSize);
				rc.setComBoundsXYWH(rect.x, rect.y+dvSize, rect.width, rect.height-dvSize);
			}else{
				divider.setComBoundsXYWH(rect.x, rect.y, dvSize, rect.height);
				rc.setComBoundsXYWH(rect.x+dvSize, rect.y, rect.width-dvSize, rect.height);
			}
    		lc.setVisible(false);
    		rc.setVisible(true);
    	}else if(location == int.MAX_VALUE){
    		//collapse right
			if(isVertical()){
				divider.setComBoundsXYWH(
					rect.x, 
					rect.y+rect.height-dvSize, 
					rect.width, 
					dvSize);
				lc.setComBoundsXYWH(
					rect.x, 
					rect.y,
					rect.width, 
					rect.height-dvSize);
			}else{
				divider.setComBoundsXYWH(
					rect.x+rect.width-dvSize, 
					rect.y, 
					dvSize, 
					rect.height);
				lc.setComBoundsXYWH(
					rect.x, 
					rect.y,
					rect.width-dvSize, 
					rect.height);
			}
    		lc.setVisible(true);
    		rc.setVisible(false);
    	}else{
    		//both visible
			if(isVertical()){
				divider.setComBoundsXYWH(
					rect.x, 
					rect.y+location, 
					rect.width, 
					dvSize);
				lc.setComBoundsXYWH(
					rect.x, 
					rect.y,
					rect.width, 
					location);
				rc.setComBoundsXYWH(
					rect.x, 
					rect.y+location+dvSize, 
					rect.width, 
					rect.height-location-dvSize
				);
			}else{
				divider.setComBoundsXYWH(
					rect.x+location, 
					rect.y, 
					dvSize, 
					rect.height);
				lc.setComBoundsXYWH(
					rect.x, 
					rect.y,
					location, 
					rect.height);
				rc.setComBoundsXYWH(
					rect.x+location+dvSize, 
					rect.y, 
					rect.width-location-dvSize, 
					rect.height
				);
			}
    		lc.setVisible(true);
    		rc.setVisible(true);
    	}
    	lc.revalidateIfNecessary();
    	rc.revalidateIfNecessary();
    	divider.revalidateIfNecessary();
    }
    
    public function getMinimumDividerLocation():Number{
    	var leftCom:Component = sp.getLeftComponent();
    	if(leftCom == null){
    		return 0;
    	}else{
    		if(isVertical()){
    			return leftCom.getMinimumHeight();
    		}else{
    			return leftCom.getMinimumWidth();
    		}
    	}
    }
    
    public function getMaximumDividerLocation():Number{
    	var rightCom:Component = sp.getRightComponent();
    	var insets:Insets = sp.getInsets();
    	var rightComSize:Number = 0;
    	if(rightCom != null){
    		rightComSize = isVertical() ? rightCom.getMinimumHeight() : rightCom.getMinimumWidth();
    	}
		if(isVertical()){
			return sp.getHeight() - insets.top - insets.bottom - getDividerSize() - rightComSize;
		}else{
			return sp.getWidth() - insets.left - insets.right - getDividerSize() - rightComSize;
		}
    }
    
    private function isVertical():Boolean{
    	return sp.getOrientation() == JSplitPane.VERTICAL_SPLIT;
    }
    
    private function getDividerSize():Number{
    	var si:Number = sp.getDividerSize();
    	if(isNaN(si)){
    		return getDefaultDividerSize();
    	}else{
    		return si;
    	}
    }
    
    private function restrictDividerLocation(loc:Number):Number{
    	return Math.max(
				getMinimumDividerLocation(), 
				Math.min(loc, getMaximumDividerLocation()));
    }
    //-----------------------------------------------------------------------
    
	private function __collapseLeft(e:AWEvent) : void {
		pressFlag = true;
		if(sp.getDividerLocation() == int.MAX_VALUE){
			sp.setDividerLocation(sp.getLastDividerLocation());
			divider.getCollapseLeftButton().setEnabled(true);
			divider.getCollapseRightButton().setEnabled(true);
		}else if(sp.getDividerLocation() >= 0){
			sp.setDividerLocation(-1);
			divider.getCollapseLeftButton().setEnabled(false);
		}else{
			divider.getCollapseLeftButton().setEnabled(true);
		}
	}

	private function __collapseRight(e:AWEvent) : void {
		pressFlag = true;		
		if(sp.getDividerLocation() < 0){
			sp.setDividerLocation(sp.getLastDividerLocation());
			divider.getCollapseRightButton().setEnabled(true);
			divider.getCollapseLeftButton().setEnabled(true);
		}else if(sp.getDividerLocation() != int.MAX_VALUE){
			sp.setDividerLocation(int.MAX_VALUE);
			divider.getCollapseRightButton().setEnabled(false);
		}else{
			divider.getCollapseRightButton().setEnabled(false);
		}
	}
	
	private function __on_splitpane_key_down(e:FocusKeyEvent):void{
		var code:uint = e.keyCode;
		var dir:Number = 0;
		if(code == KeyStroke.VK_HOME.getCode()){
			if(sp.getDividerLocation() < 0){
				sp.setDividerLocation(sp.getLastDividerLocation());
			}else{
				sp.setDividerLocation(-1);
			}
			return;
		}else if(code == KeyStroke.VK_END.getCode()){
			if(sp.getDividerLocation() == int.MAX_VALUE){
				sp.setDividerLocation(sp.getLastDividerLocation());
			}else{
				sp.setDividerLocation(int.MAX_VALUE);
			}
			return;
		}
		if(code == KeyStroke.VK_LEFT.getCode() || code == KeyStroke.VK_UP.getCode()){
			dir = -1;
		}else if(code == KeyStroke.VK_RIGHT.getCode() || code == KeyStroke.VK_DOWN.getCode()){
			dir = 1;
		}
		if(e.shiftKey){
			dir *= 10;
		}
		sp.setDividerLocation(restrictDividerLocation(sp.getDividerLocation() + dir));
	}
    
    private function __div_location_changed(e:InteractiveEvent):void{
    	layoutWithLocation(sp.getDividerLocation());
        if(sp.getDividerLocation() >= 0 && sp.getDividerLocation() != int.MAX_VALUE){
        	divider.setEnabled(true);
        }else{
        	divider.setEnabled(false);
        }
    }
	
	private function __div_pressed(e:MouseEvent) : void {
		if (e.target != divider){
			pressFlag = true;
			return;
		}
		startDragPos = sp.getMousePosition();
		startLocation = sp.getDividerLocation();
		startDividerPos = divider.getGlobalLocation();
		sp.removeEventListener(MouseEvent.MOUSE_MOVE, __div_mouse_moving);
		sp.addEventListener(MouseEvent.MOUSE_MOVE, __div_mouse_moving);
	}

	private function __div_released(e:ReleaseEvent) : void {
		if (e.target != divider) return;		
		if (pressFlag){
			pressFlag = false;
			return;
		}
		if(!divider.hitTestMouse()){
			__div_rollout(e);
		}
		if(dragRepresentationMC != null && sp.contains(dragRepresentationMC)){
			sp.removeChild(dragRepresentationMC);
		}
		
		validateDivMoveWithCurrentMousePos();
		sp.removeEventListener(MouseEvent.MOUSE_MOVE, __div_mouse_moving);
	}

	private function __div_mouse_moving(e:MouseEvent) : void {
		if(!sp.isContinuousLayout()){
			if(dragRepresentationMC == null){
				dragRepresentationMC = new Sprite();
				var g:Graphics2D = new Graphics2D(dragRepresentationMC.graphics);
				paintDividerDragingRepresention(g);
			}
			if(!sp.contains(dragRepresentationMC)){
				sp.addChild(dragRepresentationMC);
			}
			var mouseP:IntPoint = sp.getMousePosition();
			var newGlobalPos:IntPoint = startDividerPos.clone();
			if(isVertical()){
				newGlobalPos.y += getCurrentMovedDistance();
			}else{
				newGlobalPos.x += getCurrentMovedDistance();
			}
			var newPoint:Point = newGlobalPos.toPoint();
			dragRepresentationMC.parent.globalToLocal(newPoint);
			dragRepresentationMC.x = Math.round(newPoint.x);
			dragRepresentationMC.y = Math.round(newPoint.y);
		}else{
			validateDivMoveWithCurrentMousePos();
		}
	}
	
	private function validateDivMoveWithCurrentMousePos():void{
		var newLocation:Number = startLocation + getCurrentMovedDistance();
		sp.setDividerLocation(newLocation);
	}
	
	private function getCurrentMovedDistance():Number{
		var mouseP:IntPoint = sp.getMousePosition();
		var delta:Number = 0;
		if(isVertical()){
			delta = mouseP.y - startDragPos.y;
		}else{
			delta = mouseP.x - startDragPos.x;
		}
		var newLocation:Number = startLocation + delta;
		newLocation = Math.max(
			getMinimumDividerLocation(), 
			Math.min(newLocation, getMaximumDividerLocation()));
		return newLocation - startLocation;
	}

	private function __div_rollover(e:Event) : void {
		if(isVertical()){
			CursorManager.showCustomCursor(vSplitCursor);
		}else{
			CursorManager.showCustomCursor(hSplitCursor);
		}
	}

	private function __div_rollout(e:Event) : void {
		if(isVertical()){
			CursorManager.hideCustomCursor(vSplitCursor);
		}else{
			CursorManager.hideCustomCursor(hSplitCursor);
		}
	}
    
    //-----------------------------------------------------------------------
    //                     Layout implementation
    //-----------------------------------------------------------------------
	public function addLayoutComponent(comp : Component, constraints : Object) : void {
	}

	public function removeLayoutComponent(comp : Component) : void {
	}

	public function preferredLayoutSize(target : Container) : IntDimension {
		var insets:Insets = sp.getInsets();
    	var lc:Component = sp.getLeftComponent();
    	var rc:Component = sp.getRightComponent();
    	var lcSize:IntDimension = (lc == null ? new IntDimension() : lc.getPreferredSize());
    	var rcSize:IntDimension = (rc == null ? new IntDimension() : rc.getPreferredSize());
    	var size:IntDimension;
    	if(isVertical()){
    		size = new IntDimension(
    			Math.max(lcSize.width, rcSize.width), 
    			lcSize.height + rcSize.height + getDividerSize()
    		);
    	}else{
    		size = new IntDimension(
    			lcSize.width + rcSize.width + getDividerSize(), 
    			Math.max(lcSize.height, rcSize.height)
    		);
    	}
    	return insets.getOutsideSize(size);
	}

	public function minimumLayoutSize(target : Container) : IntDimension {
		return target.getInsets().getOutsideSize();
	}

	public function maximumLayoutSize(target : Container) : IntDimension {
		return new IntDimension(int.MAX_VALUE, int.MAX_VALUE);
	}
	
	public function layoutContainer(target : Container) : void {
		var size:IntDimension = sp.getSize();
		size = sp.getInsets().getInsideSize(size);
		var layouted:Boolean = false;
		if(!size.equals(lastContentSize)){
			//re weight the split
			var deltaSize:Number = 0;
			if(isVertical()){
				deltaSize = size.height - lastContentSize.height;
			}else{
				deltaSize = size.width - lastContentSize.width;
			}
			lastContentSize = size.clone();
			var locationDelta:Number = deltaSize*sp.getResizeWeight();
			layouted = (locationDelta != 0);
			var newLocation:Number = sp.getDividerLocation()+locationDelta;
			
			newLocation = Math.max(
				getMinimumDividerLocation(), 
				Math.min(newLocation, getMaximumDividerLocation()));
			
			sp.setDividerLocation(newLocation, true);
		}
		if(!layouted){
			layoutWithLocation(sp.getDividerLocation());
		}
	}

	public function getLayoutAlignmentX(target : Container) : Number {
		return 0;
	}

	public function getLayoutAlignmentY(target : Container) : Number {
		return 0;
	}

	public function invalidateLayout(target : Container) : void {
	}
}
}