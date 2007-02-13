/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{
	
import flash.display.*;
import org.aswing.error.AsWingManagerNotInited;
import org.aswing.geom.IntDimension;

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
    private static var INITIAL_STAGE_WIDTH:int;
    private static var INITIAL_STAGE_HEIGHT:int;
    
    /**
     * Sets the root container for AsWing components based on.
     * <p>
     * You'd better call this method before application start, before flashplayer 
     * stage resized.
     * </p>
     * Default is <code>AsWingManager.getStage()</code>.
     * @param root the root container for AsWing components.
     */
    public static function setRoot(root:DisplayObjectContainer):void{
        ROOT = root;
        if(stage == null){
        	initStage(root.stage);
        }
    }
    
    /**
     * Sets the intial stage size, this method generally do not need to use.
     * But some times, you know the manager is not initied at right time, i means 
     * some times the manager is inited after the stage is resized, so, you maybe need 
     * to call this method to correct the size.
     * @param width the width of stage when application start.
     * @param width the height of stage when application start.
     */
    public static function setInitialStageSize(width:int, height:int):void{
    	INITIAL_STAGE_WIDTH = width;
    	INITIAL_STAGE_HEIGHT = height;
    }
    
    /**
     * Returns the stage initial size.
     * @return the size. 
     */
    public static function getInitialStageSize():IntDimension{
    	if(ROOT == null){
    		throw new AsWingManagerNotInited();
    	}
    	return new IntDimension(INITIAL_STAGE_WIDTH, INITIAL_STAGE_HEIGHT);
    }
    
    /**
     * Returns the root container which components base on. or symbol libraray located in.
     * If you have not set a specified root, the stage will be the root to be returned.
	 * @param checkError whethor or not check root is inited set.
     * @return the root container, or null--not root set and AsWingManager not stage inited.
	 * @throws AsWingManagerNotInited if checkError and both root and stage is null.
     * @see #setRoot()
     * @see #getStage()
     */ 
    public static function getRoot(checkError:Boolean=true):DisplayObjectContainer{
        if(ROOT == null){
            return getStage(checkError);
        }
        return ROOT;
    }	
	
	/**
	 * Init the stage for AsWing, this method should be better called when flashplayer start.
	 * This method will be automatically called when a component is added to stage.
	 * @param theStage the stage
	 */
	internal static function initStage(theStage:Stage):void{
		if(stage == null){
			stage = theStage;
	        INITIAL_STAGE_WIDTH = stage.stageWidth;
	        INITIAL_STAGE_HEIGHT = stage.stageHeight;
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
	 * @param checkError whethor or not check is stage is inited set.
	 * @return the stage.
	 * @throws AsWingManagerNotInited if checkError and stage is null.
	 */
	public static function getStage(checkError:Boolean=true):Stage{
		if(checkError && stage==null){
			throw new AsWingManagerNotInited();
		}
		return stage;
	}	
	
}
}