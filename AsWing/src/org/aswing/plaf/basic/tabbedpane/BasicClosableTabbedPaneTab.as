package org.aswing.plaf.basic.tabbedpane{

import flash.display.DisplayObject;
import org.aswing.*;

/**
 * The basic imp for ClosableTab
 * @author iiley
 */
public class BasicClosableTabbedPaneTab extends Container implements ClosableTab{
	
	protected var label:JLabel;
	protected var button:AbstractButton;
	
	public function BasicClosableTabbedPaneTab(){
		super();
		var panel:Container = this;
		panel.setLayout(new BorderLayout());
		label = new JLabel();
		panel.append(label, BorderLayout.CENTER);
		button = createCloseButton();
		var bc:Container = new Container();
		bc.setLayout(new CenterLayout());
		bc.append(button);
		panel.append(bc, BorderLayout.EAST);
		label.setFocusable(false);
		button.setFocusable(false);
	}
	
	protected function createCloseButton():AbstractButton{
		var button:AbstractButton = new JButton();
		button.setMargin(new Insets());
		button.setOpaque(false);
		button.setBackgroundDecorator(null);
		button.setIcon(new CloseIcon());
		return button;
	}
	
	public function setMargin(m:Insets):void{
	}
	
	override public function setEnabled(b:Boolean):void{
		super.setEnabled(b);
		label.setEnabled(b);
		button.setEnabled(b);
	}
	
	public function getCloseButton():Component{
		return button;
	}
	
	public function setVerticalAlignment(alignment:int):void{
		label.setVerticalAlignment(alignment);
	}
	
	public function getTabComponent():Component{
		return this;
	}
	
	public function setHorizontalTextPosition(textPosition:int):void{
		label.setHorizontalTextPosition(textPosition);
	}
	
	public function setTextAndIcon(text:String, icon:Icon):void{
		label.setText(text);
		label.setIcon(icon);
	}
	
	public function setIconTextGap(iconTextGap:int):void{
		label.setIconTextGap(iconTextGap);
	}
	
	public function setSelected(b:Boolean):void{
		//do nothing
	}
	
	public function setVerticalTextPosition(textPosition:int):void{
		label.setVerticalTextPosition(textPosition);
	}
	
	public function setHorizontalAlignment(alignment:int):void{
		label.setHorizontalAlignment(alignment);
	}
	
}
}