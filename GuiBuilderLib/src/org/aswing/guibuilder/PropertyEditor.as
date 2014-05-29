package org.aswing.guibuilder{

import org.aswing.Component;
import org.aswing.guibuilder.model.ProModel;	

/**
 * The interface for component property editors.
 * @author iiley
 */
public interface PropertyEditor{
	
	function getDisplay():Component;
		
	function applyProperty():void;
		
	function setSerializer(ser:PropertySerializer):void;
	
	function bindTo(pro:ProModel):void;
	
	function setEditorParam(param:String):void;
}
}