package org.aswing.plaf.basic.splitpane
{
import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.basic.icon.SolidArrowIcon;

public class Divider extends Container
{
	
	private var icon:Icon;
	private var leftButton:AbstractButton;
	private var rightButton:AbstractButton;
	private var leftIcon:SolidArrowIcon;
	private var rightIcon:SolidArrowIcon;
	private var sp:JSplitPane;
	
	public function Divider(sp:JSplitPane){
		super();
		this.sp = sp;
		setOpaque(false);
		setFocusable(false);
		setBackground(sp.getBackground());
		leftButton = createCollapseLeftButton();
		rightButton = createCollapseRightButton();
		leftButton.setSize(leftButton.getPreferredSize());
		rightButton.setSize(rightButton.getPreferredSize());
		icon = new DividerIcon();
		append(leftButton);
		append(rightButton);
	}
	
	public function getOwner():JSplitPane{
		return sp;
	}
	
	override protected function paint(b:IntRectangle):void{
		super.paint(b);
		var g:Graphics2D = new Graphics2D(this.graphics);
		if(icon != null){
			icon.updateIcon(this, g, b.x, b.y);
		}
		if(sp.isOneTouchExpandable()){
			if(sp.getOrientation() == JSplitPane.VERTICAL_SPLIT){
				leftIcon.setArrow(-Math.PI/2);
				rightIcon.setArrow(Math.PI/2);
				leftButton.setLocationXY(4, 0);
				rightButton.setLocationXY(14, getHeight()-rightButton.getHeight());
			}else{
				leftIcon.setArrow(Math.PI);
				rightIcon.setArrow(0);
				leftButton.setLocationXY(0, 4);
				rightButton.setLocationXY(getWidth()-rightButton.getWidth(), 14);
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
	
	private function createCollapseLeftButton():AbstractButton{
		leftIcon = new SolidArrowIcon(Math.PI, 8, sp.getForeground());
		return createButton(leftIcon);
	}
	private function createCollapseRightButton():AbstractButton{
		rightIcon = new SolidArrowIcon(0, 8, sp.getForeground());
		return createButton(rightIcon);
	}
	private function createButton(icon:Icon):AbstractButton{
		var btn:JButton = new JButton();
		btn.setOpaque(false);
		btn.setFocusable(false);
		btn.setBorder(null);
		btn.setMargin(new Insets());
		btn.setIcon(icon);
		return btn;
	}
	
	public function getCollapseLeftButton():AbstractButton{
		return leftButton;
	}
	
	public function getCollapseRightButton():AbstractButton{
		return rightButton;
	}	
	
	public function hitTestMouse():Boolean{
		return this.hitTestPoint(this.mouseX, this.mouseY);
	}
}
}