/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic
{
import flash.text.*;

import org.aswing.*;
import org.aswing.event.InteractiveEvent;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;
import org.aswing.plaf.basic.background.ProgressBarIcon;

public class BasicProgressBarUI extends BaseComponentUI
{
	private var sprite:AWSprite;
	private var iconDecorator:GroundDecorator;
	private var stringText:TextField;
	private var stateListener:Object;
	
	private var progressBar:JProgressBar;
	
	public function BasicProgressBarUI() {
		super();
	}

    protected function getPropertyPrefix():String {
        return "ProgressBar.";
    }    	

	override public function installUI(c:Component):void{
		progressBar = JProgressBar(c);
		installDefaults();
		installComponents();
		installListeners();
	}
	
	override public function uninstallUI(c:Component):void{
		progressBar = JProgressBar(c);		
		uninstallDefaults();
		uninstallComponents();	
		uninstallListeners();
	}
	
	protected function installDefaults():void{
		var pp:String = getPropertyPrefix();
		LookAndFeel.installColorsAndFont(progressBar, pp);
		LookAndFeel.installBasicProperties(progressBar, pp);
		LookAndFeel.installBorderAndBFDecorators(progressBar, pp);
	}
	
	protected function uninstallDefaults():void{
		LookAndFeel.uninstallBorderAndBFDecorators(progressBar);
	}
	
	protected function installComponents():void{
		sprite = new AWSprite();
		stringText = new TextField();
		stringText.autoSize = TextFieldAutoSize.CENTER;
		var pp:String = getPropertyPrefix();    			
		iconDecorator = getGroundDecorator(pp + "iconDecorator");
		if(iconDecorator != null){
			if(iconDecorator.getDisplay() != null){
				sprite.addChild(iconDecorator.getDisplay());
			}
		}
		progressBar.addChild(sprite);
		progressBar.addChild(stringText);
	}
	
	protected function uninstallComponents():void{
		progressBar.removeChild(sprite);
		stringText = null;
		iconDecorator = null;
	}
	
	protected function installListeners():void{
		progressBar.addEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
	}
	protected function uninstallListeners():void{
		progressBar.removeEventListener(InteractiveEvent.STATE_CHANGED, __stateChanged);
	}
	
	private function __stateChanged(source:JProgressBar):void{
		source.repaint();
	}
	
    override public function paint(c:Component, g:Graphics2D, b:IntRectangle):void{
		super.paint(c, g, b);
		var sp:JProgressBar = JProgressBar(c);
		paintIcon(c, g, b)
		if(sp.getString() != null && sp.getString().length>0){
			stringText.text = sp.getString();
	    	AsWingUtils.applyTextFontAndColor(stringText, sp.getFont(), sp.getForeground());
			
			if (sp.getOrientation() == JProgressBar.VERTICAL){
				stringText.rotation = -90;
				stringText.x = Math.round(b.x + (b.width - stringText.width)/2);
				stringText.y = Math.round(b.y + (b.height - stringText.height)/2 + stringText.height);
			}else{
				stringText.rotation = 0;
				stringText.x = Math.round(b.x + (b.width - stringText.width)/2);
				stringText.y = Math.round(b.y + (b.height - stringText.height)/2);
			}
		}else{
			stringText.text = "";
		}
	}
		
    /**
     * LAF notice.
     * 
     * Override this method to paint diff thumb in your LAF.
     */
    private function paintIcon(c:Component, g:Graphics2D, r:IntRectangle):void{
    	if(iconDecorator != null){
    		iconDecorator.updateDecorator(c, g, r);
    	}
    }		

    //--------------------------Dimensions----------------------------
    
	override public function getPreferredSize(c:Component):IntDimension{
		var sp:JProgressBar = JProgressBar(c);
		var size:IntDimension;
		if (sp.getOrientation() == JProgressBar.VERTICAL){
			size = getPreferredInnerVertical();
		}else{
			size = getPreferredInnerHorizontal();
		}
		
		if(sp.getString() != null){
			var textSize:IntDimension = AsWingUtils.stringSize(c.getFont().getTextFormat(), sp.getString());
			if (sp.getOrientation() == JProgressBar.VERTICAL){
				size.width = Math.max(size.width, textSize.height);
				size.height = Math.max(size.height, textSize.width);
			}else{
				size.width = Math.max(size.width, textSize.width);
				size.height = Math.max(size.height, textSize.height);
			}
		}
		return sp.getInsets().getOutsideSize(size);
	}
    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }
    override public function getMinimumSize(c:Component):IntDimension{
		return c.getInsets().getOutsideSize(new IntDimension(1, 1));
    }
    
    private function getPreferredInnerHorizontal():IntDimension{
    	return new IntDimension(80, 12);
    }
    private function getPreferredInnerVertical():IntDimension{
    	return new IntDimension(12, 80);
    }	
	
}
}