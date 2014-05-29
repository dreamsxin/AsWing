package org.aswing.guibuilder.property {

	import org.aswing.guibuilder.model.ProModel;
	import org.aswing.guibuilder.model.ValueModel;
	import org.aswing.guibuilder.util.MathUtils;
	import org.aswing.util.HashMap;
	
	public class AlignSerializer extends IntSerializer {
		
		static private var values:HashMap = null;
		
		private static function getValues():HashMap {
			if( values == null ) values = new HashMap();
			values.put( 0, "AsWingConstants.CENTER" );
			values.put( 1, "AsWingConstants.TOP" );
			values.put( 2, "AsWingConstants.LEFT" );
			values.put( 3, "AsWingConstants.BOTTOM" );
			values.put( 4, "AsWingConstants.RIGHT" );
			return values;
		}
		
		override public function isSimpleOneLine(value:ValueModel, pro:ProModel):String {
			return getValues().getValue( MathUtils.parseInteger( String( value ) ) );
		}
		
	}
}