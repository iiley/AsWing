package org.aswing.guibuilder{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.border.TitledBorder;

public class FilePane extends JPanel{
	
	public function FilePane(){
		super();
		setPreferredWidth(50);
		setBorder(new TitledBorder(null, "Files"));
	}
	
}
}