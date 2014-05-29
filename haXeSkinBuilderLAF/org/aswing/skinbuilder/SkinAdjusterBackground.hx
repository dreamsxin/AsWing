package org.aswing.skinbuilder;



/**
 * @author paling
 */
class SkinAdjusterBackground extends SkinAbsEditorBackground{
	
	public function new()
	{
		super();
	}
	
	override private function getPropertyPrefix():String{
		return "Adjuster.";
	}
	
}