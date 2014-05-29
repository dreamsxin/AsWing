package org.aswing.skinbuilder;


import org.aswing.plaf.basic.BasicStepperUI;


/**
 * @author paling
 */
class SkinStepperUI extends BasicStepperUI{
	
	public function new(){
		super();
	}
	
	/**
	 * Just override this method if you want other LAF drop down buttons.
	 */
	override private function createButton(direction:Float):Component{
		var icon:Icon ;
		if(direction < 0){//up
			icon = new SkinButtonIcon(-1, -1, getPropertyPrefix()+"arrowUp.", stepper);
		}else{//down
			icon = new SkinButtonIcon(-1, -1, getPropertyPrefix()+"arrowDown.", stepper);
		}
		var btn:JButton = new JButton("", icon);
		btn.setFocusable(false);
		//btn.setPreferredSize(new IntDimension(15, 15));
		btn.setBackgroundDecorator(null);
		btn.setMargin(new Insets());
		btn.setBorder(null);
		//make it proxy to the stepper
		btn.setMideground(null);
		btn.setStyleTune(null);
		return btn;
	}	
}