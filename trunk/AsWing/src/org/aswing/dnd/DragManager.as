/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.dnd{

import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.util.*;
import flash.display.*;
import flash.geom.*;
import flash.events.MouseEvent;
import org.aswing.event.DragAndDropEvent;

/**
 * Drag and Drop Manager.
 * <p>
 * Thanks Bill Lee for the original DnD implementation for AsWing AS2 version.
 * </p>
 * @author iiley
 */
public class DragManager{
	
	public static var TYPE_NONE:Number = 0;
	public static var TYPE_MOVE:Number = 1;
	public static var TYPE_COPY:Number = 2;
	
	public static var DEFAULT_DROP_MOTION:DropMotion = new DirectlyRemoveMotion();
	public static var DEFAULT_REJECT_DROP_MOTION:DropMotion = new RejectedMotion();
	
	private static var s_isDragging:Boolean = false;
	
	private static var s_dragListener:DragListener;
	private static var s_dragInitiator:Component;
	private static var s_sourceData:SourceData;
	private static var s_dragImage:DraggingImage;
	
	private static var root:DisplayObjectContainer = null;
	private static var dropMotion:DropMotion;
	private static var dragProxyMC:Sprite;
	private static var mouseOffset:IntPoint;
	private static var enteredComponent:Component;
	
	private static var listeners:Array = new Array();
	
	
	/**
	 * Sets the container to hold the draging image(in fact it will hold the image's parent--a sprite).
	 * By default(if you have not set one), it will be the <code>AsWingManager.getRoot()</code> value.
	 * @param theRoot the container to hold the draging image.
	 * @see org.aswing.AsWingManager#getRoot()
	 */
	public static function setDragingImageContainerRoot(theRoot:DisplayObjectContainer):void{
		root = theRoot;
	}
	
	private static function getDragingImageContainerRoot():DisplayObjectContainer{
		if(root == null){
			return AsWingManager.getRoot();
		}
		return root;
	}		
	
	/**
	 * startDrag(dragInitiator:Component, dragSource, dragImage:MovieClip, lis:DragListener)<br>
	 * startDrag(dragInitiator:Component, dragSource, dragImage:MovieClip)<br>
	 * startDrag(dragInitiator:Component, dragSource)<br>
	 * <p>
	 * Starts dragging a initiator, with dragSource, a dragging Image, and a listener. The drag action will be finished 
	 * at next Mouse UP/Down Event(Mouse UP or Mouse Down, generally you start a drag when mouse down, then it will be finished 
	 * when mouse up, if you start a drag when mouse up, it will be finished when mouse down).
	 * 
	 * @param dragInitiator the dragging initiator
	 * @param sourceData the data source will pass to the listeners and target components
	 * @param dragImage (optional)the image to drag, default is a rectangle image.
	 * @param dragListener (optional)the listener added to just for this time dragging action, default is null(no listener)
	 */
	public static function startDrag(dragInitiator:Component, sourceData:SourceData, dragImage:DraggingImage, dragListener:DragListener):void{
		if(s_isDragging){
			throw new Error("The last dragging action is not finished, can't start a new one!");
			return;
		}
		var stage:Stage = AsWingManager.getStage();
		if(dragImage == null){
			dragImage = new DefaultDragImage(dragInitiator);
		}
		
		s_isDragging = true;
		s_dragInitiator = dragInitiator;
		s_sourceData = sourceData;
		s_dragImage = dragImage;
		s_dragListener = dragListener;
		if(s_dragListener != null){
			addDragListener(s_dragListener);
		}
		var container:DisplayObjectContainer = getDragingImageContainerRoot();
		if(dragProxyMC == null){
			dragProxyMC = new Sprite();
			dragProxyMC.mouseEnabled = false;
			dragProxyMC.name = "drag_image";
		}
		if(dragProxyMC.numChildren > 0){
			dragProxyMC.removeChildAt(0);
		}
		container.addChild(dragProxyMC);
		
		var globalPos:IntPoint = AsWingUtils.getStageMousePosition();
		var dp:Point = container.globalToLocal(globalPos.toPoint());
		dragProxyMC.x = dp.x;
		dragProxyMC.y = dp.y;
		
		dragProxyMC.addChild(dragImage.getDisplay());
		dragProxyMC.startDrag(false, AsWingUtils.getVisibleMaximizedBounds().toRectangle());
		
		mouseOffset = new IntPoint(container.mouseX - dp.x, container.mouseY - dp.y);
		fireDragStartEvent(s_dragInitiator, s_sourceData, globalPos);
		
		enteredComponent = null;
		//initial image
		s_dragImage.switchToRejectImage();
		__onMouseMove(null);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
	}
		
	/**
	 * Adds a drag listener to listener list.
	 * @param lis the listener to be add
	 */
	public static function addDragListener(lis:DragListener):void{
		listeners.push(lis);
	}
	
	/**
	 * Removes the specified listener from listener list.
	 * @param lis the listener to be removed
	 */
	public static function removeDragListener(lis:DragListener):void{
		ArrayUtils.removeFromArray(listeners, lis);
	}
	
	/**
	 * Sets the motion of drag movie clip when a drop acted.
	 * <p>
	 * Generally if you want to do a custom motion of the dragging movie clip when dropped, you may 
	 * call this method in the listener's <code>onDragDrop()</code> method.
	 * <p>
	 * Every drop acted, the default motion will be set to <code>DirectlyRemoveMotion</code> 
	 * so you need to set to yours every drop time if you want.
	 * @param motion the motion
	 * @see org.aswing.dnd.DropMotion
	 * @see org.aswing.dnd.DirectlyRemoveMotion
	 * @see org.aswing.dnd.RejectedMotion
	 * @see org.aswing.dnd.DragListener#onDragDrop()
	 */
	public static function setDropMotion(motion:DropMotion):void{
		if(motion == null) motion = DEFAULT_DROP_MOTION;
		dropMotion = motion;
	}
	
	/**
	 * Returns the drag image.
	 */
	public static function getCurrentDragImage():DraggingImage{
		return s_dragImage;
	}
	
	/**
	 * Returns current drop target of dragging components by startDrag method.
	 * @return the drop target
	 * @see #startDrag()
	 * @see #getDropTarget()
	 */
	public static function getCurrentDropTarget():DisplayObject{
		return getDropTarget();
	}
	
	/**
	 * Returns current drop target component of dragging components by startDrag method.
	 * @return the drop target component
	 * @see #startDrag()
	 * @see #getDropTargetComponent()
	 */
	public static function getCurrentDropTargetComponent():Component{
		return getDropTarget(null, Component) as Component;
	}
	
	/**
	 * Returns current drop target drop trigger component of dragging components by startDrag method.
	 * @return the drop target drop trigger component
	 * @see #startDrag()
	 * @see #getDropTargetDropTriggerComponent()
	 */
	public static function getCurrentDropTargetDropTriggerComponent():Component{
		return getDropTarget(
			null, 
			Component, 
			____dropTargetCheck) as Component;
	}
	
	private static function ____dropTargetCheck(tar:Component):Boolean{
		return tar.isDropTrigger();
	}
	
	/**
	 * Returns the drop target of specified position and specified class type.
	 * For example:<br/>
	 * <pre>
	 * getDropTarget(new Point(0, 0), TextField);
	 * will return the first textfield insance under the point, or null if not found.
	 * 
	 * getDropTarget(null, null);
	 * will return the first display object insance under the current mouse point, or null if not found.
	 * </pre>
	 * @param pos The point under which to look, in the coordinate space of the Stage.
	 * @param targetType the class type of the target, default is null, means any display object.
	 * @param addtionCheck, a check function, only return the target when function(target:DisplayOject) return true. 
	 * default is null, means no this check.
	 * @return drop target
	 */
	public static function getDropTarget(pos:Point=null, 
		targetType:Class=null, 
		addtionCheck:Function=null):DisplayObject{
		var stage:Stage = AsWingManager.getStage();
		if(stage == null){
			return null;
		}
		if(pos == null){
			pos = new Point(stage.mouseX, stage.mouseY);
		}
		if(targetType == null){
			targetType = DisplayObject;
		}
		if(addtionCheck == null){
			
		}
		var targets:Array = stage.getObjectsUnderPoint(pos);
		var n:int = targets.length;
		for(var i:int=n-1; i>=0; i--){
			var tar:DisplayObject = targets[i];
			if(tar is targetType && tar != dragProxyMC && !dragProxyMC.contains(tar)){
				if(addtionCheck == null){
					return tar;
				}else if(addtionCheck(tar)){
					return tar;
				}
			}
		}
		return null;
	}
		
	//---------------------------------------------------------------------------------
	
	private static function __onMouseMove(e:MouseEvent):void{
		var globalPos:IntPoint;
		if(e == null){
			globalPos = new IntPoint(AsWingManager.getStage().mouseX, AsWingManager.getStage().mouseY);
		}else{
			globalPos = new IntPoint(e.stageX, e.stageY);
		}
		
		var dropC:Component = getCurrentDropTargetDropTriggerComponent();
		if(dropC != enteredComponent){
			if(enteredComponent != null){
				s_dragImage.switchToRejectImage();
				fireDragExitEvent(s_dragInitiator, s_sourceData, globalPos, enteredComponent, dropC);
				enteredComponent.fireDragExitEvent(s_dragInitiator, s_sourceData, globalPos, dropC);
			}
			if(dropC != null){
				if(dropC.isDragAcceptableInitiator(s_dragInitiator)){
					s_dragImage.switchToAcceptImage();
				}
				fireDragEnterEvent(s_dragInitiator, s_sourceData, globalPos, dropC, enteredComponent);
				dropC.fireDragEnterEvent(s_dragInitiator, s_sourceData, globalPos, enteredComponent);
			}
			enteredComponent = dropC;
		}else{
			if(enteredComponent != null){
				fireDragOverringEvent(s_dragInitiator, s_sourceData, globalPos, enteredComponent);
				enteredComponent.fireDragOverringEvent(s_dragInitiator, s_sourceData, globalPos);
			}
		}
	}
	
	private static function __onMouseUp(e:MouseEvent):void{
		drop();
	}
	
	private static function __onMouseDown(e:MouseEvent):void{
		drop(); //why call drop again when mouse down?
		//just because if you released mouse outside of flash movie, then the mouse up
		//was not triggered. So if that happened, when user reclick mouse, the drop will 
		//fire (the right behavor to ensure dragging thing was dropped).
		//Well, if user released mouse rightly in the flash movie, then the drop be called, 
		//and in drop method, the mouse listener was removed, so it will not be called drop 
		//again when next mouse down. :)
	}
	
	private static function drop():void{
		dragProxyMC.stopDrag();
		var globalPos:IntPoint = AsWingUtils.getStageMousePosition();
		var dropC:Component = getCurrentDropTargetDropTriggerComponent();
		
		var stage:Stage = AsWingManager.getStage();
		stage.addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		s_isDragging = false;
		
		if(enteredComponent != null){
			setDropMotion(DEFAULT_DROP_MOTION);
		}else{
			setDropMotion(DEFAULT_REJECT_DROP_MOTION);
		}
		fireDragDropEvent(s_dragInitiator, s_sourceData, globalPos, enteredComponent);
		dropMotion.startMotionAndLaterRemove(s_dragInitiator, dragProxyMC);
		if(enteredComponent != null){
			enteredComponent.fireDragDropEvent(s_dragInitiator, s_sourceData, globalPos);
		}
		
		if(s_dragListener != null){
			removeDragListener(s_dragListener);
		}
		s_dragImage = null;
		dragProxyMC = null;
		s_dragListener = null;
		s_sourceData = null;
		enteredComponent = null;
	}
		
	private static function fireDragStartEvent(dragInitiator:Component, sourceData:SourceData, pos:IntPoint):void{
		var e:DragAndDropEvent = new DragAndDropEvent(
			DragAndDropEvent.DRAG_START, 
			dragInitiator, 
			sourceData, 
			pos
		);
		for(var i:int=0; i<listeners.length; i++){
			var lis:DragListener = listeners[i];
			lis.onDragStart(e);
		}
	}
	
	private static function fireDragEnterEvent(dragInitiator:Component, sourceData:SourceData, pos:IntPoint, targetComponent:Component, relatedTarget:Component):void{
		var e:DragAndDropEvent = new DragAndDropEvent(
			DragAndDropEvent.DRAG_ENTER, 
			dragInitiator, 
			sourceData, 
			pos, 
			targetComponent, 
			relatedTarget
		);
		for(var i:int=0; i<listeners.length; i++){
			var lis:DragListener = listeners[i];
			lis.onDragEnter(e);
		}
	}
	
	private static function fireDragOverringEvent(dragInitiator:Component, sourceData:SourceData, pos:IntPoint, targetComponent:Component):void{
		var e:DragAndDropEvent = new DragAndDropEvent(
			DragAndDropEvent.DRAG_ENTER, 
			dragInitiator, 
			sourceData, 
			pos, 
			targetComponent
		);
		for(var i:int=0; i<listeners.length; i++){
			var lis:DragListener = listeners[i];
			lis.onDragOverring(e);
		}
	}
	
	private static function fireDragExitEvent(dragInitiator:Component, sourceData:SourceData, pos:IntPoint, targetComponent:Component, relatedTarget:Component):void{
		var e:DragAndDropEvent = new DragAndDropEvent(
			DragAndDropEvent.DRAG_ENTER, 
			dragInitiator, 
			sourceData, 
			pos, 
			targetComponent, 
			relatedTarget
		);
		for(var i:int=0; i<listeners.length; i++){
			var lis:DragListener = listeners[i];
			lis.onDragExit(e);
		}
	}
	
	private static function fireDragDropEvent(dragInitiator:Component, sourceData:SourceData, pos:IntPoint, targetComponent:Component):void{
		var e:DragAndDropEvent = new DragAndDropEvent(
			DragAndDropEvent.DRAG_ENTER, 
			dragInitiator, 
			sourceData, 
			pos, 
			targetComponent
		);		
		for(var i:int=0; i<listeners.length; i++){
			var lis:DragListener = listeners[i];
			lis.onDragDrop(e);
		}
	}	
}
}