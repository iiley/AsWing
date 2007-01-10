/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import org.aswing.geom.IntRectangle;
	
public class Component extends AWSprite
{
	private var bounds:IntRectangle
	private var awmlID:String;
	private var awmlIndex:Number;
	private var awmlNamespace:String;
	private var border:Border;
	private var backgroundDecorator:GroundDecorator;
	private var foregroundDecorator:GroundDecorator;
	private var font:ASFont;
	
	public function Component()
	{
		super();
		bounds = new IntRectangle();
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
            if(isDisplayable()){
            	ui.create(this);
            }
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
	public function setUIProperty(name:String, value):void{
		uiProperties[name] = value;
	}
	
	/**
	 * Returns the UI delegated property value.
	 * @param name the property name
	 * @return the value of specified ui property
	 */
	public function getUIProperty(name:String){
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
	public function setVisible(v:Boolean):Void{
		if(v != visible){
			visible = v;
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
	public function setFont(newFont:ASFont):Void{
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
	public function setFontValidated(b:Boolean):Void{
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
        }
        return (parent != null) ? parent.getFont() : font;
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
	public function setBackground(c:ASColor):Void{
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
		}
		return (parent != null) ? parent.getBackground() : background;
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
	public function setForeground(c:ASColor):Void{
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
		}
		return (parent != null) ? parent.getForeground() : foreground;
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
    public function setOpaque(b:Boolean):Void {
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
    	if(opaque === undefined){
    		return (uiProperties["opaque"] == true);
    	}else{
    		return opaque;
    	}
    }	
    
    /**
     * Sets the alpha for this component.
     * @param alpha the alpha for this component, between 0 and 100. default is 100.
     */
    public function setAlpha(alpha:Number):Void{
    	this.alpha = alpha;
    	this.root_mc._alpha = alpha;
    }
    
    /**
     * Returns the alpha of this component.
     * @return the alpha of this component. default is 100.
     */
    public function getAlpha():Number{
    	return alpha;
    }
		
	/**
	 * setBounds(bounds:IntRectangle)<br>
	 * setBounds(x:Number, y:Number, width:Number, height:Number)
	 * <p>
	 * Sets the location and size.
	 */
	public function setBounds():Void{
		var newBounds:IntRectangle = new IntRectangle(arguments[0], arguments[1], arguments[2], arguments[3]);
		setLocation(newBounds.x, newBounds.y);
		setSize(newBounds.width, newBounds.height);
	}
	
	/**
	 * setBounds(bounds:IntRectangle)<br>
	 * setBounds(x:Number, y:Number, width:Number, height:Number)
	 * <p>
	 * Sets the location immediately if the size is not changed or set the location and size and then 
	 * <code>invalidate</code>.
	 * See {@link #setLocationImmediately()} for more infomation.
	 * @see #setLocationImmediately()
	 * @see #setBounds()
	 * @see #validateLocation()
	 */
	public function setBoundsImmediately():Void{
		var newBounds:IntRectangle = new IntRectangle(arguments[0], arguments[1], arguments[2], arguments[3]);
		if(newBounds.width != bounds.width || newBounds.height != bounds.height){
			setLocation(newBounds.x, newBounds.y);
			setSize(newBounds.width, newBounds.height);
		}else{
			setLocationImmediately(newBounds.x, newBounds.y);
		}
	}
	
	/**
	 * Moves and resizes this component. The new location of the top-left corner is specified by x and y, and the new size is specified by width and height. 
	 * 
	 * <p>Stores the bounds value of this component into "return value" b and returns b. 
	 * If b is null or undefined a new IntRectangle object is allocated. 
	 * 
	 * @param b the return value, modified to the component's bounds.
	 * 
	 * @see #setSize()
	 * @see #setLocation()
	 */
	public function getBounds(b:IntRectangle):IntRectangle{
		if(b != undefined){
			b.setRect(bounds);
			return b;
		}else{
			return new IntRectangle(bounds.x, bounds.y, bounds.width, bounds.height);
		}
	}
	
	/**
	 * setLocation(x:Number, y:Number)<br>
	 * setLocation(p:IntPoint)
	 * <p>
	 * Set the component's location, if it is diffs from old location, invalidate it to wait validate.
	 * The top-left corner of the new location is specified by the x and y parameters 
	 * in the coordinate space of this component's parent.
	 */
	public function setLocation():Void{
		var newPos:IntPoint = new IntPoint(arguments[0], arguments[1]);
		var oldPos:IntPoint = new IntPoint(bounds.x, bounds.y);
		if(!newPos.equals(oldPos)){
			bounds.setLocation(newPos);
			dispatchEvent(createEventObj(ON_MOVED, oldPos, newPos));
			invalidate();
		}
	}
	
	/**
	 * setLocationImmediately(x:Number, y:Number)<br>
	 * setLocationImmediately(p:IntPoint)
	 * <p>
	 * Set the component's location and move it's assets immediately.<br>
	 * <b>Note:</b>
	 * The method may be fast(cool thing:)), but take care to use it, because it will not 
	 * call <code>invalidate()</code>, it validate the new location immediately(
	 * <code>setLocation</code> method will <code>invalidate</code> the component and 
	 * then may validate the move at next frame, it is time different), it is just move 
	 * the component location, will not cause it's container relayouting, so it is 
	 * <b>faster</b> than <code>setLocation</code> generally.  However, generally the 
	 * layout managers do not care the old location of it's children, but you must 
	 * ensure it really do not, then call this method to move the component.
	 * @see #setLocation()
	 * @see #setBoundsImmediately()
	 * @see #validateLocation()
	 */
	public function setLocationImmediately():Void{
		var newPos:IntPoint = new IntPoint(arguments[0], arguments[1]);
		var oldPos:IntPoint = new IntPoint(bounds.x, bounds.y);
		if(!newPos.equals(oldPos)){
			bounds.setLocation(newPos);
			dispatchEvent(createEventObj(ON_MOVED, oldPos, newPos));
			validateLocation();
		}
	}	
	
	override public function toString():String{
		return "Component[asset:" + super.toString() + "]";
	}
}


}