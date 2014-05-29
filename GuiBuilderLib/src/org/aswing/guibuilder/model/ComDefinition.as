package org.aswing.guibuilder.model{

import org.aswing.Container;

/**
 * Component definition
 * @author iiley
 */
public class ComDefinition extends AbsAggDefinition{
	
	private var container:Boolean;
	
	public function ComDefinition(xml:*, superDef:ComDefinition){
		super(xml, superDef);
		
		var c:AbsAggDefinition = this;
		while(c != null){
			if(c.getClass() == Container){
				container = true;
				break;
			}
			c = c.getSuperDefinition();
		}
	}
	
	/**
	 * Return whether this component can has children.
	 */
	public function isContainer():Boolean{
		return container;
	}
	
	public function toString():String{
		return "ComDefintion[name:" + getName() + "]"
	}
}
}