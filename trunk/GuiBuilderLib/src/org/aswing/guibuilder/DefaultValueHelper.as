package org.aswing.guibuilder{

import org.aswing.guibuilder.model.Model;
	
/**
 * Some serializer will help to judge the default value, such as PreferredSize property
 */
public interface DefaultValueHelper{
	
	function getDefaultValue(propertyName:String, model:Model):*;
	
	function isNeedHelp(propertyName:String, model:Model):Boolean;
	
}
}