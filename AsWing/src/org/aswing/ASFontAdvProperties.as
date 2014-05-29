/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.text.TextField;
	

/**
 * The advanced properties for font.
 * @see flash.text.TextField
 * @see flash.text.AntiAliasType
 * @see flash.text.GridFitType
 * @author iiley
 */
public class ASFontAdvProperties{
	
	private var fullFeatured:Boolean = false;
 	private var antiAliasType:String;
 	private var gridFitType:String;
 	private var sharpness:Object;
 	private var thickness:Object;
 	private var embedFonts:Object;
 	
	/**
	 * Each property can be specifild null showing it is non-defined value, just like TextFormat. 
	 */
	public function ASFontAdvProperties(embedFonts:Object=false, antiAliasType:String="normal", 
		gridFitType:String="pixel", sharpness:Object=0, thickness:Object=0){
		
		this.embedFonts = embedFonts;
		this.antiAliasType = antiAliasType;
		this.gridFitType = gridFitType;
		this.sharpness = sharpness;
		this.thickness = thickness;
		fullFeatured = judegeWhetherFullFeatured();
	}
	
	public function getAntiAliasType():String{
		return antiAliasType;
	}
	
	public function changeAntiAliasType(newType:String):ASFontAdvProperties{
		return new ASFontAdvProperties(embedFonts, newType, gridFitType, sharpness, thickness);
	}
	
	public function getGridFitType():String{
		return gridFitType;
	}
	
	public function changeGridFitType(newType:String):ASFontAdvProperties{
		return new ASFontAdvProperties(embedFonts, antiAliasType, newType, sharpness, thickness);
	}
	
	public function getSharpness():Object{
		return sharpness;
	}
	
	public function changeSharpness(newSharpness:Object):ASFontAdvProperties{
		return new ASFontAdvProperties(embedFonts, antiAliasType, gridFitType, newSharpness, thickness);
	}
	
	public function getThickness():Object{
		return thickness;
	}
	
	public function changeThickness(newThickness:Object):ASFontAdvProperties{
		return new ASFontAdvProperties(embedFonts, antiAliasType, gridFitType, sharpness, newThickness);
	}
	
	public function isEmbedFonts():Object{
		return embedFonts;
	}
	
	public function changeEmbedFonts(ef:Object):ASFontAdvProperties{
		return new ASFontAdvProperties(ef, antiAliasType, gridFitType, sharpness, thickness);
	}	
	
	/**
	 * Applys the properties to the specified text field.
	 * @param textField the text filed to be applied font.
	 */
	public function apply(textField:TextField):void{
		if(null != isEmbedFonts()){
			textField.embedFonts = isEmbedFonts() == true;
		}
		if(null != getAntiAliasType()){
			textField.antiAliasType = getAntiAliasType();
		}
		if(null != getGridFitType()){
			textField.gridFitType = getGridFitType();
		}
		
		if(null != getSharpness()){
			textField.sharpness = Number(getSharpness());
		}
		
		if(null != getThickness()){
			textField.thickness = Number(getThickness());
		}
	}
		
	/**
	 * When this font will take over an old font to apply to TextField, need call this to combine/replace propertie values.
	 * <br/>
	 * ASFont will call this method to takeover its aASFontAdvProperties selfly.
	 * @return a new ASFontAdvProperties instance to show the taked over value
	 */
	public function takeover(oldF:ASFontAdvProperties):ASFontAdvProperties{
		var nadv:ASFontAdvProperties = new ASFontAdvProperties(embedFonts, antiAliasType, gridFitType, sharpness, thickness);
		if(null == embedFonts){
			nadv.embedFonts = oldF.embedFonts;
		}
		if(null == antiAliasType){
			nadv.antiAliasType = oldF.antiAliasType;
		}
		if(null == gridFitType){
			nadv.gridFitType = oldF.gridFitType;
		}
		if(null == sharpness){
			nadv.sharpness = oldF.sharpness;
		}
		if(null == thickness){
			nadv.thickness = oldF.thickness;
		}
		nadv.fullFeatured = nadv.judegeWhetherFullFeatured();
		return nadv;
	}
	
	/**
	 * Returns whether or not very property are specified non-null value.
	 */
	public function isFullFeatured():Boolean{
		return fullFeatured;
	}
	
	protected function judegeWhetherFullFeatured():Boolean{
		if(null == this.antiAliasType) return false;
		if(null == this.embedFonts) return false;
		if(null == this.gridFitType) return false;
		if(null == this.sharpness) return false;
		if(null == this.thickness) return false;
		return true;
	}	
	
	public function toString():String{
		return "ASFontAdvProperties[" 
			+ "embedFonts : " + embedFonts 
			+ ", antiAliasType : " + antiAliasType 
			+ ", gridFitType : " + gridFitType 
			+ ", sharpness : " + sharpness 
			+ ", thickness : " + thickness 
			+ "]";
	}
}
}