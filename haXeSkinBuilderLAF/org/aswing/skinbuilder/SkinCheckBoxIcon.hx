/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


class SkinCheckBoxIcon extends SkinButtonIcon{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
        return "CheckBox.";
    }
}