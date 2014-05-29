/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


class SkinRadioButtonIcon extends SkinButtonIcon{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
        return "RadioButton.";
    }
}