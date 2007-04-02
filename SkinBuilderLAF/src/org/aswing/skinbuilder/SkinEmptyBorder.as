/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.*;
import org.aswing.border.EmptyBorder;
import org.aswing.plaf.UIResource;
import org.aswing.error.ImpMissError;

public class SkinEmptyBorder extends EmptyBorder implements UIResource{
	
	public function SkinEmptyBorder(){
		super();
	}
	
	protected function getDefaultsKey():String{
    	throw new ImpMissError();
    	return null;	
	}
	
    override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets{
    	return c.getUI().getInsets(getDefaultsKey());
    }	
}
}