package com.alvasun.laf.blue {
	import org.aswing.ASColor;
	import org.aswing.border.LineBorder;
	import org.aswing.plaf.UIResource;

	public class BluenessComboBoxPopupBorder extends LineBorder implements UIResource 	{
		public function BluenessComboBoxPopupBorder() {
			super(new LineBorder(null, new ASColor(0xdddddd)), new ASColor(0xcccccc));
		}
		
	}
}