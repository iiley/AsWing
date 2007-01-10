/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.ComponentUI;
import org.aswing.*;
	
public class Component extends AWSprite
{
	private var ui:ComponentUI;
	private var uiProperties:Object;
	
	private var awmlID:String;
	private var awmlIndex:Number;
	private var awmlNamespace:String;
	
	private var bounds:IntRectangle
	private var background:ASColor;
	private var foreground:ASColor;
	private var backgroundDecorator:GroundDecorator;
	private var foregroundDecorator:GroundDecorator;
	private var font:ASFont;
	private var fontValidated:Boolean;
	private var opaque:Boolean;
	private var border:Border;
	
	public function Component()
	{
		super();
		uiProperties = new Object();
		bounds = new IntRectangle();
		opaque = false;
		fontValidated = false;
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
     *      setUI((SliderUI)UIManager.getUI(this);
     *   }
     *  </pre>
     *
     * @see #setUI()
     * @see org.aswing.UIManager#getLookAndFeel()
     * @see org.aswing.UIManager#getUI()
     */
    public function updateUI():void{}


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
            //TODO check this
            //if(isDisplayable()){
            //	ui.create(this);
            //}
        }
        revalidate();
        repaint();
    }	
	
	/**
	 * Sets the UI delegated property value.<br>
	 * If the property value in component is undefined, then the delegated value 
	 * will be used.
	 * @param name the property name
	 * @param value the value 
	 */
	public function setUIProperty(name:String, value:*):void{
		uiProperties[name] = value;
	}
	
	/**
	 * Returns the UI delegated property value.
	 * @param name the property name
	 * @return the value of specified ui property
	 */
	public function getUIProperty(name:String):*{
		return uiProperties[name];
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
	 * Set a component to be hide or shown.
	 * If a component was hide, some laterly operation may not be done,
	 * they will be done when next shown, ex: repaint, doLayout ....
	 * So suggest you dont changed a component's visible frequently.
	 */
	public function setVisible(v:Boolean):void{
		if(v != visible){
			//TODO imp
			/*visible = v;
			if(v){
				dispatchEvent(createEventObj(ON_SHOWN));
			}else{
				dispatchEvent(createEventObj(ON_HIDDEN));
			}
			//because the repaint and some other operating only do when visible
			//so when change to visible, must call repaint to do the operatings they had not done when invisible
			if(visible){
				repaint();
			}
			revalidate();
			*/
		}
	}
	
	public function isVisible():Boolean{
		return visible;
	}
		
	/**
	 * Determines whether or not this component is on display list.
	 */
	public function isDisplayable():Boolean{
		return this.stage != null;
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
        	return getComponentParent().getFont();
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
        	return getComponentParent().getBackground();
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
        	return getComponentParent().getForeground();
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
     * <p>
     * Subclasses that guarantee to always completely paint their contents
     * should override this method and return true.
     *
     * @return true if this component is completely opaque
     * @see #setOpaque()
     */
    public function isOpaque():Boolean{
    	return opaque;
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
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 * @param b the location and size bounds
	 */
	public function setCompBounds(b:IntRectangle):void{
		setLocationXY(b.x, b.y);
		setSizeWH(b.width, b.height);
	}
	
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 */	
	public function setCompBoundsXYWH(x:int, y:int, w:int, h:int):void{
		setLocationXY(x, y);
		setSizeWH(w, h);
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
	public function getCompBounds(rv:IntRectangle=null):IntRectangle{
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
			//TODO event
			//dispatchEvent(createEventObj(ON_MOVED, oldPos, newPos));
			invalidate();
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
			//TODO
			//size();
			//dispatchEvent(createEventObj(ON_RESIZED, oldSize, newSize));
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
	 * If rv is null or undefined a new Dimension object is allocated. 
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
	
	public function revalidate():void{
		//TODO imp
	}
	
	public function repaint():void{
		//TODO imp
	}
	
	public function invalidate():void{
		//TODO imp
	}
	
	public function validate():void{
		//TODO imp
	}
	
	public function getComponentParent():Component{
		var pa:Component = parent as Component;
		return pa;
	}
	
	override public function toString():String{
		return "Component[asset:" + super.toString() + "]";
	}
}


}