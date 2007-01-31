/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.*;
import flash.geom.Rectangle;

import org.aswing.error.ImpMissError;
import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.event.MovedEvent;
import org.aswing.event.ResizedEvent;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.*;
import org.aswing.util.HashMap;
import org.aswing.util.Reflection;
import flash.display.Sprite;
	
//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched when the component visible is set to true from false.
 *
 *  @eventType org.aswing.event.AWEvent.SHOWN
 */
[Event(name="shown", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched when the component visible is set to false from true.
 *
 *  @eventType org.aswing.event.AWEvent.HIDDEN
 */
[Event(name="hidden", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched when the component is painted.
 *
 *  @eventType org.aswing.event.AWEvent.PAINT
 */
[Event(name="paint", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched when the component is moved.
 *
 *  @eventType org.aswing.event.AWEvent.MOVED
 */
[Event(name="moved", type="org.aswing.event.AWEvent")]
	
/**
 *  Dispatched when the component is resized.
 *
 *  @eventType org.aswing.event.AWEvent.RESIZED
 */
[Event(name="resized", type="org.aswing.event.AWEvent")]

/**
 * Dispatched when the component gained the focus from it is not the focus owner
 * 
 * @eventType org.aswing.event.AWEvent.FOCUS_GAINED
 */
[Event(name="focusGained", type="org.aswing.event.AWEvent")]
	
/**
 * Dispatched when the component lost the focus from it was the focus owner.
 * 
 * @eventType org.aswing.event.AWEvent.FOCUS_LOST
 */
[Event(name="focusLost", type="org.aswing.event.AWEvent")]

/**
 * Dispatched when the key down and the component is the focus owner.
 * 
 * @eventType org.aswing.event.FocusKeyEvent.FOCUS_KEY_DOWN
 */
[Event(name="focusKeyDown", type="org.aswing.event.FocusKeyEvent")]
	
/**
 * Dispatched when the key up and the component is the focus owner.
 * 
 * @eventType org.aswing.event.FocusKeyEvent.FOCUS_KEY_UP
 */
[Event(name="focusKeyUp", type="org.aswing.event.FocusKeyEvent")]

/**
 * The super class for all Components.
 * 
 * <p>The maximumSize and minimumSize are the component's represent max or min size.</p>
 * 
 * <p>You can set a Component's size max than its maximumSize, but when it was drawed,
 * it will not max than its maximumSize.Just as its maximumSize and posited itself
 * in that size dimension you just setted. The position is relative to <code>getAlignmentX</code> 
 * and <code>getAlignmentY<code>.
 * </p>
 * @see #setSize()
 * @see #setPrefferedSize()
 * @see #getAlignmentX()
 * 
 * @author iiley
 */	
public class Component extends AWSprite
{
	protected var ui:ComponentUI;
	private var clientProperty:HashMap;
	
	private var awmlID:String;
	private var awmlIndex:Number;
	private var awmlNamespace:String;
	
	private var alignmentX:Number;
	private var alignmentY:Number;
	private var minimumSize:IntDimension;
	private var maximumSize:IntDimension;
	private var preferredSize:IntDimension;
	private var cachePreferSizes:Boolean;
	private var cachedPreferredSize:IntDimension;
	private var cachedMinimumSize:IntDimension;
	private var cachedMaximumSize:IntDimension;
	private var constraints:Object;
	
	protected var valid:Boolean;
	protected var bounds:IntRectangle;
	protected var readyToPaint:Boolean;
	
	private var clipBounds:IntRectangle;
	private var clipMasked:Boolean;
	private var background:ASColor;
	private var foreground:ASColor;
	private var backgroundDecorator:GroundDecorator;
	private var foregroundDecorator:GroundDecorator;
	private var font:ASFont;
	private var fontValidated:Boolean;
	private var opaque:Boolean;
	private var opaqueSet:Boolean;
	private var border:Border;
	private var enabled:Boolean;
	private var focusable:Boolean;
	private var focusableSet:Boolean;
	
	public function Component()
	{
		super();
		setName("Component");
		ui = null;
		clientProperty = null;
		alignmentX = 0;
		alignmentY = 0;
		bounds = new IntRectangle();
		clipMasked = true;
		opaque = false;
		opaqueSet = false;
		valid = false;
		enabled = true;
		focusable = false;
		focusableSet = false;
		cachePreferSizes = true;
		fontValidated = false;
		border = DefaultEmptyDecoraterResource.INSTANCE;
		backgroundDecorator = DefaultEmptyDecoraterResource.INSTANCE;
		foregroundDecorator = DefaultEmptyDecoraterResource.INSTANCE;
		if(!AsWingManager.isStageInited()){
			addEventListener(Event.ADDED_TO_STAGE, __repaintManagerStarter);
		}
		addEventListener(FocusEvent.FOCUS_IN, __focusIn);
		addEventListener(FocusEvent.FOCUS_OUT, __focusOut);
		addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
	}
	
	private function __repaintManagerStarter(e:Event):void{
		AsWingManager.initStage(stage);
		removeEventListener(Event.ADDED_TO_STAGE, __repaintManagerStarter);
	}
		    
	/**
	 * Sets ID used to identify components created from AWML. Used to obtain components through 
	 * {@link org.aswing.awml.AwmlManager}. You should never modify this value.
	 * 
	 * @param id the component's AWML ID
	 */
	public function setAwmlID(id:String):void {
		awmlID = id;	
	}

	/**
	 * Returns ID used to identify components created from AWML.
	 * 
	 * @return the AWML ID
	 */
	public function getAwmlID():String {
		return awmlID;
	}

	/**
	 * Sets namespace used to identify components created from AWML. 
	 * Used to obtain components through {@link org.aswing.awml.AwmlManager}. 
	 * You should never modify this value.
	 * 
	 * @param theNamespace the new namespace name
	 */
	public function setAwmlNamespace(theNamespace:String):void {
		awmlNamespace = theNamespace;	
	}

	/**
	 * Returns namespace name used to identify components created from AWML.
	 * 
	 * @return the namespace name
	 */
	public function getAwmlNamespace():String {
		return awmlNamespace;	
	}

	/**
	 * Sets ID used to identify components created from AWML. Used to obtain components through 
	 * {@link org.aswing.awml.AwmlManager}. You should never modify this value.
	 * 
	 * @param index the position index of the component
	 */
	public function setAwmlIndex(index:Number):void {
		awmlIndex = index;	
	}

	/**
	 * Returns position index of the component inside its AWML container.
	 * 
	 * @return the component index in the AWML
	 */
	public function getAwmlIndex():Number {
		return awmlIndex;	
	}
	    
	/**
     * Returns the <code>UIDefaults</code> key used to
     * look up the name of the <code>org.aswing.plaf.ComponentUI</code>
     * class that defines the look and feel
     * for this component.  Most applications will never need to
     * call this method.  Subclasses of <code>Component</code> that support
     * pluggable look and feel should override this method to
     * return a <code>UIDefaults</code> key that maps to the
     * <code>ComponentUI</code> subclass that defines their look and feel.
     *
     * @return the <code>UIDefaults</code> key for a
     *		<code>ComponentUI</code> subclass
     * @see org.aswing.UIDefaults#getUI()
     */
	public function getUIClassID():String{
		return "ComponentUI";
	}
	
	/**
	 * Sets the name of this component
	 * @see #name
	 */
	public function setName(name:String):void{
		this.name = name;
	}
	
	/**
	 * Returns the name of the component
	 * @see #name
	 */
	public function getName():String{
		return name;
	}
	
    /**
     * Resets the UI property to a value from the current look and feel.
     * <code>Component</code> subclasses must override this method
     * like this:
     * <pre>
     *   public void updateUI() {
     *      setUI(SliderUI(UIManager.getUI(this)));
     *   }
     *  </pre>
     *
     * @see #setUI()
     * @see org.aswing.UIManager#getLookAndFeel()
     * @see org.aswing.UIManager#getUI()
     */
    public function updateUI():void{
    	throw new ImpMissError();
    }

    /**
     * Sets the look and feel delegate for this component.
     * <code>Component</code> subclasses generally override this method
     * to narrow the argument type. For example, in <code>JSlider</code>:
     * <pre>
     * public void setUI(SliderUI newUI) {
     *     super.setUI(newUI);
     * }
     *  </pre>
     * <p>
     * Additionally <code>Component</code> subclasses must provide a
     * <code>getUI</code> method that returns the correct type.  For example:
     * <pre>
     * public SliderUI getUI() {
     *     return (SliderUI)ui;
     * }
     * </pre>
     *
     * @param newUI the new UI delegate
     * @see #updateUI()
     * @see UIManager#getLookAndFeel()
     * @see UIManager#getUI()
     */
    public function setUI(newUI:ComponentUI):void{
        /* We do not check that the UI instance is different
         * before allowing the switch in order to enable the
         * same UI instance *with different default settings*
         * to be installed.
         */
        if (ui != null) {
            ui.uninstallUI(this);
        }
        ui = newUI;
        if (ui != null) {
            ui.installUI(this);
        }
        revalidate();
        repaint();
    }
    
    public function getUI():ComponentUI{
    	return ui;
    }
	
	/**
	 * Sets the border for the component, null to remove border.
	 * @param border the new border to set, or null.
	 */
	public function setBorder(b:Border):void{
		if(b != border){
			removeChild(border.getDisplay());
			border = b;
			addChild(border.getDisplay());
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns the border.
	 * @return the border.
	 */
	public function getBorder():Border{
		return border;
	}
	
	/**
	 * If a border has been set on this component, returns the border's insets; 
	 * otherwise returns an empty insets.
	 */
	public function getInsets():Insets{
		if(border == null){
			return new Insets();
		}else{
			return border.getBorderInsets(this, getSize().getBounds());
		}
	}	
	
	/**
	 * Sets a decorator to be the component background, it will represent the component background 
	 * with a <code>DisplayObject</code>. null to remove the decorator set before.
	 * 
	 * @param bg the background decorator.
	 */
	public function setBackgroundDecorator(bg:GroundDecorator):void{
		if(bg != backgroundDecorator){
			backgroundDecorator = bg;
			if(bg != null){
				setBackgroundChild(bg.getDisplay());
			}else{
				setBackgroundChild(null);
			}
		}
	}
	
	/**
	 * Returns the background decorator of this component.
	 * @return the background decorator of this component.
	 */
	public function getBackgroundDecorator():GroundDecorator{
		return backgroundDecorator;
	}
	
	/**
	 * Sets a decorator to be the component foreground, it will represent the component foreground 
	 * with a <code>DisplayObject</code> on top of other children of this component. 
	 * null to remove the decorator set before.
	 * 
	 * @param fg the foreground decorator.
	 */
	public function setForegroundDecorator(fg:GroundDecorator):void{
		if(fg != foregroundDecorator){
			foregroundDecorator = fg;
			if(fg != null){
				setForegroundChild(fg.getDisplay());
			}else{
				setForegroundChild(null);
			}
		}
	}
	
	/**
	 * Returns the foreground decorator of this component.
	 * @return the foreground decorator of this component.
	 */
	public function getForegroundDecorator():GroundDecorator{
		return foregroundDecorator;
	}
	
	/**
	 * Sets the <code>DisplayObject.visible</code> directly.
	 * @param value the visible
	 */	
	protected function set d_visible(value:Boolean):void{
		super.visible = value;
	}
	
	/**
	 * Returns the <code>DisplayObject.visible</code> directly.
	 * @return the <code>DisplayObject.visible</code>
	 */
	protected function get d_visible():Boolean{
		return super.visible;
	}	
	
	override public function set visible(value:Boolean):void{
		setVisible(value);
	}
		
	/**
	 * Set a component to be hide or shown.
	 * If a component was hide, some laterly operation may not be done,
	 * they will be done when next shown, ex: repaint, doLayout ....
	 * So suggest you dont changed a component's visible frequently.
	 */
	public function setVisible(v:Boolean):void{
		if(v != d_visible){
			d_visible = v;
			if(v){
				dispatchEvent(new AWEvent(AWEvent.SHOWN, false, false));
			}else{
				dispatchEvent(new AWEvent(AWEvent.HIDDEN, false, false));
			}
			//because the repaint and some other operating only do when visible
			//so when change to visible, must call repaint to do the operatings they had not done when invisible
			if(d_visible){
				repaint();
			}
			revalidate();
		}
	}
	
	public function isVisible():Boolean{
		return visible;
	}
		
	/**
	 * Determines whether or not this component is on stage(on the display list).
	 * @return turn of this component is on display list, false not.
	 */
	public function isOnStage():Boolean{
		return stage != null;
	}
	
    /**
     * Determines whether this component is showing on screen. This means
     * that the component must be visible, and it must be in a container
     * that is visible and showing.
     * @return <code>true</code> if the component is showing,
     *          <code>false</code> otherwise
     * @see #setVisible()
     */    
    public function isShowing():Boolean{
    	if(isOnStage() && isVisible()){
    		//here, parent is stage means this is the top component(ex root)
    		if(parent == stage){
    			return true;
    		}else{
    			if(getParent() != null){
    				return getParent().isShowing();
    			}else{
    				return AsWingUtils.isDisplayObjectShowing(parent);
    			}
    		}
    	}
    	return false;
    }
    
	/**
	 * Sets the text font for this component.<br>
	 * this method will cause a repaint and revalidate method call.<br>
	 * @param newFont the font to set for this component.
	 */
	public function setFont(newFont:ASFont):void{
		if(font != newFont){
			font = newFont;
			setFontValidated(false);
			repaint();
			revalidate();
		}
	}
	
	/**
	 * Returns whether the new font are applied and taked effect.
	 * <p>
	 * Some UI can just apply font to text when this method returned false 
	 * to avoid wasteful time for font applying.
	 * @return true if currently font are applied to texts, otherwish false.
	 * @see #setFontValidated()
	 */
	public function isFontValidated():Boolean{
		return fontValidated;
	}
	
	/**
	 * Sets whether the new font are applied and taked effect.
	 * <p>
	 * Once the UI applied the font, it can call this method to set the value 
	 * to be true, to avoid next wasteful applying.
	 * @return true set font are applied, otherwish false.
	 * @see #isFontValidated()
	 */
	public function setFontValidated(b:Boolean):void{
		fontValidated = b;
	}
	
	/**
     * Gets the font of this component.
     * @return this component's font; if a font has not been set
     * for this component and it has parent, the font of its parent is returned
     * @see #setFont()
     */
	public function getFont():ASFont{
        if (font != null) {
            return font;
        }else if(parent is Component){
        	return getParent().getFont();
        }else{
        	return null;
        }
	}
	
	/**
     * Sets the background color of this component.
     * <p>
     * The background color affects each component differently.
     *
     * @param c the color to become this component's color;
     *          if this parameter is <code>null/undefined</code> and it has parent, then this
     *          component will inherit the background color of its parent
     * @see #getBackground()
	 */
	public function setBackground(c:ASColor):void{
		if(background != c){
			background = c;
			repaint();
		}
	}
	
	/**
     * Gets the background color of this component.
     * @return this component's background color; if this component does
     *          not have a background color and it has parent,
     *          the background color of its parent is returned
     * @see #setBackground()
	 */
	public function getBackground():ASColor{
		if(background != null){
			return background;
		}else if(parent is Component){
        	return getParent().getBackground();
        }else{
        	return null;
        }
	}
	
	/**
     * Sets the foreground color of this component.
     * <p>
     * The foreground color affects each component differently.
     *
     * @param c the color to become this component's color;
     *          if this parameter is <code>null/undefined</code> and it has parent, then this
     *          component will inherit the foreground color of its parent
     * @see #getForeground()
	 */
	public function setForeground(c:ASColor):void{
		if(foreground != c){
			foreground = c;
			repaint();
		}
	}
	
	/**
     * Gets the foreground color of this component.
     * @return this component's foreground color; if this component does
     *          not have a foreground color and it has parent,
     *          the foreground color of its parent is returned
     * @see #setForeground()
	 */
	public function getForeground():ASColor{
		if(foreground != null){
			return foreground;
		}else if(parent is Component){
        	return getParent().getForeground();
        }else{
        	return null;
        }
	}
		
    /**
     * If true the component paints every pixel within its bounds. 
     * Otherwise, the component may not paint some or all of its
     * pixels, allowing the underlying pixels to show through.
     * <p>
     * The default value of this property is false for <code>JComponent</code>.
     * However, the default value for this property on most standard
     * <code>Component</code> subclasses (such as <code>JButton</code> and
     * <code>JTree</code>) is look-and-feel dependent.
     *
     * @param b  true if this component should be opaque
     * @see #isOpaque()
     */
    public function setOpaque(b:Boolean):void {
    	setOpaqueSet(true);
    	if(opaque != b){
    		opaque = b;
    		repaint();
    	}
    }
    
    /**
     * Returns true if this component is completely opaque.
     * <p>
     * An opaque component paints every pixel within its
     * rectangular bounds. A non-opaque component paints only a subset of
     * its pixels or none at all, allowing the pixels underneath it to
     * "show through".  Therefore, a component that does not fully paint
     * its pixels provides a degree of transparency.
     * </p>
     * <p>
     * The value is from LAF defaults if you have not set it.
     * </p>
     * <p>
     * Subclasses that guarantee to always completely paint their contents
     * should override this method and return true.
     * <p>
     * @return true if this component is completely opaque
     * @see #setOpaque()
     * @see #isOpaqueSet()
     */
    public function isOpaque():Boolean{
    	return opaque;
    }
    
    /**
     * Returns whether or not the opaque property is set by user. 
     * If it is not set, <code>opaque</code> will can be replaced with the value defined 
     * in LAF defaults when install a UI.
     */
    public function isOpaqueSet():Boolean{
    	return opaqueSet;
    }
    
    /**
     * This method will be called to set true when you set the opaque by <code>setOpaque()</code>.
     * You can also call this method to make the opaque property returned by the set or LAF defaults.
     * @see #isOpaqueSet()
     * @see #isOpaque()
     */
    public function setOpaqueSet(b:Boolean):void{
    	opaqueSet = b;
    }
    
    /**
     * Indicates the alpha transparency value of the component. 
     * Valid values are 0 (fully transparent) to 1 (fully opaque).
     * @param alpha the alpha for this component, between 0 and 1. default is 1.
     */
    public function setAlpha(alpha:Number):void{
    	this.alpha = alpha;
    }
    
    /**
     * Returns the alpha of this component.
     * @return the alpha of this component. default is 1.
     */
    public function getAlpha():Number{
    	return alpha;
    }
    
    /**
     * Returns the coordinate of the mouse position, in pixels, in the component scope.
     * @return the coordinate of the mouse position.
     */
    public function getMousePosition():IntPoint{
    	return new IntPoint(mouseX, mouseY);
    }
		
	/**
	 * Returns the bounds that component should paint in.
	 * <p>
	 * This is same to some paint method param b:Rectangle.
	 * So if you want to paint outside those method, you can get the 
	 * rectangle from here.
	 * 
	 * If this component has a little maximum size, and then current 
	 * size is larger, the bounds return from this method will be related 
	 * to <code>getAlignmentX<code>, <code>getAlignmentY<code> and <code>getMaximumSize<code>.
	 * @return return the rectangle that component should paint in.
	 * @see #getAlignmentX()
	 * @see #getAlignmentY()
	 * @see #getMaximumSize()
	 */
	public function getPaintBounds():IntRectangle{
		return getInsets().getInsideBounds(getPaintBoundsInRoot());
	}		
		
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 * @param b the location and size bounds
	 */
	public function setComBounds(b:IntRectangle):void{
		setLocationXY(b.x, b.y);
		setSizeWH(b.width, b.height);
	}
	
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 */	
	public function setComBoundsXYWH(x:int, y:int, w:int, h:int):void{
		setLocationXY(x, y);
		setSizeWH(w, h);
	}
	
	/**
	 * Same to DisplayObject.getBounds(), 
	 * just add a explaination here that if you want to get the component bounds, 
	 * see {@link #getComBounds()} method.
	 * @see #getComBounds()
	 * @see #setComBounds()
	 */
	override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle{
		return super.getBounds(targetCoordinateSpace);
	}
	
	/**
	 * <p>Stores the bounds value of this component into "return value" rv and returns rv. 
	 * If rv is null or undefined a new IntRectangle object is allocated. 
	 * 
	 * @param rv the return value, modified to the component's bounds.
	 * 
	 * @see #setSize()
	 * @see #setLocation()
	 */
	public function getComBounds(rv:IntRectangle=null):IntRectangle{
		if(rv != null){
			rv.setRect(bounds);
			return rv;
		}else{
			return new IntRectangle(bounds.x, bounds.y, bounds.width, bounds.height);
		}
	}
	
	/**
	 * Set the component's location, if it is diffs from old location, invalidate it to wait validate.
	 * The top-left corner of the new location is specified by the x and y parameters 
	 * in the coordinate space of this component's parent.
	 */
	public function setLocation(newPos:IntPoint):void{
		var oldPos:IntPoint = bounds.getLocation();
		if(!newPos.equals(oldPos)){
			bounds.setLocation(newPos);
			locate();
			dispatchEvent(new MovedEvent(oldPos, newPos));
		}
	}
	
	/**
	 * @see #setLocation()
	 */
	public function setLocationXY(x:int, y:int):void{
		setLocation(new IntPoint(x, y));
	}
	
	/**
	 * Stores the location value of this component into "return value" rv and returns rv. 
	 * If p is null or undefined a new Point object is allocated. 
	 * @param rv the return value, modified to the component's location.
	 */
	public function getLocation(rv:IntPoint=null):IntPoint{
		if(rv != null){
			rv.setLocationXY(bounds.x, bounds.y);
			return rv;
		}else{
			return new IntPoint(bounds.x, bounds.y);
		}
	}
	
	/**
	 * This method will call setComBounds()
	 * @see #setComBounds()
	 */
	public function setBounds(b:IntRectangle):void{
		setComBounds(b);
	}
		
	/**
	 * Set the component's size, the width and height all will be setted to not less than zero, 
	 * then set the size.
	 * You can set a Component's size max than its maximumSize, but when it was drawed,
 	 * it will not max than its maximumSize.Just as its maximumSize and posited itself
 	 * in that size dimension you just setted. The position is relative to <code>getAlignmentX</code> 
	 * @see #getAlignmentX()
	 * @see #getAlignmentY()
	 * @see #getMinimumSize()
	 * @see #countMaximumSize()
	 * @see #getPreferredSize()
	 */
	public function setSize(newSize:IntDimension):void{
		newSize.width = Math.max(0, newSize.width);
		newSize.height = Math.max(0, newSize.height);
		var oldSize:IntDimension = new IntDimension(bounds.width, bounds.height);
		if(!newSize.equals(oldSize)){
			bounds.setSize(newSize);
			size();
			dispatchEvent(new ResizedEvent(oldSize, newSize));
		}
	}
	/**
	 * @see #setSize()
	 */
	public function setSizeWH(w:int, h:int):void{
		setSize(new IntDimension(w, h));
	}
	
	/**
	 * Stores the size value of this component into "return value" rv and returns rv. 
	 * If rv is null or undefined a new IntDimension object is allocated. 
	 * @param rv the return value, modified to the component's size.
	 */	
	public function getSize(rv:IntDimension=null):IntDimension{
		if(rv != null){
			rv.setSizeWH(bounds.width, bounds.height);
			return rv;
		}else{
			return new IntDimension(bounds.width, bounds.height);
		}
	}
	
	/**
	 * Causes this component to be sized to fit the preferred size.
	 */
	public function pack():void{
		setSize(getPreferredSize());
	}	
	
	/**
	 * Sets the component's width.
	 * @param width the width of component to set
	 * @see  #setSize()
	 */
	public function setWidth(width:int):void{
		setSizeWH(width, getHeight());
	}
	/**
	 * Sets the component's height.
	 * @param height the height of component to set
	 * @see  #setSize()
	 */	
	public function setHeight(height:Number):void{
		setSizeWH(getWidth(), height);
	}
	/**
	 * Returns the current width of this component
	 * @return the width of the component
	 */
	public function getWidth():int{
		return bounds.width;
	}
	/**
	 * Returns the current height of this component
	 * @return the height of the component
	 */	
	public function getHeight():int{
		return bounds.height;
	}
	/**
	 * Sets the x coordinate of the components.
	 * @return the x coordinate
	 * @see #setLocation()
	 */
	public function setX(x:int):void{
		setLocationXY(x, getY());
	}
	/**
	 * Sets the y coordinate of the components.
	 * @return the y coordinate
	 * @see #setLocation()
	 */
	public function setY(y:int):void{
		setLocationXY(getX(), y);
	}
	/**
	 * Returns the current x coordinate of the components.
	 * @return the current x coordinate of the components
	 * @see #getLocation()
	 */
	public function getX():int{
		return bounds.x;
	}
	/**
	 * Returns the current y coordinate of the components.
	 * @return the current y coordinate of the components
	 * @see #getLocation()
	 */
	public function getY():int{
		return bounds.y;
	}
	
	/**
	 * Enable or disable the component.
	 * <p>
	 * If a component is disabled, it will not fire mouse events. 
	 * And some component will has different interface when enabled or disabled.
	 * @param b true to enable the component, false to disable it.
	 */
	public function setEnabled(b:Boolean):void{
		if(enabled != b){
			enabled = b;
			mouseEnabled = b;
			repaint();
		}
	}
	
	/**
	 * Returns whether the component is enabled.
	 * @see #setEnabled()
	 */
	public function isEnabled():Boolean{
		return enabled;
	}
	
    /**
     * Returns whether this Component can be focused.
     *
     * @return <code>true</code> if this Component is focusable;
     *         <code>false</code> otherwise.
     * @see #setFocusable()
     */	
	public function isFocusable():Boolean{
		return focusable;
	}
	
    /**
     * Sets the focusable state of this Component to the specified value. This
     * value overrides the Component's default focusability.
     *
     * @param focusable indicates whether this Component is focusable
     * @see #isFocusable()
     */	
	public function setFocusable(b:Boolean):void{
		focusable = b;
		getInternalFocusObject().tabEnabled = b;
		setFocusableSet(true);
	}
	
    /**
     * Returns whether or not the opaque property is set by user. 
     * If it is not set, <code>focusable</code> will can be replaced with the value defined 
     * in LAF defaults when install a UI.
     */	
	public function isFocusableSet():Boolean{
		return focusableSet;
	}
	
	/**
	 * Indicate that the <code>focusable</code> property is set by user or not.
	 * @param b whether set or not
	 * @see #isFocusableSet()
	 */
	public function setFocusableSet(b:Boolean):void{
		focusableSet = b;
	}
	
	/**
	 * Locate the component to the current location.
	 */
	protected function locate():void{
		var _x:Number = getX();
		var _y:Number = getY();
		if(scrollRect != null){
			_x += scrollRect.x;
			_y += scrollRect.y;
		}
		d_x = _x;
		d_y = _y;
	}
	
	/**
	 * Sets <code>DisplayObject.x</code> directly.
	 * @param value the x coordinats
	 */
	protected function set d_x(value:Number):void{
		super.x = value;
	}
	
	/**
	 * Sets <code>DisplayObject.y</code> directly.
	 * @param value the y coordinats
	 */	
	protected function set d_y(value:Number):void{
		super.y = value;
	}
	
	/**
	 * Returns <code>DisplayObject.x</code> directly.
	 * @return the x coordinats
	 */
	protected function get d_x():Number{
		return super.x;
	}
	
	/**
	 * Returns <code>DisplayObject.y</code> directly.
	 * @return the y coordinats
	 */	
	protected function get d_y():Number{
		return super.y;
	}	
	
	/**
	 * @see #setX()
	 */
	override public function set x(value:Number):void{
		setX(value);
	}
	
	/**
	 * @see #getX()
	 */
	override public function get x():Number{
		return getX();
	}
	
	/**
	 * @see setWidth()
	 */
	override public function set width(value:Number):void{
		setWidth(value);
	}
	
	/**
	 * @see getWidth()
	 */
	override public function get width():Number{
		return getWidth();
	}
	
	/**
	 * @see setHeight()
	 */	
	override public function set height(value:Number):void{
		setHeight(value);
	}
	
	/**
	 * @see getHeight()
	 */	
	override public function get height():Number{
		return getHeight();
	}
	
	/**
	 * @param ax
	 * @see #getAlignmentX()
	 */
    public function setAlignmentX(ax:Number):void{
    	if(alignmentX != ax){
    		alignmentX = ax;
    		repaint();
    	}
    }
    
    /**
	 * @param ay
	 * @see #getAlignmentY()
     */
    public function setAlignmentY(ay:Number):void{
    	if(alignmentY != ay){
    		alignmentY = ay;
    		repaint();
    	}
    }		
	
	/**
	 * Returns the alignment along the x axis. 
	 * This specifies how the component would like to be aligned relative 
	 * to its size when its size is maxer than its maximumSize. 
	 * The value should be a number between 0 and 1 where 0 
	 * represents alignment start from left, 1 is aligned the furthest 
	 * away from the left, 0.5 is centered, etc. 
	 * @return the alignment along the x axis, 0 by default
	 */
    public function getAlignmentX():Number{
    	return alignmentX;
    }

	/**
	 * Returns the alignment along the y axis. 
	 * This specifies how the component would like to be aligned relative 
	 * to its size when its size is maxer than its maximumSize. 
	 * The value should be a number between 0 and 1 where 0 
	 * represents alignment start from top, 1 is aligned the furthest 
	 * away from the top, 0.5 is centered, etc. 
	 * @return the alignment along the y axis, 0 by default
	 */
    public function getAlignmentY():Number{
    	return alignmentY;
    }
    
    /**
     * Returns the value of the property with the specified key. 
     * Only properties added with putClientProperty will return a non-null value.
     * @param key the being queried
     * @return the value of this property or null
     * @see #putClientProperty()
     */
    public function getClientProperty(key:*):*{
    	return clientProperty.get(key);
    }
    
    /**
     * Adds an arbitrary key/value "client property" to this component.
     * <p>
     * The <code>get/putClientProperty</code> methods provide access to 
     * a small per-instance hashtable. Callers can use get/putClientProperty
     * to annotate components that were created by another module.
     * For example, a
     * layout manager might store per child constraints this way. For example:
     * <pre>
     * componentA.putClientProperty("to the left of", componentB);
     * </pre>
     * @param key the new client property key
     * @param value the new client property value
     * @see #getClientProperty()
     */    
    public function putClientProperty(key:*, value:*):void{
    	//Lazy initialization
    	if(clientProperty == null){
    		clientProperty = new HashMap();
    	}
    	clientProperty.put(key, value);
    }
	
	/**
	 * get the minimumSize from ui, if ui is null then Returns getInsets().roundsSize(new IntDimension(0, 0)).
	 */
	protected function countMinimumSize():IntDimension{		
		if(ui != null){
			return ui.getMinimumSize(this);
		}else{
			return getInsets().getOutsideSize(new IntDimension(0, 0));
		}
	}
	
	/**
	 * get the maximumSize from ui, if ui is null then return a big dimension;
	 * @see IntDimension#createBigDimension()
	 */
	protected function countMaximumSize():IntDimension{		
		if(ui != null){
			return ui.getMaximumSize(this);
		}else{
			return IntDimension.createBigDimension();
		}
	}
	
	/**
	 * get the preferredSize from ui, if ui is null then just return the current size
	 */
	protected function countPreferredSize():IntDimension{
		if(ui != null){
			return ui.getPreferredSize(this);
		}else{
			return getSize();
		}
	}
	
	/**
	 * Sets whether or not turn on the preferred size, minimum size and 
	 * max size cache. By default, this is true(means turned on).
	 * <p>
	 * If this is turned on, the size count will be very fast as most time. 
	 * So suggest you that do not turn off it unless you have your personal reason.
	 * </p>
	 * @param b true to turn on it, false trun off it.
	 */
	public function setCachePreferSizes(b:Boolean):void{
		cachePreferSizes = b;
		if(!b){
	    	cachedMaximumSize = null;
	    	cachedMinimumSize = null;
	    	cachedPreferredSize = null;			
		}
	}
	
	/**
	 * Returns whether or not the preferred size, minimum size and 
	 * max size cache is turned on.
	 * @return whether or not the preferred size, minimum size and 
	 * max size cache is turned on.
	 */
	public function isCachePreferSizes():Boolean{
		return cachePreferSizes;
	}
	
	/**
	 * @see #setMinimumSize()
	 */
	public function getMinimumSize():IntDimension{
		if(minimumSize != null){
			return minimumSize.clone();
		}else if(isCachePreferSizes() && cachedMinimumSize != null){
			return cachedMinimumSize.clone();
		}else{
			if(isCachePreferSizes()){
				cachedMinimumSize = countMinimumSize();
				return cachedMinimumSize.clone();
			}else{
				return countMinimumSize();
			}
		}
	}
	
	/**
	 * @see #setMaximumSize()
	 */	
	public function getMaximumSize():IntDimension{
		if(maximumSize != null){
			return maximumSize.clone();
		}else if(isCachePreferSizes() && cachedMaximumSize != null){
			return cachedMaximumSize.clone();
		}else{
			if(isCachePreferSizes()){
				cachedMaximumSize = countMaximumSize();
				return cachedMaximumSize.clone();
			}else{
				return countMaximumSize();
			}
		}
	}
	
	/**
	 * @see #setPreferredSize()
	 */	
	public function getPreferredSize():IntDimension{
		if(preferredSize != null){
			return preferredSize.clone();
		}else if(isCachePreferSizes() && cachedPreferredSize != null){
			return cachedPreferredSize.clone();
		}else{
			if(isCachePreferSizes()){
				cachedPreferredSize = countPreferredSize();
				return cachedPreferredSize.clone();
			}else{
				return countPreferredSize();
			}
		}
	}
	
	/**
	 * setMinimumSize(d:IntDimension)<br>
	 * setMinimumSize(width:Number, height:Number)
	 * <p>
	 * Set the minimumSize, then the component's minimumSize is
	 * specified. otherwish getMinimumSize will can the count method.
	 * @param arguments null to set minimumSize null then getMinimumSize will can the layout.
	 * others set the minimumSize to be a specified size.
	 * @see #getMinimumSize()
	 */
	public function setMinimumSize(minimumSize:IntDimension):void{
		if(minimumSize == null){
			this.minimumSize = null;
		}else{
			this.minimumSize = minimumSize.clone();
		}
	}
	
	/**
	 * setMaximumSize(d:IntDimension)<br>
	 * setMaximumSize(width:Number, height:Number)<br>
	 * <p>
	 * Set the maximumSize, then the component's maximumSize is
	 * specified. otherwish getMaximumSize will can count method.
	 * 
	 * @param arguments null to set maximumSize null to make getMaximumSize will can the layout.
	 * others set the maximumSize to be a specified size.
	 * @see #getMaximumSize()
	 * @see #MaximumSize()
	 */	
	public function setMaximumSize(maximumSize:IntDimension):void{
		if(maximumSize == null){
			this.maximumSize = null;
		}else{
			this.maximumSize = maximumSize.clone();
		}
	}
	
	/**
	 * setPreferredSize(d:IntDimension)<br>
	 * setPreferredSize(width:Number, height:Number)<br>
	 * <p>
	 * Set the preferredSize, then the component's preferredSize is
	 * specified. otherwish getPreferredSize will count method.
	 * 
	 * @param arguments null to set preferredSize null to make getPreferredSize will call the layout,
	 * others set the preferredSize to be a specified size.
	 * @see #getPreferredSize()
	 */	
	public function setPreferredSize(preferredSize:IntDimension):void{
		if(preferredSize == null){
			this.preferredSize = null;
		}else{
			this.preferredSize = preferredSize.clone();
		}
	}	
	
	/**
	 * Returns <code>getPreferredSize().width</code>
	 * @see #getPreferredSize()
	 */
	public function getPreferredWidth():int {
		return getPreferredSize().width;
	}
	/**
	 * Calls <code>setPreferredSize(preferredWidth, getPreferredHeight())</code>
	 * @see #setPreferredSize()
	 */
	public function setPreferredWidth(preferredWidth:int):void {
		setPreferredSize(new IntDimension(preferredWidth, getPreferredHeight()));
	}
	/**
	 * Returns <code>getPreferredSize().height</code>
	 * @see #getPreferredSize()
	 */
	public function getPreferredHeight():int {
		return getPreferredSize().height;
	}
	/**
	 * Calls <code>setPreferredSize(getPreferredWidth(), preferredHeight)</code>
	 * @see #setPreferredSize()
	 */
	public function setPreferredHeight(preferredHeight:int):void {
		setPreferredSize(new IntDimension(getPreferredWidth(), preferredHeight));
	}
	/**
	 * Returns <code>getMaximumSize().width</code>
	 * @see #getMaximumSize()
	 */
	public function getMaximumWidth():int {
		return getMaximumSize().width;
	}
	/**
	 * Calls <code>setMaximumSize(maximumWidth, getMaximumHeight())</code>
	 * @see #setMaximumSize()
	 */
	public function setMaximumWidth(maximumWidth:int):void {
		setMaximumSize(new IntDimension(maximumWidth, getMaximumHeight()));
	}
	/**
	 * Returns <code>getMaximumSize().height</code>
	 * @see #getMaximumSize()
	 */
	public function getMaximumHeight():int {
		return getMaximumSize().height;
	}
	/**
	 * Calls <code>setMaximumSize(getMaximumWidth(), maximumHeight)</code>
	 * @see #setMaximumSize()
	 */
	public function setMaximumHeight(maximumHeight:int):void {
		setMaximumSize(new IntDimension(getMaximumWidth(), maximumHeight));
	}
	/**
	 * Returns <code>getMinimumSize().width</code>
	 * @see #getMinimumSize()
	 */
	public function getMinimumWidth():int {
		return getMinimumSize().width;
	}
	/**
	 * Calls <code>setMinimumSize(minimumWidth, getMinimumHeight())</code>
	 * @see #setMinimumSize()
	 */
	public function setMinimumWidth(minimumWidth:int):void {
		setMinimumSize(new IntDimension(minimumWidth, getMinimumHeight()));
	}	
	/**
	 * Returns <code>getMinimumSize().height</code>
	 * @see #getMinimumSize()
	 */
	public function getMinimumHeight():int {
		return getMinimumSize().height;
	}
	/**
	 * Calls <code>setMinimumSize(getMinimumWidth(), minimumHeight)</code>
	 * @see #setMinimumSize()
	 */
	public function setMinimumHeight(minimumHeight:int):void {
		setMinimumSize(new IntDimension(getMinimumWidth(), minimumHeight));
	}
	
	
	/**
	 * Sets whether the component clip should be masked by its bounds. By default it is true.
	 * <p>
	 * AsWing A3 use <code>scrollRect</code> property to do the clip mask.
	 * </p>
	 * @param m whether the component clip should be masked.
	 * @see #isClipMasked()
	 */
	public function setClipMasked(m:Boolean):void{
		if(m != clipMasked){
			clipMasked = m;
			layoutClipAndTrigger(null);
		}
	}
	
	/**
	 * Returns whether the component clip should be masked by its bounds. By default it is true.
	 * <p>
	 * AsWing A3 use <code>scrollRect</code> property to do the clip mask.
	 * </p>
	 * @return whether the component clip should be masked.
	 * @see #setClipMasked()
	 */
	public function isClipMasked():Boolean{
		return clipMasked;
	}	
	
	/**
	 * Sets the clip bounds, a rectangle mask to make specified bounds visible.
	 * Null to make the componet mask whole rectangle(show all).
	 */
	public function setClipBounds(b:IntRectangle):void{
		var changed:Boolean = false;
		if(b == null && clipBounds != null){
			clipBounds = null;
			changed = true;
		}else{
			if(!b.equals(clipBounds)){
				clipBounds = b.clone();
				changed = true;
			}
		}
		if(changed){
			layoutClipAndTrigger(null);
		}
	}
	
	/**
	 * Returns the clip bounds.
	 * @see #setClipBounds()
	 */
	public function getClipBounds():IntRectangle{
		if(clipBounds == null){
			return null;
		}
		return clipBounds.clone();
	}
	
	/**
	 * Sets the clip size, a rectangle mask to make specified bounds visible.
	 * This will be only in effect after component created and before next layout time.
	 * @see #setClipBounds()
	 */	
	public function setClipSize(size:IntDimension):void{
		if(clipBounds == null){
			clipBounds = new IntRectangle();
		}
		clipBounds.setSize(size);
		setClipBounds(clipBounds);
	}
	
    /**
     * Supports deferred automatic layout.  
     * <p> 
     * Calls <code>invalidateLayout</code> and then adds this component's
     * <code>validateRoot</code> to a list of components that need to be
     * validated.  Validation will occur after all currently pending
     * events have been dispatched.  In other words after this method
     * is called,  the first validateRoot (if any) found when walking
     * up the containment hierarchy of this component will be validated.
     * By default, <code>JPopup</code>, <code>JScrollPane</code>,
     * and <code>JTextField</code> return true 
     * from <code>isValidateRoot</code>.
     * <p>
     * This method will or will not automatically be called on this component 
     * when a property value changes such that size, location, or 
     * internal layout of this component has been affected.But invalidate
     * will do called after thats method, so you want to get the contents of 
     * the GUI to update you should call this method.
     * <p>
     *
     * @see #invalidate()
     * @see #validate()
     * @see #isValidateRoot()
     * @see RepaintManager#addInvalidComponent()
     */
	public function revalidate():void{
    	invalidate();
    	RepaintManager.getInstance().addInvalidComponent(this);
    }
        
    public function revalidateIfNecessary():void{
    	RepaintManager.getInstance().addInvalidComponent(this);
    }
	
	/**
	 * Redraws the component face next RENDER event.This method can
     * be called often, so it needs to execute quickly.
	 * @see org.aswing.RepaintManager
	 */
	public function repaint():void{
		if(isVisible()){
			RepaintManager.getInstance().addRepaintComponent(this);
		}
	}
		
	/**
	 * Do the process when size changed.
	 */
	protected function size():void{
		readyToPaint = true;
		repaint();
		invalidate();
	}
	
    /**
     * Invalidates this component.  This component and all parents
     * above it are marked as needing to be laid out.  This method can
     * be called often, so it needs to execute quickly.
     * @see       #validate()
     * @see       #doLayout()
     * @see       org.aswing.LayoutManager
     */	
	public function invalidate():void{
    	valid = false;
    	cachedMaximumSize = null;
    	cachedMinimumSize = null;
    	cachedPreferredSize = null;
    	var par:Container = getParent();
    	if(par != null && par.isValid()){
    		par.invalidate();
    	}
	}
	
    /**
     * Ensures that this component has a valid layout.  This method is
     * primarily intended to operate on instances of <code>Container</code>.
     * @see       #invalidate()
     * @see       #doLayout()
     * @see       org.aswing.LayoutManager
     * @see       org.aswing.Container#validate()
     */	
	public function validate():void{
    	if(!valid){
    		valid = true;
    	}
	}
	
	/**
	 * Redraw the component UI face immediately if it is visible and ready to paint.
	 * @see #repaint()
	 * @see #isVisible()
	 * @see #isReadyToPaint()
	 */	
	public function paintImmediately():void{
		if(isVisible() && isReadyToPaint()){
			var paintBounds:IntRectangle = getPaintBoundsInRoot();
			layoutClipAndTrigger(paintBounds);
			paint(getInsets().getInsideBounds(paintBounds));
		}
	}	
	/////////
	
	/**
	 * Returns if this component is ready to do paint.
	 * By default, if a component is resized once, then it is ready.
	 * @return if this component is ready to do paint.
	 * @see #setSize()
	 * @see #size()
	 */
	protected function isReadyToPaint():Boolean{
		return readyToPaint;
	}
	
	/**
	 * draw the component interface in specified bounds.
	 * Sub class should override this method if you want to draw your component's face.
	 * @param b this paiting bounds, it is opposite on the component corrdinarry.
	 */
	protected function paint(b:IntRectangle):void{
		graphics.clear();
		var g:Graphics2D = new Graphics2D(graphics);
		
		if(backgroundDecorator != null){
			backgroundDecorator.updateDecorator(this, g, b.clone());
		}
		if(ui != null){
			ui.paint(this, g, b.clone());
		}
		paintFocusRect();
		//paint border at last to make it at the top depth
		if(border != null){
			// not that border is not painted in b, is painted in component's full size bounds
			// because border are the rounds, others will painted in the border's bounds.
			border.updateBorder(this, g, getInsets().getOutsideBounds(b.clone()));
		}
		if(foregroundDecorator != null){
			foregroundDecorator.updateDecorator(this, g, b);
		}
				
		dispatchEvent(new AWEvent(AWEvent.PAINT, false, false));
	}
	
	/**
	 * Paints the focus rect if need.
	 * The focus will be paint by the component ui if this component is focusOwner and 
	 * <code>FocusManager.getCurrentManager().isTraversing()</code>.
	 */
	public function paintFocusRect():void{
		if(ui != null){
			if(FocusManager.getCurrentManager().isTraversing() && isFocusOwner()){
				var fr:Sprite = FocusManager.getCurrentManager().moveFocusRectUpperTo(this);
				fr.graphics.clear();
				ui.paintFocus(this, new Graphics2D(fr.graphics), new IntRectangle(0, 0, width, height));
			}
		}
	}
	
	private var lastScrollRect:IntRectangle;
	private function layoutClipAndTrigger(paintBounds:IntRectangle):void{
		if(paintBounds == null){
			paintBounds = getPaintBoundsInRoot();
		}else{
			paintBounds = paintBounds.clone();
		}
		if(clipBounds != null){
			paintBounds.x = Math.max(paintBounds.x, clipBounds.x);
			paintBounds.y = Math.max(paintBounds.y, clipBounds.y);
			paintBounds.width = Math.min(paintBounds.width, clipBounds.width);
			paintBounds.height = Math.min(paintBounds.height, clipBounds.height);
		}
		//this means the trigger and mask??
		//TODO check this
		if(clipMasked){
			if(!paintBounds.equals(lastScrollRect)){
				scrollRect = paintBounds.toRectangle();
				lastScrollRect = paintBounds;
				locate();
			}
		}else{
			if(lastScrollRect != null){
				scrollRect = null;
				lastScrollRect = null;
				locate();
			}
		}
	}

	/**
	 * get the simon-pure component paint bounds.
	 * This is include insets range.
	 * @see #getPaintBounds()
	 */
	private function getPaintBoundsInRoot():IntRectangle{
		var minSize:IntDimension = getMinimumSize();
		var maxSize:IntDimension = getMaximumSize();
		var size:IntDimension = getSize();
		var paintBounds:IntRectangle = new IntRectangle(0, 0, size.width, size.height);
		//if it size max than maxsize, draw it as maxsize and then locate it in it size(the size max than maxsize)
		if(size.width > maxSize.width){
			paintBounds.width = maxSize.width;
			paintBounds.x = (size.width-paintBounds.width)*getAlignmentX();
		}
		if(size.height > maxSize.height){
			paintBounds.height = maxSize.height;
			paintBounds.y = (size.height-paintBounds.height)*getAlignmentY();
		}
		//cannot paint its min than minsize
		if(paintBounds.width < minSize.width) paintBounds.width = minSize.width;
		if(paintBounds.height < minSize.height) paintBounds.height = minSize.height;
		
		return paintBounds;
	}	
		
    /**
     * Determines whether this component is valid. A component is valid
     * when it is correctly sized within its parent
     * container and all its children are also valid. components are invalidated
     * before they are first shown on the screen. By the time the parent container 
     * is fully realized, all its components will be valid.
     * @return <code>true</code> if the component is valid, <code>false</code>
     * otherwise
     * @see #validate()
     * @see #invalidate()
     */
    public function isValid():Boolean{
    	return valid;
    }
	
	/**
	 * If this method returns true, revalidate calls by descendants of this 
	 * component will cause the entire tree beginning with this root to be validated. 
	 * Returns false by default. 
	 * JScrollPane overrides this method and returns true. 
	 * @return always returns false
	 */
	public function isValidateRoot():Boolean{
		if(stage != null && getParent() == null){
			//TODO check this
			return true;
		}
		return false;
	}	
	
	/**
	 * Returns the parent component, if it parent is not a component, null will be returned
	 */
	public function getParent():Container{
		var pa:Container = parent as Container;
		return pa;
	}
	
	/**
	 * Returns the first <code>JRootPane</code> ancestor of this component.
	 * @return the <code>JRootPane</code> ancestor, or null if not found.
	 */
	public function getRootPaneAncestor():JRootPane{
		var pa:DisplayObject = parent;
		while(pa != null){
			if(pa is JRootPane){
				return pa as JRootPane;
			}
			pa = pa.parent;
		}
		return null;
	}
	
	/**
	 * Removes this component from its parent
	 */
	public function removeFromContainer():void{
		if(getParent() != null){
			getParent().remove(this);
		}
	}
	
	/**
	 * Sets component's constraints.
	 * @param constraints the constraints to set
	 */
	public function setConstraints(constraints:Object):void {
		this.constraints = constraints;	
	}
	
	/**
	 * Gets cpmponent's constraints.
	 * @return component's constraints
	 */
	public function getConstraints():Object {
		return constraints;
	}
	
    /**
     * Transfers the focus to the next component, as though this Component were
     * the focus owner.
     * 
     * @return true if transfered, false otherwise
     * @see       #requestFocus()
     */
    public function transferFocus():Boolean {
    	return transferFocusWithDirection(1);
    }
    
    /**
     * Transfers the focus to the previous component, as though this Component
     * were the focus owner.
     * 
     * @return true if transfered, false otherwise
     * @see       #requestFocus()
     */
    public function transferFocusBackward():Boolean{
    	return transferFocusWithDirection(-1);
    }
    
    /**
     * dir > 0 transferFocus, dir <= 0 transferFocusBackward
     */
    private function transferFocusWithDirection(dir:Number):Boolean{
        var pa:Container = getParent();
        if(pa == null){
        	pa = this as Container;
        }
        if(pa != null){
        	var nextFocus:Component = null;
        	if(dir > 0){
        		nextFocus = pa.getFocusTraversalPolicy().getComponentAfter(this);
        	}else{
        		nextFocus = pa.getFocusTraversalPolicy().getComponentBefore(this);
        	}
        	if(nextFocus != null){
        		return nextFocus.requestFocus();
        	}
        }
        return false;
    }
    
    /**
     * Returns <code>true</code> if this <code>Component</code> is the 
     *    focus owner.
     *
     * @return <code>true</code> if this <code>Component</code> is the 
     *     focus owner; <code>false</code> otherwise
     */
    public function isFocusOwner():Boolean {
        return (FocusManager.getCurrentManager().getFocusOwner() == this);
    }
    
    /**
     * Requests that this Component get the input focus, and that this
     * Component's top-level ancestor become the focused Window. This component
     * must be displayable, visible, and focusable for the request to be
     * granted. Every effort will be made to honor the request; however, in
     * some cases it may be impossible to do so. Developers must never assume
     * that this Component is the focus owner until this Component receives a
     * ON_FOCUS_GAINED event.
     *
     * @return true if the request is made successful, false if the request is denied.
     * @see #isFocusable()
     * @see #isDisplayable()
     * @see #ON_FOCUS_GAINED
     */
    public function requestFocus():Boolean {
    	//TODO imp check
    	if(isFocusable() && isEnabled() && isShowing()){
    		stage.focus = getInternalFocusObject();
    		return true;
    	}
        return false;
    }
    
    /**
     * Returns the object to receive the focus for this component. 
     * Default is just return the component, other component may return a 
     * child object, for example <code>JTextComponent<code> will return 
     * its <code>TextField</code> object.
     * @return the object to receive the focus.
     */
    public function getInternalFocusObject():InteractiveObject{
    	return this;
    }
    
    internal function fireFocusKeyDownEvent(e:KeyboardEvent):void{
    	dispatchEvent(new FocusKeyEvent(FocusKeyEvent.FOCUS_KEY_DOWN, e.charCode, 
    	e.keyCode, e.keyLocation, e.ctrlKey, e.altKey, e.shiftKey));
    }
    
    internal function fireFocusKeyUpEvent(e:KeyboardEvent):void{
    	dispatchEvent(new FocusKeyEvent(FocusKeyEvent.FOCUS_KEY_UP, e.charCode, 
    	e.keyCode, e.keyLocation, e.ctrlKey, e.altKey, e.shiftKey));
    }
	
	//----------------------------------------------------------------
	//               Event Handlers
	//----------------------------------------------------------------
	
	//retrive the focus when mouse down if not focused child or self
	//this will works because focusIn will be fired before mouseDown
	private function __mouseDown(e:MouseEvent):void{
		var focusOwner:Component = FocusManager.getCurrentManager().getFocusOwner();
		if(focusOwner == null || !(focusOwner == this || AsWingUtils.isAncestor(this, focusOwner))){
			requestFocus();
		}
	}
	
	private function __focusIn(e:FocusEvent):void{
		if(e.target == getInternalFocusObject() && isFocusable()){
			var focusOwner:Component = FocusManager.getCurrentManager().getFocusOwner();
			if(this != focusOwner){
	    		FocusManager.getCurrentManager().setFocusOwner(this);
	    		paintFocusRect();
	    		dispatchEvent(new AWEvent(AWEvent.FOCUS_GAINED));
   			}
		}
	}
	
	private function __focusOut(e:FocusEvent):void{
		if(e.relatedObject == null){
			return;
		}
		if(e.target == getInternalFocusObject() && isFocusable()){
			var focusOwner:Component = FocusManager.getCurrentManager().getFocusOwner();
			if(this == focusOwner){
	    		FocusManager.getCurrentManager().setFocusOwner(null);
	    		dispatchEvent(new AWEvent(AWEvent.FOCUS_LOST));
   			}
		}
	}
	
	override public function toString():String{
		return Reflection.getClassName(this) + "[asset:" + super.toString() + "]";
	}
}


}