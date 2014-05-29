package org.aswing.guibuilder.property{

import org.aswing.ASFont;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
import org.aswing.guibuilder.util.MathUtils;

public class FontSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		var xml:XML = valueXML;
		if(xml.@value == "null"){
			return new SimpleValue(null);
		}
		var name:String = xml.@name;
		var size:int = MathUtils.parseInteger(xml.@size);
		var bold:Boolean = (xml.@bold == "true");
		var italic:Boolean = (xml.@italic == "true");
		var underline:Boolean = (xml.@underline == "true");
		var embedFonts:Boolean = (xml.@embedFonts == "true");
		var f:ASFont = new ASFont(name, size, bold, italic, underline, embedFonts);
		return new SimpleValue(f);
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var xml:XML = <Value></Value>;
		if(value.getValue() == null){
			xml.@value="null";
			return xml;
		}
		var f:ASFont = value.getValue();
		xml.@name = f.getName();
		xml.@size = f.getSize()+"";
		xml.@bold = f.isBold()+"";
		xml.@italic = f.isItalic()+"";
		xml.@underline = f.isUnderline()+"";
		xml.@embedFonts = f.isEmbedFonts()+"";
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		var font:ASFont = value.getValue();
		if(font == null){
			return "null";
		}
		return "new ASFont(\"" + font.getName()
				+ "\", " + font.getSize() 
				+ ", " + font.isBold() 
				+ ", " + font.isItalic() 
				+ ", " + font.isUnderline()
				+ ", " + font.isEmbedFonts()
				 + ")";
	}
	
}
}