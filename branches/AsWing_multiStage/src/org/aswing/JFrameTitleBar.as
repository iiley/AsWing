package org.aswing{


/**
 * JFrameTitleBar contains a title text, iconified button, maximize button, restore button, close button for JFrame.
 * @see org.aswing.JFrame
 */
public class JFrameTitleBar extends Container{
	
	protected var iconifiedButton:AbstractButton;
	protected var maximizeButton:AbstractButton;
	protected var restoreButton:AbstractButton;
	protected var closeButton:AbstractButton;
	protected var titleLabel:JLabel;
	protected var icon:Icon;
	protected var text:String;
	
	protected var buttonPane:Container;
	
	public function JFrameTitleBar(){
		super();
		setUIElement(true);
		buttonPane = new Container();
	}
}
}