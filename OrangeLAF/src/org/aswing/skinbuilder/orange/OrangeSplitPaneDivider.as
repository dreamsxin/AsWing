package org.aswing.skinbuilder.orange{

import org.aswing.plaf.basic.splitpane.Divider;
import org.aswing.*;
import org.aswing.plaf.*;
import org.aswing.skinbuilder.SkinButtonIcon;

public class OrangeSplitPaneDivider extends Divider implements Orientable{
	
	protected var leftIco:SkinButtonIcon;
	protected var rightIco:SkinButtonIcon;
	protected var upIco:SkinButtonIcon;
	protected var downIco:SkinButtonIcon;
	
	public function OrangeSplitPaneDivider(sp:JSplitPane){
		super(sp);
		
		setBackgroundDecorator(new OrangeSplitPaneDividerBackground(sp));
		icon = null;
		leftIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowLeft.", sp);
		leftIco.checkSetup(sp);
		rightIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowRight.", sp);
		rightIco.checkSetup(sp);
		upIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowUp.", sp);
		upIco.checkSetup(sp);
		downIco = new SkinButtonIcon(-1, -1, "SplitPane.arrowDown.", sp);
		downIco.checkSetup(sp);
	}
	
	//make the bg can get ui defaults properties from split pane ui
	override public function getUI():ComponentUI{
		return sp.getUI();
	}
	
    public function setOrientation(ori:int):void{
    }

    public function getOrientation():int{
    	return sp.getOrientation();
    }
	
	override protected function layoutButtons():void{
		if(sp.isOneTouchExpandable()){
			if(sp.getOrientation() == JSplitPane.VERTICAL_SPLIT){
				leftButton.setIcon(upIco);
				rightButton.setIcon(downIco);
				leftButton.pack();
				rightButton.pack();
				leftButton.setLocationXY(0, (getHeight() - leftButton.getHeight())/2);
				rightButton.setLocationXY(leftButton.getWidth(), (getHeight()-rightButton.getHeight())/2);
			}else{
				leftButton.setIcon(leftIco);
				rightButton.setIcon(rightIco);
				leftButton.pack();
				rightButton.pack();
				rightButton.setLocationXY((getWidth()-rightButton.getWidth())/2, 0);
				leftButton.setLocationXY((getWidth()-leftButton.getWidth())/2, rightButton.getHeight());
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
	
	override protected function createCollapseLeftButton():AbstractButton{
		var btn:JButton = new JButton();
		btn.setBackgroundDecorator(null);
		btn.setMargin(new Insets());
		btn.setBorder(null);
		return btn;
	}
	
	override protected function createCollapseRightButton():AbstractButton{
		var btn:JButton = new JButton();
		btn.setBackgroundDecorator(null);
		btn.setMargin(new Insets());
		btn.setBorder(null);
		return btn;
	}	
}
}