/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf
{
	
import org.aswing.Component;
import org.aswing.geom.*;
import org.aswing.graphics.*;
	
public interface ComponentUI
{

    /**
     * Configures the specified component appropriate for the look and feel.
     * This method is invoked when the <code>ComponentUI</code> instance is being installed
     * as the UI delegate on the specified component.  This method should
     * completely configure the component for the look and feel,
     * including the following:
     * <ol>
     * <li>Install any default property values for color, fonts, borders,
     *     icons, opacity, etc. on the component.  Whenever possible, 
     *     property values initialized by the client program should <i>not</i> 
     *     be overridden.
     * <li>Install a <code>LayoutManager</code> on the component if necessary.
     * <li>Create/add any required sub-components to the component.
     * <li>Create/install event listeners on the component.
     * <li>Install keyboard UI (mnemonics, traversal, etc.) on the component.
     * <li>Initialize any appropriate instance data.
     * </ol>
     * @param c the component where this UI delegate is being installed
     *
     * @see #uninstallUI
     * @see org.aswing.Component#setUI
     * @see org.aswing.Component#updateUI
     */
    function installUI(c:Component):void;

    /**
     * Reverses configuration which was done on the specified component during
     * <code>installUI</code>.  This method is invoked when this 
     * <code>ComponentUI</code> instance is being removed as the UI delegate 
     * for the specified component.  This method should undo the
     * configuration performed in <code>installUI</code>, being careful to 
     * leave the <code>Component</code> instance in a clean state (no 
     * extraneous listeners, look-and-feel-specific property objects, etc.).
     * This should include the following:
     * <ol>
     * <li>Remove any UI-set borders from the component.
     * <li>Remove any UI-set layout managers on the component.
     * <li>Remove any UI-added sub-components from the component.
     * <li>Remove any UI-added event listeners from the component.
     * <li>Remove any UI-installed keyboard UI from the component.
     * <li>Remove any UI-added MCs from this component.
     * <li>Nullify any allocated instance data objects to allow for GC.
     * </ol>
     * @param c the component from which this UI delegate is being removed;
     *          this argument is often ignored,
     *          but might be used if the UI object is stateless
     *          and shared by multiple components
     *
     * @see #installUI
     * @see org.aswing.Component#updateUI
     */
    function uninstallUI(c:Component):void;
    /**
     * Notifies this UI delegate that it's time to paint the specified
     * component.  This method is invoked by <code>Component</code> 
     * when the specified component is being painted.
     *
     * <p>In general this method need be overridden by subclasses;
     * all look-and-feel rendering code should reside in this method.
     * And there is a default background paint method, you should call
     * it in your overridden paint method.
     * 
     * @param c the component being painted;
     *          this argument is often ignored,
     *          but might be used if the UI object is stateless
     *          and shared by multiple components.
     * @param g the Graphics context in which to paint.
     * @param b the bounds to paint UI in.
     * 
     * @see org.aswing.Component#paint
     * @see #paintBackGround
     */
    function paint(c:Component, g:Graphics2D, b:IntRectangle):void;
    
    /**
     * Returns the specified component's preferred size appropriate for
     * the look and feel.  If <code>null</code> is returned, the preferred
     * size will be calculated by the component's layout manager instead 
     * (this is the preferred approach for any component with a specific
     * layout manager installed).  The default implementation of this 
     * method returns <code>null</code>.
     *
     * @param c the component whose preferred size is being queried;
     *          this argument is often ignored,
     *          but might be used if the UI object is stateless
     *          and shared by multiple components
     *
     * @see org.aswing.Component#getPreferredSize
     * @see org.aswing.LayoutManager#preferredLayoutSize
     */
    function getPreferredSize(c:Component):IntDimension;

    /**
     * Returns the specified component's minimum size appropriate for
     * the look and feel.  If <code>null</code> is returned, the minimum
     * size will be calculated by the component's layout manager instead 
     * (this is the preferred approach for any component with a specific
     * layout manager installed).  The default implementation of this 
     * method invokes <code>getPreferredSize</code> and returns that value.
     *
     * @param c the component whose minimum size is being queried;
     *          this argument is often ignored,
     *          but might be used if the UI object is stateless
     *          and shared by multiple components
     *
     * @return a <code>IntDimension</code> object or <code>null</code>
     *
     * @see org.aswing.Component#getMinimumSize
     * @see org.aswing.LayoutManager#minimumLayoutSize
     * @see #getPreferredSize
     */
    function getMinimumSize(c:Component):IntDimension;

    /**
     * Returns the specified component's maximum size appropriate for
     * the look and feel.  If <code>null</code> is returned, the maximum
     * size will be calculated by the component's layout manager instead 
     * (this is the preferred approach for any component with a specific
     * layout manager installed).  The default implementation of this 
     * method invokes <code>getPreferredSize</code> and returns that value.
     *
     * @param c the component whose maximum size is being queried;
     *          this argument is often ignored,
     *          but might be used if the UI object is stateless
     *          and shared by multiple components
     * @return a <code>IntDimension</code> object or <code>null</code>
     *
     * @see org.aswing.Component#getMaximumSize
     * @see org.aswing.LayoutManager#maximumLayoutSize
     * @see #getPreferredSize
     */
    function getMaximumSize(c:Component):IntDimension;
}
	
}