/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
 	import org.aswing.Orientable;
	import org.aswing.AbstractButton;
	import org.aswing.skinbuilder.SkinSplitPaneDividerBackground;
	import org.aswing.JButton;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.basic.splitpane.Divider;
	import org.aswing.skinbuilder.SkinButtonIcon; 
	import org.aswing.JSplitPane;

class SkinSplitPaneDivider extends Divider  implements Orientable{
	
	private var leftIco:SkinButtonIcon;
	private var rightIco:SkinButtonIcon;
	private var upIco:SkinButtonIcon;
	private var downIco:SkinButtonIcon;
	
	public function new(sp:JSplitPane){
		super(sp);
		var ui:ComponentUI = sp.getUI();
		var bg:SkinSplitPaneDividerBackground = new SkinSplitPaneDividerBackground();
		bg.setDefaultsOwner(ui);
		setBackgroundDecorator(bg);
		icon = null;
		leftIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowLeft.");
		leftIco.setDefaultsOwner(ui);
		leftIco.checkSetup(sp);
		rightIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowRight.");
		rightIco.setDefaultsOwner(ui);
		rightIco.checkSetup(sp);
		upIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowUp.");
		upIco.setDefaultsOwner(ui);
		upIco.checkSetup(sp);
		downIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowDown.");
		downIco.setDefaultsOwner(ui);
		downIco.checkSetup(sp);
	}
	
	//make the bg can get ui defaults properties from split pane ui
	override public function getUI():ComponentUI{
		return sp.getUI();
	}
	
    public function setOrientation(ori:Int):Void{
    }

    public function getOrientation():Int{
    	return sp.getOrientation();
    }
	
	override private function layoutButtons():Void{
		if(sp.isOneTouchExpandable()){
			if(sp.getOrientation() == JSplitPane.VERTICAL_SPLIT){
				leftButton.setIcon(upIco);
				rightButton.setIcon(downIco);
				leftButton.pack();
				rightButton.pack();
				leftButton.setLocationXY(0, 0);
				rightButton.setLocationXY(leftButton.getWidth(), getHeight()-rightButton.getHeight());
			}else{
				leftButton.setIcon(leftIco);
				rightButton.setIcon(rightIco);
				leftButton.pack();
				rightButton.pack();
				leftButton.setLocationXY(0, 0);
				rightButton.setLocationXY(getWidth()-rightButton.getWidth(), leftButton.getHeight());
			}
			leftButton.setVisible(true);
			rightButton.setVisible(true);
			leftButton.validate();
			rightButton.validate();
			leftButton.repaint();
			rightButton.repaint();
		}else{
			leftButton.setVisible(false);
			rightButton.setVisible(false);
		}
	}
	
	override private function createCollapseLeftButton():AbstractButton{
		var btn:JButton = new JButton();
		btn.setBackgroundDecorator(null);
		return btn;
	}
	
	override private function createCollapseRightButton():AbstractButton{
		var btn:JButton = new JButton();
		btn.setBackgroundDecorator(null);
		return btn;
	}	
}