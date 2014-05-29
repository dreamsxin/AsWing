package com.alvasun.laf.chrome
{
	import org.aswing.ASColor;
	import org.aswing.border.LineBorder;
	import org.aswing.plaf.UIResource;

	public class ChromeComboBoxPopupBorder extends LineBorder implements UIResource
	{
		public function ChromeComboBoxPopupBorder()
		{
			super(new LineBorder(null, new ASColor(0xdddddd)), new ASColor(0xcccccc));
		}
		
	}
}