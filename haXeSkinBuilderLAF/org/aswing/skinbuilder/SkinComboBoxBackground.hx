/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;

	
class SkinComboBoxBackground extends SkinAbsEditorRolloverEnabledBackground{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
        return "ComboBox.";
    }
}