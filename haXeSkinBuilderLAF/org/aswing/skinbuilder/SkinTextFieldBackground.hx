/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


class SkinTextFieldBackground extends SkinAbsEditorBackground{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
        return "TextField.";
    }
}