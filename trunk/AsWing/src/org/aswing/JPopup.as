/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import org.aswing.util.*;
import flash.display.*;
import org.aswing.event.*;
import flash.events.*;
import org.aswing.graphics.*;

/**
 * JPopup is a component that generally be a base container of a window panel.
 * <p>
 * <b>Note:</b>
 * You should call <code>dispose()</code> to remove a JPopup from stage.<br>
 * You'd better call <code>AsWingUtils.setRoot(theRoot)</code> to set a root 
 * for all popup as default root when application initialization.
 * </p>
 * @see org.aswing.JWindow
 * @author iiley
 */
public class JPopup extends Container{
	
	private static var popups:Vector;
	
	private var ground_mc:Sprite;
	private var modalMC:Sprite;
	private var owner:*;
	private var modal:Boolean;
	
	private var lastLAF:Object;	
	
	/**
	 * JPopup(owner:JPopup, modal:Boolean)<br>
	 * JPopup(owner:DisplayObjectContainer, modal:Boolean)<br>
	 * JPopup(owner:JPopup)<br>
	 * JPopup(owner:DisplayObjectContainer)<br>
	 * JPopup()<br>
	 * Create a JPopup
	 * @param owner the owner of this popup, it can be a DisplayObjectContainer or a JPopup, default it is default 
	 * is <code>AsWingUtils.getRoot()</code>
	 * @param modal true for a modal dialog, false for one that allows other windows to be active at the same time,
	 *  default is false.
	 * @see org.aswing.AsWingUtils#getRoot()
	 * @throw Error if not specified the owner, and aswing default root is not specified either.
	 * @throw Error if the owner is not a JPopup nor DisplayObjectContainer
	 */
	public function JPopup(owner:*=null, modal:Boolean=false){
		super();
		if(owner == null){
			if(AsWingUtils.getRoot() == null){
				throw new Error("Default root is not inited, please set a default root by calling " + 
						"AsWingUtils.setRoot(theRoot) before this constructing!");
			}
			owner = AsWingUtils.getRoot();
		}
		if(owner is JPopup || owner is DisplayObjectContainer){
			this.owner = owner;
		}else{
			throw new Error(this + " JPopup's owner is not a mc or JPopup, owner is : " + owner);
		}
		setName("JPopup");
		ground_mc = new Sprite();
		ground_mc.name = "ground_mc";
		ground_mc.visible = false;
		
		layout = new BorderLayout();
		lastLAF = UIManager.getLookAndFeel();
		
		modalMC = new Sprite();
		initModalMC();
		ground_mc.addChild(modalMC);
		ground_mc.addChild(this);
		
		visible = false;
		addEventListener(Event.ADDED_TO_STAGE, __popupOntoDisplayList);
		addEventListener(Event.REMOVED_FROM_STAGE, __popupOfffromDisplayList);
	}
	
	private function __popupOntoDisplayList(e:Event):void{
		getPopupsVector().append(this);
	}
	private function __popupOfffromDisplayList(e:Event):void{
		getPopupsVector().remove(this);	
	}
		
	/**
	 * @return true always here.
	 */
	override public function isValidateRoot():Boolean{
		return true;
	}	
	
	/**
	 * This will return the owner of this JPopup, it maybe a DisplayObjectContainer maybe a JPopup.
	 */
	public function getOwner():*{
		return owner;
	}
	
	/**
	 * This will return the owner of this JPopup, it return a JPopup if
	 * this window's owner is a JPopup, else return null;
	 * @return the owner.
	 */
	public function getPopupOwner():JPopup{
		return owner as JPopup;
	}
	
	/**
	 * Returns the owner as <code>DisplayObjectContainer</code>, null if it is not <code>DisplayObjectContainer</code>.
	 * @return the owner.
	 */
	public function getDisplayOwner():DisplayObjectContainer{
		return owner as DisplayObjectContainer;
	}
	
	/**
	 * changeOwner(owner:JPopup)<br>
	 * changeOwner(owner:MovieClip)
	 * <p>
	 * Changes the owner. While the popup is displayable, you can't change the owner of it.
	 * @param owner the new owner to apply
	 * @return true if changed successfully, false otherwise
	 */
	public function changeOwner(owner:*):Boolean{
		if(this.owner != owner){
			if(isDisplayable()){
				//TODO can be successfully, just do it
				return false;
			}
			this.owner = owner;
		}
		return true;
	}
	
	/**
	 * Specifies whether this dialog should be modal.
	 */
	public function setModal(m:Boolean):void{
		if(modal != m){
			modal = m;
			modalMC.visible = modal;
		}
	}
	
	/**
	 * Returns is this dialog modal.
	 */
	public function isModal():Boolean{
		return modal;
	}	
	
			
	/**
	 * Shortcut of <code>setVisible(true)</code>
	 */
	public function show():void{
		setVisible(true);
	}
	
	/**
	 * Shows or hides the Popup. 
	 * <p>Shows the window when set visible true, If the Popup and/or its owner are not yet displayable(and if Owner is a JPopup),
	 * both are made displayable. The Popup will be made visible and bring to top;
	 * <p>Hides the window when set visible false, just hide the Popup's MCs.
	 * @param v true to show the window, false to hide the window.
	 * @throws Error if the window has not a {@link JPopup} or <code>MovieClip</code> owner currently, 
	 * generally this should be never occur since the default owner is <code>_root</code>.
	 * @see #show()
	 * @see #hide()
	 */	
	override public function setVisible(v:Boolean):void{
		ground_mc.visible = v;
		if(v != visible || (v && !isAddedToList())){
			super.setVisible(v);
			
			if(v){
				if(!isAddedToList()){
					equipPopupContents();
				}
				resetModalMC();
				//TODO event
				//dispatchEvent(createEventObj(ON_WINDOW_OPENED));
			}else{
				//TODO event
				//dispatchEvent(createEventObj(ON_WINDOW_CLOSED));
			}
		}
		if(v){
			toFront();
		}
	}
	
	private function isAddedToList():Boolean{
		return ground_mc.parent != null;
	}
	
	/**
	 * Shortcut of <code>setVisible(false)</code>
	 */
	public function hide():void{
		setVisible(false);
	}
	
	/**
	 * Remove all of this window's source movieclips.(also the components in this window will be removed too)
	 */
	public function dispose():void{
		if(isAddedToList()){
			d_visible = false;
			//TODO check this
			//getPopupOwner().removeEventListener(listenerToOwner);
			disposeProcess();
			ground_mc.parent.removeChild(ground_mc);
			//TODO event
			//dispatchEvent(createEventObj(ON_WINDOW_CLOSED));
		}
	}
	
	/**
	 * override this method to do process when disposing
	 */
	protected function disposeProcess():void{
	}	
	
	/**
	 * If this Popup is visible, sends this Popup to the back and may cause it to lose 
	 * focus or activation if it is the focused or active Popup.
	 * <p>Infact this sends this JPopup to the back of all the MCs in its owner's MC
	 *  except it's owner's root_mc, it's owner is always below it.<br>
	 * @see #toFront()
	 */
	public function toBack():void{
		if(isDisplayable() && visible){
			if(!DepthManager.isBottom(ground_mc, getPopupOwner())){
				DepthManager.bringToBottom(ground_mc, getPopupOwner());
			}
		}
	}
	
	/**
	 * If this Popup is visible, brings this Popup to the front and may make it the focused Popup.
	 * <p>Infact this brings this JPopup to the front in his owner, all owner's MovieClips' front.
	 * @see #toBack()
	 */
	public function toFront():void{
		if(isDisplayable() && visible){
			if(!DepthManager.isTop(ground_mc)){
				DepthManager.bringToTop(ground_mc);	
			}
		}
	}	
	
	/**
	 * Return an array containing all the windows this window currently owns.
	 */
	public function getOwnedPopups():Array{
		return getOwnedPopupsWithOwner(this);
	}
	
	private static function getPopupsVector():Vector{
		if(popups == null){
			popups = new Vector();
		}
		return popups;
	}
	
	/**
	 * Returns all displable windows currently. A window was disposed or destroied will not 
	 * included by this array.
	 * @return all displable windows currently.
	 */
	public static function getPopups():Array{
		return getPopupsVector().toArray();
	}
	
	/**
	 * getOwnedPopupsWithOwner(owner:JPopup)<br>
	 * getOwnedPopupsWithOwner(owner:MovieClip)
	 * <p>
	 * Returns owned windows of the specifid owner.
	 * @return owned windows of the specifid owner.
	 */
	public static function getOwnedPopupsWithOwner(owner:*):Array{
		var ws:Array = new Array();
		var n:int = getPopupsVector().size();
		for(var i:int=0; i<n; i++){
			var w:JPopup = JPopup(getPopupsVector().get(i));
			if(w.getOwner() === owner){
				ws.push(w);
			}
		}
		return ws;
	}	
	
	/**
	 * Returns the window's ancestor display object which it/it's owner is created on.
	 * @return the ancestor display object of this window 
	 */
	public function getPopupAncestorMC():DisplayObjectContainer{
		var ow:JPopup = this;
		while(ow.getPopupOwner() != null){
			ow = ow.getPopupOwner();
		}
		return ow.getDisplayOwner();
	}
	
	/**
	 * This is just for PopupUI to draw modalMC face.
	 * @return the modal sprite
	 */
	public function getModalMC():Sprite{
		return modalMC;
	}
	
	/**
	 * Resets the modal mc to cover the hole screen
	 */
	public function resetModalMC():void{
		if(!isModal()){
			modalMC.y = 1000000;
			modalMC.visible = false;
			return;
		}
		modalMC.visible = true;
		//TODO modal
		//var globalBounds:Rectangle = ASWingUtils.getVisibleMaximizedBounds(ground_mc);
		//modalMC._width = Stage.width+200;
		//modalMC._height = Stage.height+200;
		//modalMC._x = globalBounds.x - getX() - 100;
		//modalMC._y = globalBounds.y - getY() - 100;
	}
			
	/**
	 * Returns the component's depth, return -1 if it is not in display list.
	 * @return the depth
	 */
	public function getDepth():int{
		if(ground_mc.parent != null){
			return ground_mc.parent.getChildIndex(ground_mc);
		}
		return -1;
	}
	
	//--------------------------------------------------------
	
	private function equipPopupContents():void{
		if(owner is JPopup){
			var jwo:JPopup = JPopup(owner);
			jwo.ground_mc.addChild(ground_mc);
		}else if(owner is DisplayObjectContainer){
			var ownerMC:DisplayObjectContainer = DisplayObjectContainer(owner);
			ownerMC.addChild(ground_mc);
		}else {
			throw new Error(this + " JPopup's owner is not a mc or JPopup, owner is : " + owner);
		}
		if(lastLAF != UIManager.getLookAndFeel()){
			//TODO update UI
			//ASWingUtils.updateComponentTreeUI(this);
			lastLAF = UIManager.getLookAndFeel();
		}
	}
		
	private function initModalMC():void{
		modalMC.tabEnabled = false;
		//TODO check if need this
		modalMC.addEventListener(MouseEvent.ROLL_OVER, function(e:Event):void{});
		modalMC.visible = modal;
    	modalMC.graphics.clear();
    	var modalColor:ASColor = new ASColor(0, 0);
		var g:Graphics2D = new Graphics2D(modalMC.graphics);
		g.fillRectangle(new SolidBrush(modalColor), 0, 0, 1, 1);
	}	
	
}
}