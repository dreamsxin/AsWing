package org.aswing.skinbuilder;


class SkinFrameMaximizeIcon extends SkinButtonIcon{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
        return "Frame.maximizeIcon.";
    }
}