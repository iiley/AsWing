/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{
	
import org.aswing.util.Vector;
import org.aswing.geom.*;
import org.aswing.event.WindowEvent;
import flash.events.MouseEvent;	

/**
 * Dispatched when the window be set actived from not being actived.
 * @eventType org.aswing.event.WindowEvent.WINDOW_ACTIVATED
 */
[Event(name="windowActived", type="org.aswing.event.WindowEvent")]
	
/**
 *  Dispatched when the window be set not actived from being actived.
 *  @eventType org.aswing.event.WindowEvent.WINDOW_DEACTIVATED
 */
[Event(name="windowDeactived", type="org.aswing.event.WindowEvent")]

/**
 * JWindow is a Container, but you should not add component to JWindow directly,
 * you should add component like this:<br>
 * <pre>
 * 		jwindow.getContentPane().append(child);
 * </pre>
 * <p>The same is true of setting LayoutManagers, removing components, listing children, etc.
 * All these methods should normally be sent to the contentPane instead of the JWindow itself. 
 * The contentPane will always be non-null. Attempting to set it to null will cause the JWindow to throw an Error. 
 * The default contentPane will have a BorderLayout manager set on it. 
 * </p>
 * <p>But if you really want to add child to JWindow like how JDialog and JFrame does,
 * just do it with setting a new <code>LayoutManager</code> to layout them, normally if you want to 
 * extends JWindow to make a new type Window, you may need to add child to JWindow, example a title 
 * bar on top, a menubar on top, a status bar on bottom, etc.
 * </p>
 * @author iiley
 */
public class JWindow extends JPopup{

	private var contentPane:Container;
	private var actived:Boolean;
	
	private var focusWhenDeactive:Component;
	private var lootActiveFrom:JWindow;
	
	public function JWindow(owner:*=null, modal:Boolean=false){
		super(owner, modal);
		setName("JWindow");
		actived = false;
		layout = new WindowLayout();
		setFocusTraversalPolicy(new WindowOrderFocusTraversalPolicy());
		
		addEventListener(MouseEvent.MOUSE_DOWN, __activeWhenPress, true, 1);
		//TODO imp
		//listenerToOwner[ON_WINDOW_ICONIFIED] = Delegate.create(this, __ownerIconified);
		//listenerToOwner[ON_WINDOW_RESTORED] = Delegate.create(this, __ownerRestored);
		//listenerToOwner[ON_WINDOW_MAXIMIZED] = listenerToOwner[ON_WINDOW_RESTORED];
	}
	
	/**
	 * Sets the layout for the window.
	 * @throws Error when you try to set a non-WindowLayout instance.
	 */
	override public function setLayout(layout:LayoutManager):void{
		if(layout is WindowLayout){
			var oldLayout:WindowLayout = this.layout as WindowLayout;
			super.setLayout(layout);
			if(oldLayout != null){
				if(oldLayout.getTitleBar() != null){
					layout.addLayoutComponent(oldLayout.getTitleBar(), WindowLayout.TITLE);
				}
				if(oldLayout.getContentPane() != null){
					layout.addLayoutComponent(oldLayout.getContentPane(), WindowLayout.CONTENT);
				}
			}
		}else{
			trace(this + " Can not set a non-WindowLayout Layout to JWindow");
			throw new Error(this + " Can not set a non-WindowLayout Layout to JWindow");
		}
	}
		
	/**
	 * Check size first to make sure current size is not min than <code>getMinimumSize</code>, 
	 */
	override public function paintImmediately():void{
		if(isVisible()){
			var minimizSize:IntDimension = getMinimumSize();
			var needSize:IntDimension = new IntDimension(Math.max(getWidth(), minimizSize.width),
													Math.max(getHeight(), minimizSize.height));
			setSize(needSize);
			super.paintImmediately();
			revalidateIfNecessary();
		}else{
			super.paintImmediately();
		}
	}
			
	/**
	 * Returns the content pane of this window.
	 * @return the content pane
	 */
	public function getContentPane():Container{
		if(contentPane == null){
			var p:Container = new Container();
			p.setLayout(new BorderLayout());
			setContentPaneImp(p);
		}
		return contentPane;
	}
	
	/**
	 * Sets the window's content pane.
	 * @param cp the content pane you want to set to the window.
	 * @throws Error when cp is null or undefined
	 */
	public function setContentPane(cp:Container):void{
		if(cp != contentPane){
			if(cp == null){
				throw new Error(this + " Can not set null to be JWindow's contentPane!");
			}else{
				setContentPaneImp(cp);
			}
		}
	}
	
	private function setContentPaneImp(cp:Container):void{
		if(contentPane != null){
			contentPane.removeFromContainer();
		}
		contentPane = cp;
		append(contentPane, WindowLayout.CONTENT);
	}
			
	/**
	 * This will return the owner of this JWindow, it return a JWindow if
	 * this window's owner is a JWindow, else return null;
	 */
	public function getWindowOwner():JWindow{
		return owner as JWindow;
	}
	
	/**
	 * Return an array containing all the windows this window currently owns.
	 */
	public function getOwnedWindows():Array{
		return getOwnedWindowsWithOwner(this);
	}
	
	/**
	 * Shows or hides the Window. 
	 * <p>Shows the window when set visible true, If the Window and/or its owner are not yet displayable(and if Owner is a JWindow),
	 * both are made displayable. The Window will be made visible and bring to top;
	 * <p>Hides the window when set visible false, just hide the Window's MCs.
	 * @param v true to show the window, false to hide the window.
	 * @throws Error if the window has not a {@link JWindow} or <code>MovieClip</code> owner currently, 
	 * generally this should be never occur since the default owner is <code>_root</code>.
	 * @see #show()
	 * @see #hide()
	 */	
	override public function setVisible(v:Boolean):void{
		super.setVisible(v);
		if(v){
			setActive(true);
		}else{
			lostActiveAction();
		}
	}
	
	override protected function disposeProcess():void{
		lostActiveAction();
	}	
		
	/**
	 * Returns whether this Window is active. 
	 * The active Window is always either the focused Window, 
	 * or the first Frame or Dialog that is an owner of the focused Window. 
	 */
	public function isActive():Boolean{
		return actived;
	}
	
	/**
	 * Sets the window to be actived or unactived.
	 */
	public function setActive(b:Boolean):void{
		if(actived != b){
			if(b){
				active();
			}else{
				deactive();
			}
		}
	}
	
	/**
	 * Request focus to this window's default focus component or last focused component when 
	 * last deactived.
	 */
	public function focusAtThisWindow():void{
		var defaultFocus:Component = focusWhenDeactive;
		if(defaultFocus == null || 
			!(AsWingUtils.isAncestor(this, defaultFocus) 
				&& defaultFocus.isShowing() 
				&& defaultFocus.isFocusable() 
				&& defaultFocus.isEnabled())){
			defaultFocus = getFocusTraversalPolicy().getDefaultComponent(this);
		}
		if(defaultFocus == null){
			defaultFocus = this;
		}
		focusWhenDeactive = null;
		defaultFocus.requestFocus();
	}
			
	/**
	 * Returns all displable windows currently. A window was disposed or destroied will not 
	 * included by this array.
	 * @return all displable windows currently.
	 * @see JPopup#getPopups()
	 */
	public static function getWindows():Array{
		var vec:Vector = getPopupsVector();
		var arr:Array = new Array();
		for(var i:int=0; i<vec.size(); i++){
			var win:Object = vec.get(i);
			if(win is JWindow){
				arr.push(win);
			}
		}
		return arr;
	}
	
	/**
	 * getOwnedWindowsWithOwner(owner:JWindow)<br>
	 * getOwnedWindowsWithOwner(owner:DisplayObjectContainer)
	 * <p>
	 * Returns owned windows of the specifid owner.
	 * @return owned windows of the specifid owner.
	 * @see JPopup#getOwnedPopupsWithOwner()
	 */
	public static function getOwnedWindowsWithOwner(owner:*):Array{
		var ws:Array = new Array();
		var n:int = getPopupsVector().size();
		var vec:Vector = getPopupsVector();
		for(var i:int=0; i<n; i++){
			var w:JPopup = JPopup(vec.get(i));
			if(w is JWindow && w.getOwner() === owner){
				ws.push(w);
			}
		}
		return ws;
	}
	
	//--------------------------------------------------------
	/*private var visibleWhenOwnerIconing:Boolean;
	private function __ownerIconified():void{
		visibleWhenOwnerIconing = isVisible();
		if(visibleWhenOwnerIconing){
			lostActiveAction();
			ground_mc._visible = false;
		}
	}
	private function __ownerRestored():void{
		if(visibleWhenOwnerIconing){
			ground_mc._visible = true;
		}
	}
	*/
	
	private function lostActiveAction():void{
		if(isActive()){
			deactive();
			if(getLootActiveFrom() != null && getLootActiveFrom().isShowing()){
				getLootActiveFrom().active();
			}
		}
		setLootActiveFrom(null);
	}
		
	private function getLootActiveFrom():JWindow{
		return lootActiveFrom;
	}
	private function setLootActiveFrom(activeOwner:JWindow):void{
		if(activeOwner != null && activeOwner.getLootActiveFrom() == this){
			activeOwner.lootActiveFrom = lootActiveFrom;
		}
		lootActiveFrom = activeOwner;
	}
	
	private function active():void{
		actived = true;
		var vec:Vector = getPopupsVector();
		for(var i:Number=0; i<vec.size(); i++){
			var w:JWindow = JWindow(vec.get(i));
			if(w != null && w != this){
				if(w.isActive()){
					w.deactive();
					setLootActiveFrom(w);
				}
			}
		}
		FocusManager.getCurrentManager().setActiveWindow(this);
		focusAtThisWindow();
		dispatchEvent(new WindowEvent(WindowEvent.WINDOW_ACTIVATED));
	}
	
	private function deactive():void{
		actived = false;
		//recored this last focus component
		focusWhenDeactive = FocusManager.getCurrentManager().getFocusOwner();
		if(!AsWingUtils.isAncestor(this, focusWhenDeactive)){
			focusWhenDeactive = null;
		}
		//KeyboardManager.getInstance().unregisterKeyMap(getKeyMap());
		FocusManager.getCurrentManager().setActiveWindow(null);
		dispatchEvent(new WindowEvent(WindowEvent.WINDOW_DEACTIVATED));
	}
	
	//---------------------------------------------------------------------
	
	private function __activeWhenPress(e:MouseEvent):void{
		if(getWindowOwner() != null){
			getWindowOwner().toFront();
		}
		if(!isActive()){
			toFront();
			active();
		}
	}
}
}