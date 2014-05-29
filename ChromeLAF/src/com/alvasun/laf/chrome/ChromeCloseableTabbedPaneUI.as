package com.alvasun.laf.chrome {
	
	import org.aswing.AbstractButton;
	import org.aswing.Insets;
	import org.aswing.skinbuilder.SkinClosableTabbedPaneUI;

	public class ChromeCloseableTabbedPaneUI extends SkinClosableTabbedPaneUI {
		
		private var zeroInsets : Insets = new Insets(0, 1, 0, 0);
		
		public function ChromeCloseableTabbedPaneUI() {
			super();
		}
		
		override protected function createNextButton():AbstractButton{
			return noMarginButton(super.createNextButton());
		}
		
		override protected function createPrevButton():AbstractButton{
			return noMarginButton(super.createPrevButton());
		}
		
		/**
		 * 此次用图标Button，所以需要去除Margin。
		 *  
		 * @param ab
		 * @return 
		 * 
		 */		
		private function noMarginButton(ab : AbstractButton) : AbstractButton {
			ab.setMargin(zeroInsets);
			return ab;
		}
	}
}