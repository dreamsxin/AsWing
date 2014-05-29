package org.aswing.guibuilder.model{

/**
 * Layout Definition
 */
public class LayoutDefinition extends AbsAggDefinition{
		
	public function LayoutDefinition(xml:*, superDef:LayoutDefinition){
		super(xml, superDef);
	}
	
	public function toString():String{
		return "LayoutDefintion[name:" + getName() + "]"
	}
}
}