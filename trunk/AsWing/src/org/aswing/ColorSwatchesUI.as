/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
import org.aswing.plaf.BaseComponentUI;

/**
 * Pluggable look and feel interface for JColorSwatchs.
 * 
 * @author iiley
 */
public class ColorSwatchesUI extends BaseComponentUI
{
	/**
	 * Adds a component to this panel's sections bar.
	 * Subclass must override this method
	 * @param com the component to be added
	 */
	public function addComponentColorSectionBar(com:Component):void{
		trace("Subclass must override this method");
		throw new Error("Subclass must override this method");
	}	
}
}