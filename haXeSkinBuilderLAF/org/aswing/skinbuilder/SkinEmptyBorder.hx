/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import org.aswing.border.EmptyBorder;
import org.aswing.plaf.UIResource;
import org.aswing.error.ImpMissError;

class SkinEmptyBorder extends EmptyBorder   implements UIResource{
	
	public function new(top:Int=0, left:Int=0, bottom:Int=0, right:Int=0){
		super(null, new Insets(top, left, bottom, right));
	}
	
}