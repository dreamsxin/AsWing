package org.aswing{

import org.aswing.geom.IntDimension;

public class FrameTitleBarLayout extends BorderLayout{
	
	protected var minSize:IntDimension;
	
	public function FrameTitleBarLayout(minWidth:int=50, height:int=20){
		super();
		minSize = new IntDimension(minWidth, height);
	}
	
	protected function countMinSize(target:Container):void{
		var bar:FrameTitleBar = FrameTitleBar(target);
		minSize.height = bar.getMinimizeHeight();
	}
	
    override public function minimumLayoutSize(target:Container):IntDimension {
    	countMinSize(target);
		return preferredLayoutSize(target);
    }
	
	/**
	 * 
	 */
    override public function preferredLayoutSize(target:Container):IntDimension {
    	countMinSize(target);
    	var size:IntDimension = super.preferredLayoutSize(target);
		var bar:FrameTitleBar = FrameTitleBar(target);
    	var label:JLabel = bar.getLabel();
    	if(label && label.isVisible()){
    		size.width -= Math.max(0, label.getPreferredWidth()-60);
    	}
    	size.width = Math.max(minSize.width, size.width);
    	size.height = Math.max(minSize.height, size.height);
    	return size;
    }	
}
}