/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.plaf
{

import org.aswing.border.EmptyBorder;

/**
 * The default empty border to be the component border as default. So it can be 
 * replaced by LAF specified.
 */
public class DefaultBorderResource extends EmptyBorder implements UIResource
{
	/**
	 * Shared instance.
	 */
	public static const INSTANCE:DefaultBorderResource = new DefaultBorderResource();
	
	public function DefaultBorderResource()
	{
		super();
	}
	
}
}