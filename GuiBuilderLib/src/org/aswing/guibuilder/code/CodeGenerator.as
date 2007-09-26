package org.aswing.guibuilder.code{
	
import org.aswing.guibuilder.model.FileModel;	

public class CodeGenerator{
	
	private var file:FileModel;
	
	public function CodeGenerator(file:FileModel){
		this.file = file;	
	}
	
	
	/**
	 * Generates AS3 class code for this ui file.
	 */
	public function generateCode():String{
		return null;
	}
	
}
}