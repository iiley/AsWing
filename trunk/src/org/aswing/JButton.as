/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{

/**
 * An implementation of a "push" button.
 * @author iiley
 */
public class JButton extends AbstractButton
{
	public function JButton(text:String="", icon:Icon=null){
		super(text, icon);
		setName("JButton");
    	setModel(new DefaultButtonModel());
		updateUI();
	}
	
    override public function updateUI():void{
    	setUI(UIManager.getUI(this));
    }
	
	override public function getUIClassID():String{
		return "ButtonUI";
	}
	
}

}