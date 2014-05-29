package org.aswing.guibuilder.model{

public class BorderDefinition extends AbsAggDefinition{
	
	public function BorderDefinition(xml:*, superDef:AbsAggDefinition){
		super(xml, superDef);
	}
	
	public function toString():String{
		return "BorderDefintion[name:" + getName() + "]"
	}
}
}