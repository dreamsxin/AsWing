/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import org.aswing.plaf.basic.accordion.BasicAccordionHeader;

class SkinAccordionHeader extends BasicAccordionHeader{
	
	public function new(){
		super();
	}

	override private function createHeaderButton():AbstractButton{
		var tb:JButton = new JButton();
		var sbg:SkinButtonBackground = new SkinButtonBackground(getPropertyPrefix());
		sbg.setDefaultsOwner(owner.getUI());
		tb.setBackgroundDecorator(sbg);
		return tb;
	}
	
	private function getPropertyPrefix():String{
		return "Accordion.header.";
	}
	
	override public function setSelected(b:Bool):Void{
		button.setSelected(b);
	}
}