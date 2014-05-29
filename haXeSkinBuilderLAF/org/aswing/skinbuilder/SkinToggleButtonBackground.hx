/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


class SkinToggleButtonBackground extends SkinButtonBackground{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
        return "ToggleButton.";
    }
}