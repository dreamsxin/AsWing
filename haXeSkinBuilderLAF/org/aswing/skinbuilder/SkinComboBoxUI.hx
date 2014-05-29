/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import org.aswing.plaf.basic.BasicComboBoxUI;
class SkinComboBoxUI extends BasicComboBoxUI{
	
	public function new(){
		super();
	}
	
	override private function createDropDownButton():Component{
		var btn:JButton = new JButton();
		btn.setFocusable(false);
		btn.setBorder(null);
		btn.setOpaque(false);
		btn.setMargin(new Insets());
		btn.setBackgroundDecorator(null);
		var ico:SkinButtonIcon = new SkinButtonIcon(-1, -1, getPropertyPrefix()+"arrowButton.", box);
		btn.setIcon(ico);
		return btn;
	}
}