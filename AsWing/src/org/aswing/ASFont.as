/*
Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import org.aswing.geom.IntDimension;
import org.aswing.plaf.DefaultEmptyDecoraterResource;

/**
 * Font that specified the font name, size, style and whether or not embed.
 * @author iiley
 */
public class ASFont{
	
	private var textFormat:TextFormat;
	private var fullFeatured:Boolean = false;
	private var advancedProperties:ASFontAdvProperties;
	
	/**
	 * Create a font with properties or TextFormat.<br/>
	 * If you specified a TextFormat param, then the font can use be seen a full featured TextFormat font, notic, the 
	 * properties are copied to the font instance, so later change on the pass TextFormat will not affect the font. And, 
	 * notice that serveral calls at same frame, just the last font will take effet.
	 * @param nameOrTextFormat if it is a TextFormat, the font will use the TextFormat properties directly, so the follow size, bold, italic, 
	 * underline params will be ignored except embedFontsOrAdvancedPros
	 * @param size size
	 * @param bold bold
	 * @param italic italic
	 * @param underline underline
	 * @param embedFontsOrAdvancedPros a boolean to indicate whether or not embedFonts or 
	 * 			a <code>ASFontAdvProperties</code> instance.
	 * @see org.aswing.ASFontAdvProperties
	 */
	public function ASFont(nameOrTextFormat:*="Tahoma", size:Number=11, bold:Boolean=false, italic:Boolean=false, underline:Boolean=false, 
						   embedFontsOrAdvancedPros:*=null){
		if(embedFontsOrAdvancedPros is ASFontAdvProperties){
			advancedProperties = embedFontsOrAdvancedPros as ASFontAdvProperties;
		}else{
			advancedProperties = new ASFontAdvProperties(embedFontsOrAdvancedPros==true);
		}
		if(nameOrTextFormat is TextFormat){
			textFormat = cloneTextFormat(nameOrTextFormat);
			fullFeatured = judegeWhetherFullFeatured();
		}else{
			textFormat = new TextFormat(
				nameOrTextFormat, size, 0x0, bold, italic, underline,  
				"", "", TextFormatAlign.LEFT, 0, 0, 0, 0 
			);
			textFormat.blockIndent = 0;
			textFormat.bullet = false;
			textFormat.kerning = false;
			textFormat.letterSpacing = 0;
			textFormat.tabStops = [];
			fullFeatured = true;
		}
	}
	
	/**
	 * Create a font with TextForamt and ASFontAdvProperties
	 */
	public static function create(textFormat:TextFormat, advPro:ASFontAdvProperties):ASFont{
		return new ASFont(textFormat, 11, false, false, false, advPro);
	}
	
	public function getName():String{
		return textFormat.font;
	}
	
	public function changeName(name:String):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.font = name;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function getSize():uint{
		return uint(textFormat.size);
	}
	
	public function changeSize(size:int):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.size = size;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isBold() : Boolean {
		return (textFormat.bold as Boolean);
	}
	
	public function changeBold(bold:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.bold = bold;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isItalic() : Boolean {
		return (textFormat.italic as Boolean);
	}
	
	public function changeItalic(italic:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.italic = italic;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isUnderline() : Boolean {
		return (textFormat.underline as Boolean);
	}
	
	public function changeUnderline(underline:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.underline = underline;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isEmbedFonts():Boolean{
		return advancedProperties.isEmbedFonts();
	}
	
	public function getAdvancedProperties():ASFontAdvProperties{
		return advancedProperties;
	}
	
	/**
	 * Applys the font to the specified text field.
	 * @param textField the text filed to be applied font.
	 * @param beginIndex The zero-based index position specifying the first character of the desired range of text. 
	 * @param endIndex The zero-based index position specifying the last character of the desired range of text. 
	 */
	public function apply(textField:TextField, beginIndex:int=-1, endIndex:int=-1):void{
		advancedProperties.apply(textField);
		textField.setTextFormat(textFormat, beginIndex, endIndex);
		textField.defaultTextFormat = textFormat;
	}
	
	/**
	 * Return a new text format that contains the font properties.
	 * @return a new text format.
	 */
	public function createTextFormat():TextFormat{
		return cloneTextFormat(textFormat);
	}
	
	private function cloneTextFormat(tf:TextFormat):TextFormat{
		var newTF:TextFormat = new TextFormat();
		newTF.align = tf.align;
		newTF.blockIndent = tf.blockIndent;
		newTF.bold = tf.bold;
		newTF.bullet = tf.bullet;
		newTF.color = tf.color;
		newTF.font = tf.font;
		newTF.indent = tf.indent;
		newTF.italic = tf.italic;
		newTF.kerning = tf.kerning;
		newTF.leading = tf.leading;
		newTF.leftMargin = tf.leftMargin;
		newTF.letterSpacing = tf.letterSpacing;
		newTF.rightMargin = tf.rightMargin;
		newTF.size = tf.size;
		newTF.tabStops = tf.tabStops;
		newTF.target = tf.target;
		newTF.underline = tf.underline;
		newTF.url = tf.url;
		return newTF;
	}
	
	/**
	 * Computes text size with this font.
	 * @param text the text to be compute
	 * @includeGutters whether or not include the 2-pixels gutters in the result
	 * @return the computed size of the text
	 * @see org.aswing.AsWingUtils#computeStringSizeWithFont
	 */
	public function computeTextSize(text:String, includeGutters:Boolean=true):IntDimension{
		return AsWingUtils.computeStringSizeWithFont(this, text, includeGutters);
	}
	
	/**
	 * Clone a ASFont, most time you dont need to call this because ASFont 
	 * is un-mutable class, but to avoid UIResource, you can call this.
	 */
	public function clone():ASFont{
		return new ASFont(textFormat, 0, false, false, false, advancedProperties);
	}
	
	/**
	 * If this font is not full featured, the null property values will be filled with default values.
	 * @return a new ASFont instance will be returned if it is not full features, or, it returns itself. 
	 * @see org.aswing.plaf.DefaultEmptyDecoraterResource#DEFAULT_FONT
	 */
	public function makeFullFeatured():ASFont{
		if(!isFullFeatured()){
			return takeover(DefaultEmptyDecoraterResource.DEFAULT_FONT);
		}else{
			return this;
		}
	}
	
	/**
	 * Returns whether or not very TextFormat property are specified non-null value.
	 */
	public function isFullFeatured():Boolean{
		return fullFeatured;
	}
	
	protected function judegeWhetherFullFeatured():Boolean{
		if(null == textFormat.align) return false;
		if(null == textFormat.blockIndent) return false;
		if(null == textFormat.bold) return false;
		if(null == textFormat.bullet) return false;
		if(null == textFormat.color) return false;
		if(null == textFormat.font) return false;
		if(null == textFormat.indent) return false;
		if(null == textFormat.italic) return false;
		if(null == textFormat.kerning) return false;
		if(null == textFormat.leading) return false;
		if(null == textFormat.leftMargin) return false;
		if(null == textFormat.letterSpacing) return false;
		if(null == textFormat.rightMargin) return false;
		if(null == textFormat.size) return false;
		//if(null == textFormat.tabStops) return false;
		if(null == textFormat.target) return false;
		if(null == textFormat.underline) return false;
		if(null == textFormat.url) return false;
		return advancedProperties.isFullFeatured();
	}
	
	/**
	 * When this font will take over an old font to apply to TextField, need call this to combine/replace textFormat properties.
	 * <br/>
	 * Developer do not need to call this method, unless you are going to call apply() method manually.
	 * @return a new ASFont which indicated the font will takeover an old font properties
	 */
	public function takeover(oldF:ASFont):ASFont{
		if(null == oldF){
			oldF = DefaultEmptyDecoraterResource.DEFAULT_FONT;
		}
		if(this == oldF){
			return this;
		}
		var tf:TextFormat = oldF.textFormat;
		var newTextFormat:TextFormat = cloneTextFormat(textFormat);
		if(null == newTextFormat.align){
			newTextFormat.align = tf.align;
		}
		if(null == newTextFormat.blockIndent){
			newTextFormat.blockIndent = tf.blockIndent;
		}
		if(null == newTextFormat.bold){
			newTextFormat.bold = tf.bold;
		}
		if(null == newTextFormat.bullet){
			newTextFormat.bullet = tf.bullet;
		}
		if(null == newTextFormat.color){
			newTextFormat.color = tf.color;
		}
		if(null == newTextFormat.font){
			newTextFormat.font = tf.font;
		}
		if(null == newTextFormat.indent){
			newTextFormat.indent = tf.indent;
		}
		if(null == newTextFormat.italic){
			newTextFormat.italic = tf.italic;
		}
		if(null == newTextFormat.kerning){
			newTextFormat.kerning = tf.kerning;
		}
		if(null == newTextFormat.leading){
			newTextFormat.leading = tf.leading;
		}
		if(null == newTextFormat.leftMargin){
			newTextFormat.leftMargin = tf.leftMargin;
		}
		if(null == newTextFormat.letterSpacing){
			newTextFormat.letterSpacing = tf.letterSpacing;
		}
		if(null == newTextFormat.rightMargin){
			newTextFormat.rightMargin = tf.rightMargin;
		}
		if(null == newTextFormat.size){
			newTextFormat.size = tf.size;
		}
		if(null == newTextFormat.tabStops){
			newTextFormat.tabStops = tf.tabStops;
		}
		if(null == newTextFormat.target){
			newTextFormat.target = tf.target;
		}
		if(null == newTextFormat.underline){
			newTextFormat.underline = tf.underline;
		}
		if(null == newTextFormat.url){
			newTextFormat.url = tf.url;
		}
		var advP:ASFontAdvProperties = advancedProperties.takeover(oldF.advancedProperties);
		return new ASFont(newTextFormat, 0, false, false, false, advP);
	}
	
	public function toString():String{
		return "ASFont[" 
		+ "textFormat : " + textFormat 
			+ "]";
	}
}

}