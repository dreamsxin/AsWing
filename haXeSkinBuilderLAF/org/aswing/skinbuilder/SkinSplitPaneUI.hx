package org.aswing.skinbuilder;

	
import org.aswing.plaf.basic.BasicSplitPaneUI;
import org.aswing.plaf.basic.splitpane.Divider;

class SkinSplitPaneUI extends BasicSplitPaneUI{
	public function new() {
		super();
	}
	override private function createDivider():Divider{
		return new SkinSplitPaneDivider(sp);
	}
}