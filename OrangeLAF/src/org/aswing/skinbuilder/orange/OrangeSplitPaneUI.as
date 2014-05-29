package org.aswing.skinbuilder.orange{

import org.aswing.plaf.basic.BasicSplitPaneUI;
import org.aswing.plaf.basic.splitpane.Divider;

public class OrangeSplitPaneUI extends BasicSplitPaneUI{
	
	override protected function createDivider():Divider{
		return new OrangeSplitPaneDivider(sp);
	}
}
}