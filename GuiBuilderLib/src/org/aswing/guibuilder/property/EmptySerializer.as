package org.aswing.guibuilder.property
{
	import org.aswing.guibuilder.PropertySerializer;
	import org.aswing.guibuilder.model.ProModel;
	import org.aswing.guibuilder.model.ValueModel;

	public class EmptySerializer implements PropertySerializer
	{
		public function decodeValue(valueXML:XML, pro:ProModel):ValueModel
		{
			return null;
		}
		
		public function encodeValue(value:ValueModel, pro:ProModel):XML
		{
			return null;
		}
		
		public function getCodeLines(value:ValueModel, pro:ProModel):Array
		{
			return null;
		}
		
		public function isSimpleOneLine(value:ValueModel, pro:ProModel):String
		{
			return null;
		}
		
	}
}