/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.plaf.basic.splitpane.Divider;
import org.aswing.*;
import org.aswing.plaf.*;


public class SkinSplitPaneDivider extends Divider{
	
	protected var leftIco:SkinButtonIcon;
	protected var rightIco:SkinButtonIcon;
	protected var upIco:SkinButtonIcon;
	protected var downIco:SkinButtonIcon;
	
	public function SkinSplitPaneDivider(sp:JSplitPane){
		super(sp);
		setBackgroundDecorator(new SkinSplitPaneDividerBackground());
		icon = null;
		leftIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowLeft.");
		leftIco.checkSetup(sp);
		rightIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowRight.");
		rightIco.checkSetup(sp);
		upIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowUp.");
		upIco.checkSetup(sp);
		downIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowDown.");
		downIco.checkSetup(sp);
	}
	
	//make the bg can get ui defaults properties from split pane ui
	override public function getUI():ComponentUI{
		return sp.getUI();
	}
	
	override protected function layoutButtons():void{
		if(sp.isOneTouchExpandable()){
			if(sp.getOrientation() == JSplitPane.VERTICAL_SPLIT){
				leftButton.setIcon(upIco);
				rightButton.setIcon(downIco);
				leftButton.pack();
				rightButton.pack();
				leftButton.setLocationXY(0, 0);
				rightButton.setLocationXY(leftButton.getWidth(), getHeight()-rightButton.getHeight());
			}else{
				leftButton.setIcon(leftIco);
				rightButton.setIcon(rightIco);
				leftButton.pack();
				rightButton.pack();
				leftButton.setLocationXY(0, 0);
				rightButton.setLocationXY(getWidth()-rightButton.getWidth(), leftButton.getHeight());
			}
			leftButton.setVisible(true);
			rightButton.setVisible(true);
			leftButton.validate();
			rightButton.validate();
			leftButton.repaint();
			rightButton.repaint();
		}else{
			leftButton.setVisible(false);
			rightButton.setVisible(false);
		}
	}
	
	override protected function createCollapseLeftButton():AbstractButton{
		var btn:JButton = new JButton();
		btn.setBackgroundDecorator(null);
		return btn;
	}
	
	override protected function createCollapseRightButton():AbstractButton{
		var btn:JButton = new JButton();
		btn.setBackgroundDecorator(null);
		return btn;
	}	
}
}