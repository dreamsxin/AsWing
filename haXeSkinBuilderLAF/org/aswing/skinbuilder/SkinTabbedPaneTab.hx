/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.basic.accordion.BasicAccordionHeader;

class SkinTabbedPaneTab extends BasicAccordionHeader{
	
	private var topBG:SkinButtonBackground;
	private var bottomBG:SkinButtonBackground;
	private var leftBG:SkinButtonBackground;
	private var rightBG:SkinButtonBackground;
	private var tabPlacement:Int;	
	private var defaultsOwner:ComponentUI;
	
	public function new(){
		super();
		tabPlacement = -1;
	}
	
	override public function setTabPlacement(tp:Int):Void{
		if(tabPlacement != tp){
			tabPlacement = tp;
			if(tp == JTabbedPane.TOP){
				button.setBackgroundDecorator(topBG);
			}else if(tp == JTabbedPane.LEFT){
				button.setBackgroundDecorator(leftBG);
			}else if(tp == JTabbedPane.RIGHT){
				button.setBackgroundDecorator(rightBG);
			}else{
				button.setBackgroundDecorator(bottomBG);
			}
			button.repaint();
		}
	}
	
	override private function createHeaderButton():AbstractButton{
		var tb:JButton = new JButton();
		tb.setTextFilters([]);
		topBG = new SkinButtonBackground(getPropertyPrefix() + "top.tab.");
		bottomBG = new SkinButtonBackground(getPropertyPrefix() + "bottom.tab.");
		leftBG = new SkinButtonBackground(getPropertyPrefix() + "left.tab.");
		rightBG = new SkinButtonBackground(getPropertyPrefix() + "right.tab.");
		topBG.setDefaultsOwner(owner.getUI());
		bottomBG.setDefaultsOwner(owner.getUI());
		leftBG.setDefaultsOwner(owner.getUI());
		rightBG.setDefaultsOwner(owner.getUI());
		tb.setBackgroundDecorator(topBG);
		return tb;
	}
	
	private function getPropertyPrefix():String{
		return "TabbedPane.";
	}
	
	override public function setSelected(b:Bool):Void{
		button.setSelected(b);
	}
}