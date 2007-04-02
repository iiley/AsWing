/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

public class SkinFrameEmptyBorder extends SkinEmptyBorder{
	
	public function SkinFrameEmptyBorder(){
		super();
	}

	protected function getDefaultsKey():String{
    	return "Frame.margin";
	}	
}
}