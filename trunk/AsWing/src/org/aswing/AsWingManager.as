/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{
	
import flash.display.*;

/**
 * The main manager for AsWing framework.
 * <p>
 * You may need to call <code>setRoot()</code> to set a default root container for 
 * AsWing Popups.
 * </p>
 * @see JPopup
 * @author iiley
 */
public class AsWingManager{
	
	private static var stage:Stage=null;
    private static var ROOT:DisplayObjectContainer=null;
    
    /**
     * Sets the root container for components base on. 
     * Default is <code>AsWingManager.getStage()</code>.
     */
    public static function setRoot(root:DisplayObjectContainer):void{
        ROOT = root;
        if(stage == null){
        	initStage(root.stage);
        }
    } 
    
    /**
     * Returns the root container which components base on. or symbol libraray located in.
     * @return the root container, or null--not root set and AsWingManager not stage inited.
     * @see #setRoot()
     */ 
    public static function getRoot():DisplayObjectContainer{
        if(ROOT == null){
            return getStage();
        }
        return ROOT;
    }	
	
	/**
	 * Init the stage for AsWing.
	 * This method will be automatically called when a component is added to stage.
	 * @param theStage the stage
	 */
	internal static function initStage(theStage:Stage):void{
		if(stage == null){
			stage = theStage;
			RepaintManager.getInstance().init(stage);
			KeyboardManager.getInstance().init(stage);
			FocusManager.getCurrentManager().init(stage);
		}
	}
	
	/**
	 * Returns whether or not stage is set to the manager.
	 * @return whether or not stage is set to the manager.
	 */
	internal static function isStageInited():Boolean{
		return stage != null;
	}
	
	/**
	 * Returns the stage.
	 * @return the stage.
	 */
	public static function getStage():Stage{
		return stage;
	}	
	
}
}