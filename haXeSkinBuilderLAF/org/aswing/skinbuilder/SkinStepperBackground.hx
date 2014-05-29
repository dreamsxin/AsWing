package org.aswing.skinbuilder;



/**
 * @author paling
 */
class SkinStepperBackground extends SkinAbsEditorBackground{
	
	public function new()
	{
		super();
	}
	
	override private function getPropertyPrefix():String{
		return "Stepper.";
	}
}