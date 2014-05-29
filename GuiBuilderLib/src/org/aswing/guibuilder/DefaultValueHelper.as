package org.aswing.guibuilder{

import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ValueModel;
	
/**
 * Some serializer will help to judge the default value, such as PreferredSize property
 */
public interface DefaultValueHelper{
	
	function getDefaultValue(propertyName:String, model:Model):ValueModel;
	
	function isNeedHelp(propertyName:String, model:Model):Boolean;
	
}
}