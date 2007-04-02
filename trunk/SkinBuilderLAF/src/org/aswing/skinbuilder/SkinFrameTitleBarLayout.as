package org.aswing.skinbuilder{
	
import org.aswing.plaf.basic.frame.TitleBarLayout;
import org.aswing.*;

public class SkinFrameTitleBarLayout extends TitleBarLayout{

	public function SkinFrameTitleBarLayout(){
		super();
	}

	protected function fitSize(target:Container, size:IntDimension):IntDimension{
    	size.change(ICON_TITLE_WIDTH, 0);
    	size.height = Math.max(size.height, target.getUI().getInt("Frame.titleBarHeight"));
    	return size;
	}
}
}