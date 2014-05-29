/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;

	
import org.aswing.AssetBackground;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;

class SkinAssetBackground extends AssetBackground  implements UIResource{
	
	public function new(asset:DisplayObject){
		super(asset);
	}
	
}