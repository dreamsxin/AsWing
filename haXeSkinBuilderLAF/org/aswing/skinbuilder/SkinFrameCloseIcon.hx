package org.aswing.skinbuilder;


class SkinFrameCloseIcon extends SkinButtonIcon{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
        return "Frame.closeIcon.";
    }
}