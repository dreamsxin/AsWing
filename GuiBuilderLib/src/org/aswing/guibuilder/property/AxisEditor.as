package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;

public class AxisEditor extends AbsComboIntEditor{
	/**
     * Specifies that components should be laid out left to right.
     */
    public static const X_AXIS:int = 0;
    
    /**
     * Specifies that components should be laid out top to bottom.
     */
    public static const Y_AXIS:int = 1;
	
	public function AxisEditor(){
		super(["X Axis", "Y Axis"]);
	}
}
}