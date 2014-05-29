/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import org.aswing.plaf.basic.BasicProgressBarUI;
import flash.display.DisplayObject;
import org.aswing.geom.IntDimension;

class SkinProgressBarUI extends BasicProgressBarUI{
	
	private var barWidth:Int;
	
	override private function installDefaults():Void{
		super.installDefaults();
		
		barWidth = 0;
		var bgAsset:DisplayObject = progressBar.getBackgroundDecorator().getDisplay(progressBar);
		if(bgAsset != null){
			barWidth =Std.int( bgAsset.height);
		}
	}
	
	override private function uninstallDefaults():Void{
		super.uninstallDefaults();
		barWidth = 0;
	}
    
    override private function getPreferredInnerHorizontal():IntDimension{
    	return new IntDimension(80, barWidth > 0 ? barWidth : 12);
    }
    
    override private function getPreferredInnerVertical():IntDimension{
    	return new IntDimension(barWidth > 0 ? barWidth : 12, 80);
    }
}