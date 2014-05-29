package com.alvasun.laf.chrome {
	
	import flash.filters.DropShadowFilter;
	
	import org.aswing.UIDefaults;
	import org.aswing.plaf.ASColorUIResource;
	import org.aswing.plaf.ASFontUIResource;
	import org.aswing.plaf.InsetsUIResource;
	import org.aswing.plaf.basic.BasicLookAndFeel;
	import org.aswing.skinbuilder.SkinAccordionHeader;
	import org.aswing.skinbuilder.SkinAdjusterSliderThumb;
	import org.aswing.skinbuilder.SkinAdjusterUI;
	import org.aswing.skinbuilder.SkinButtonBackground;
	import org.aswing.skinbuilder.SkinCheckBoxIcon;
	import org.aswing.skinbuilder.SkinComboBoxBackground;
	import org.aswing.skinbuilder.SkinComboBoxUI;
	import org.aswing.skinbuilder.SkinEmptyBorder;
	import org.aswing.skinbuilder.SkinFrameBackground;
	import org.aswing.skinbuilder.SkinFrameCloseIcon;
	import org.aswing.skinbuilder.SkinFrameIconifiedIcon;
	import org.aswing.skinbuilder.SkinFrameMaximizeIcon;
	import org.aswing.skinbuilder.SkinFrameNormalIcon;
	import org.aswing.skinbuilder.SkinFrameTitleBarBG;
	import org.aswing.skinbuilder.SkinProgressBarBackground;
	import org.aswing.skinbuilder.SkinProgressBarForeground;
	import org.aswing.skinbuilder.SkinProgressBarUI;
	import org.aswing.skinbuilder.SkinRadioButtonIcon;
	import org.aswing.skinbuilder.SkinScrollBarBackground;
	import org.aswing.skinbuilder.SkinScrollBarThumb;
	import org.aswing.skinbuilder.SkinScrollBarUI;
	import org.aswing.skinbuilder.SkinSliderThumb;
	import org.aswing.skinbuilder.SkinSliderUI;
	import org.aswing.skinbuilder.SkinSplitPaneUI;
	import org.aswing.skinbuilder.SkinTabbedPaneTab;
	import org.aswing.skinbuilder.SkinTableHeaderCellBackground;
	import org.aswing.skinbuilder.SkinTableHeaderSortableCellBackground;
	import org.aswing.skinbuilder.SkinTextAreaBackground;
	import org.aswing.skinbuilder.SkinTextFieldBackground;
	import org.aswing.skinbuilder.SkinToggleButtonBackground;
	import org.aswing.skinbuilder.SkinToolTipBackground;
	import org.aswing.skinbuilder.SkinTreeExpandControl;
	import org.aswing.skinbuilder.SkinTreeFolderCollapsedIcon;
	import org.aswing.skinbuilder.SkinTreeFolderExpandedIcon;
	import org.aswing.skinbuilder.SkinTreeLeafIcon;
	
	/**
	 * 一套铬镍色(银色)AsWing皮肤。
	 * 其原型是SkinBuilderLAF(http://svn.aswing.org/aswing/trunk/SkinBuilderLAF)。
	 *  
	 * @author AlvaSun
	 * @see BasicLookAndFeel
	 */	
	public class ChromeLAF extends BasicLookAndFeel	{
		
		public function ChromeLAF() {
			super();
		}
		
		/**
		 * 某些Basic UI组件不能满足需求，你可以自己创建对应的UI组件。
		 * 格式如下name=UI Class ID， value=UI组件的类。
		 * UI Class ID参见Component的getUIClassID()方法。
		 *  
		 * @param table
		 * 
		 */		
		override protected function initClassDefaults(table : UIDefaults) : void {
			super.initClassDefaults(table);
			var uiDefaults:Array = [ 
	 		   "ScrollBarUI", SkinScrollBarUI, 
	 		   "ComboBoxUI", SkinComboBoxUI,
	 		   "TabbedPaneUI", ChromeTabbedPaneUI, 
	 		   "ClosableTabbedPaneUI", ChromeCloseableTabbedPaneUI, 
	 		   "SliderUI", SkinSliderUI,	
			   "ProgressBarUI", SkinProgressBarUI,
			   "AdjusterUI", SkinAdjusterUI, 
			   "SplitPaneUI", SkinSplitPaneUI,
			];
			table.putDefaults(uiDefaults);
		}
		
		/**
		 * 系统颜色设置。
		 *  
		 * @param table
		 * 
		 */		
		override protected function initSystemColorDefaults(table : UIDefaults) : void {
			super.initSystemColorDefaults(table);
			var defaultSystemColors:Array = [
				//"activeCaption", 0xff3737,			/* 激活的JFrame标题栏的颜色 */
				"activeCaptionText", 0x000000,			/* 激活的JFrame标题栏的文字颜色 */
				//"activeCaptionBorder", 0xff3737,		/* 激活的JFrame标题栏的边框颜色 */
				//"inactiveCaption", 0xE7E7E7,			/* 未激活的JFrame标题栏的颜色 */
				"inactiveCaptionText", 0x999999,		/* 未激活的JFrame标题栏的文字颜色 */
				//"inactiveCaptionBorder", 0x888888,	/* 未激活的JFrame标题栏的边框颜色 */
				"window", 0xf7f7f7,               		/* JWindow的内部背景颜色 */
				//"windowBorder", 0x000000,
				"windowText", 0x000000,					/* 字体颜色，主要用于下边的JFrame JToolBar的前景颜色 */
				"menu", 0xe7e7e7,						/* 菜单背景颜色 */
				"menuText", 0x000000,					/* 菜单字体颜色 */
				//"text", 0xC0C0ff,                 	/* Text background color */
				//"textText", 0x00FF00,             	/* Text foreground color */
				//"textHighlight", 0x000080,        	/* Text background color when selected */
				"textHighlightText", 0xFFFFFF,    	/* Text color when selected */
				//"textInactiveText", 0x808080,     	/* Text color when disabled */
				//"control", 0xF4F4F4,//0xEFEFEF,   	/* Default color for controls (buttons, sliders, etc) */
				"controlText", 0x000000,          		/* Default color for text in controls */
				//"controlHighlight", 0xEEEEEE,     	/* Specular highlight (opposite of the shadow) */
				//"controlLtHighlight", 0x666666,   	/* Highlight color for controls */
				//"controlShadow", 0xC7C7C5,        	/* Shadow color for controls */
				//"controlDkShadow", 0x666666,      	/* Dark shadow color for controls */
				//"scrollbar", 0xE0E0E0             	/* Scrollbar background (usually the "track") */
				"selectionBackground", 0xdbecf4,
				"selectionForeground", 0x000000, 
			];
					
			for(var i:int = 0; i < defaultSystemColors.length; i += 2) {
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
			table.put("focusInner", new ASColorUIResource(0x35d5fe));
			table.put("focusOutter", new ASColorUIResource(0x3c7fb1));
		}
		
		/**
		 * 系统字体配置。
		 *  
		 * @param table
		 * 
		 */		
		override protected function initSystemFontDefaults(table:UIDefaults):void{
			super.initSystemFontDefaults(table);
			var fontName : String = "Tahoma";
			var font12 : ASFontUIResource = new ASFontUIResource(fontName, 12);
			var font12Bold : ASFontUIResource = new ASFontUIResource(fontName, 12, true);
			var font14 : ASFontUIResource = new ASFontUIResource(fontName, 13);
			var font14Bold : ASFontUIResource = new ASFontUIResource(fontName, 13, true);
			var defaultSystemFonts:Array = [
				"systemFont", font12, 
				"menuFont", font12, 
				"controlFont", font12, 
				"windowFont", font12,
				"frameFont", font14,
				"font12", font12,
				"font12Bold", font12Bold,
				"font14", font14,
				"font14Bold", font14Bold,
			];
			table.putDefaults(defaultSystemFonts);
		}
		
		override protected function initCommonUtils(table : UIDefaults) : void {
			super.initCommonUtils(table);
			var cursors:Array = [
				"System.hResizeCursor", System_hResizeCursor,
				"System.vResizeCursor", System_vResizeCursor,
				"System.hvResizeCursor", System_hvResizeCursor,
				"System.hMoveCursor", System_hMoveCursor,
				"System.vMoveCursor", System_vMoveCursor,
			];
			table.putDefaults(cursors);
		}
		
		// 系统鼠标样式
		[Embed(source="assets/chrome.swf", symbol="System_hResizeCursor")]
		private var System_hResizeCursor : Class;
		
		[Embed(source="assets/chrome.swf", symbol="System_vResizeCursor")]
		private var System_vResizeCursor : Class;
		
		[Embed(source="assets/chrome.swf", symbol="System_hvResizeCursor")]
		private var System_hvResizeCursor : Class;
		
		[Embed(source="assets/chrome.swf", symbol="System_hMoveCursor")]
		private var System_hMoveCursor : Class;
		
		[Embed(source="assets/chrome.swf", symbol="System_vMoveCursor")]
		private var System_vMoveCursor : Class;
		
		// JButton
		[Embed(source="assets/chrome.swf", symbol="Button_DefaultButton_defaultImage")]
		private var Button_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Button_pressedImage")]
		private var Button_pressedImage:Class;
			
		[Embed(source="assets/chrome.swf", symbol="Button_rolloverImage")]	
		private var Button_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Button_disabledImage")]
		private var Button_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Button_DefaultButton_defaultImage")]
		private var Button_DefaultButton_defaultImage:Class;
		
		// JToggleButton
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_defaultImage")]
		private var ToggleButton_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_pressedImage")]
		private var ToggleButton_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_disabledImage")]
		private var ToggleButton_disabledImage:Class;

		[Embed(source="assets/chrome.swf", symbol="ToggleButton_pressedImage")]
		private var ToggleButton_selectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_disabledImage")]
		private var ToggleButton_disabledSelectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_rolloverImage")]
		private var ToggleButton_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_pressedImage")]
		private var ToggleButton_rolloverSelectedImage:Class;
		
		// JRadioButton
		[Embed(source="assets/chrome.swf", symbol="RadioButton_defaultImage")]
		private var RadioButton_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="RadioButton_pressedImage")]
		private var RadioButton_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="RadioButton_selectedImage")]
		private var RadioButton_pressedSelectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="RadioButton_disabledImage")]
		private var RadioButton_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="RadioButton_selectedImage")]
		private var RadioButton_selectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="RadioButton_disabledSelectedImage")]
		private var RadioButton_disabledSelectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="RadioButton_rolloverImage")]
		private var RadioButton_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="RadioButton_rolloverSelectedImage")]
		private var RadioButton_rolloverSelectedImage:Class;
		
		// JCheckBox
		[Embed(source="assets/chrome.swf", symbol="CheckBox_defaultImage")]
		private var CheckBox_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="CheckBox_pressedImage")]
		private var CheckBox_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="CheckBox_selectedImage")]
		private var CheckBox_pressedSelectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="CheckBox_disabledImage")]
		private var CheckBox_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="CheckBox_selectedImage")]
		private var CheckBox_selectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="CheckBox_disabledSelectedImage")]
		private var CheckBox_disabledSelectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="CheckBox_rolloverImage")]
		private var CheckBox_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="CheckBox_rolloverSelectedImage")]
		private var CheckBox_rolloverSelectedImage:Class;

		// JScrollBar
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowLeft_defaultImage")]
		private var ScrollBar_arrowLeft_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowLeft_defaultImage")]
		private var ScrollBar_arrowLeft_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowLeft_disabledImage")]
		private var ScrollBar_arrowLeft_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowLeft_rolloverImage")]
		private var ScrollBar_arrowLeft_rolloverImage:Class;
		
		//========= Right Arrow Images =======
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowRight_defaultImage")]
		private var ScrollBar_arrowRight_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowRight_defaultImage")]
		private var ScrollBar_arrowRight_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowRight_disabledImage")]
		private var ScrollBar_arrowRight_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowRight_rolloverImage")]
		private var ScrollBar_arrowRight_rolloverImage:Class;
		
		//========= Up Arrow Images =======
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowUp_defaultImage")]
		private var ScrollBar_arrowUp_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowUp_defaultImage")]
		private var ScrollBar_arrowUp_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowUp_disabledImage")]
		private var ScrollBar_arrowUp_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowUp_rolloverImage")]
		private var ScrollBar_arrowUp_rolloverImage:Class;
		
		//========= Down Arrow Images =======
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowDown_defaultImage")]
		private var ScrollBar_arrowDown_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowDown_defaultImage")]
		private var ScrollBar_arrowDown_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowDown_disabledImage")]
		private var ScrollBar_arrowDown_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_arrowDown_rolloverImage")]
		private var ScrollBar_arrowDown_rolloverImage:Class;
		
		//JScrollBar背景
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_verticalBGImage")]
		private var ScrollBar_verticalBGImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_horizotalBGImage")]
		private var ScrollBar_horizotalBGImage:Class;
		
		// JScrollBar滑块
		//vertical
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbVertical_defaultImage")]
		private var ScrollBar_thumbVertical_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbVertical_rolloverImage")]
		private var ScrollBar_thumbVertical_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbVertical_rolloverImage")]
		private var ScrollBar_thumbVertical_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbVertical_disabledImage")]
		private var ScrollBar_thumbVertical_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbVertical_iconImage")]
		private var ScrollBar_thumbVertical_iconImage:Class;
		
		//horizontal
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbHorizontal_defaultImage")]
		private var ScrollBar_thumbHorizontal_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbHorizontal_rolloverImage")]
		private var ScrollBar_thumbHorizontal_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbHorizontal_rolloverImage")]
		private var ScrollBar_thumbHorizontal_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbHorizontal_disabledImage")]
		private var ScrollBar_thumbHorizontal_disabledImage:Class;
	
		[Embed(source="assets/chrome.swf", symbol="ScrollBar_thumbHorizontal_iconImage")]
		private var ScrollBar_thumbHorizontal_iconImage:Class;
		
		// JTextField
		[Embed(source="assets/chrome.swf", symbol="TextField_defaultImage")]
		private var TextField_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TextField_uneditableImage")]
		private var TextField_uneditableImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TextField_disabledImage")]
		private var TextField_disabledImage:Class;
		
		
		// JTextArea 其实等同于 JTextField
		[Embed(source="assets/chrome.swf", symbol="TextField_defaultImage")]
		private var TextArea_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TextField_uneditableImage")]
		private var TextArea_uneditableImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TextField_disabledImage")]
		private var TextArea_disabledImage:Class;
		
		// JFrame
		//Backgorund
		[Embed(source="assets/chrome.swf", symbol="Frame_activeBG")]
		private var Frame_activeBG:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_inactiveBG")]
		private var Frame_inactiveBG:Class;

		//========= Frame_iconifiedIcon Images =======
		[Embed(source="assets/chrome.swf", symbol="Frame_iconifiedIcon_defaultImage")]
		private var Frame_iconifiedIcon_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_iconifiedIcon_pressedImage")]
		private var Frame_iconifiedIcon_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_iconifiedIcon_defaultImage")]
		private var Frame_iconifiedIcon_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_iconifiedIcon_rolloverImage")]
		private var Frame_iconifiedIcon_rolloverImage:Class;
		
		//========= Frame_normalIcon Images =======
		[Embed(source="assets/chrome.swf", symbol="Frame_normalIcon_defaultImage")]	
		private var Frame_normalIcon_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_normalIcon_pressedImage")]
		private var Frame_normalIcon_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_normalIcon_defaultImage")]
		private var Frame_normalIcon_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_normalIcon_rolloverImage")]
		private var Frame_normalIcon_rolloverImage:Class;
		
		//========= Frame_maximizeIcon Images =======
		[Embed(source="assets/chrome.swf", symbol="Frame_maximizeIcon_defaultImage")]
		private var Frame_maximizeIcon_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_maximizeIcon_pressedImage")]
		private var Frame_maximizeIcon_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_maximizeIcon_defaultImage")]
		private var Frame_maximizeIcon_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_maximizeIcon_rolloverImage")]
		private var Frame_maximizeIcon_rolloverImage:Class;
		
		//========= Down Arrow Images =======
		[Embed(source="assets/chrome.swf", symbol="Frame_closeIcon_defaultImage")]
		private var Frame_closeIcon_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_closeIcon_pressedImage")]
		private var Frame_closeIcon_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_closeIcon_defaultImage")]
		private var Frame_closeIcon_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Frame_closeIcon_rolloverImage")]
		private var Frame_closeIcon_rolloverImage:Class;
		
		// JToolTip
		[Embed(source="assets/chrome.swf", symbol="ToolTip_bgImage")]
		private var ToolTip_bgImage:Class;
		
		// JComboBox
		//========= BG Images =======
		[Embed(source="assets/chrome.swf", symbol="ComboBox_defaultImage")]
		private var ComboBox_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_defaultRolloverImage")]
		private var ComboBox_defaultRolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_defaultPressedImage")]
		private var ComboBox_defaultPressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_uneditableImage")]
		private var ComboBox_uneditableImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_uneditableRolloverImage")]
		private var ComboBox_uneditableRolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_uneditablePressedImage")]
		private var ComboBox_uneditablePressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_disabledImage")]
		private var ComboBox_disabledImage:Class;
		
		//========= Arrow Button Images =======
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_defaultImage")]
		private var ComboBox_arrowButton_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_pressedImage")]
		private var ComboBox_arrowButton_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_disabledImage")]
		private var ComboBox_arrowButton_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_rolloverImage")]
		private var ComboBox_arrowButton_rolloverImage:Class;
		
		// JAccordion
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_defaultImage")]
		private var Accordion_header_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_pressedImage")]
		private var Accordion_header_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_rolloverImage")]
		private var Accordion_header_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_disabledImage")]
		private var Accordion_header_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ToggleButton_pressedImage")]
		private var Accordion_header_selectedImage:Class;
		
		// JTabbedPane
		//========= header top scale-9 =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_top_tab_defaultImage")]
		private var TabbedPane_top_tab_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_top_tab_defaultImage")]
		private var TabbedPane_top_tab_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_top_tab_rolloverImage")]
		private var TabbedPane_top_tab_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_top_tab_disabledImage")]
		private var TabbedPane_top_tab_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_top_tab_selectedImage")]
		private var TabbedPane_top_tab_selectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_top_tab_selectedImage")]
		private var TabbedPane_top_tab_rolloverSelectedImage:Class;
		
		//========= header bottom scale-9 =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_bottom_tab_defaultImage")]
		private var TabbedPane_bottom_tab_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_bottom_tab_defaultImage")]
		private var TabbedPane_bottom_tab_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_bottom_tab_rolloverImage")]
		private var TabbedPane_bottom_tab_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_bottom_tab_disabledImage")]
		private var TabbedPane_bottom_tab_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_bottom_tab_selectedImage")]
		private var TabbedPane_bottom_tab_selectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_bottom_tab_selectedImage")]
		private var TabbedPane_bottom_tab_rolloverSelectedImage:Class;
		
		//========= header left scale-9 =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_left_tab_defaultImage")]
		private var TabbedPane_left_tab_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_left_tab_defaultImage")]
		private var TabbedPane_left_tab_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_left_tab_rolloverImage")]
		private var TabbedPane_left_tab_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_left_tab_disabledImage")]
		private var TabbedPane_left_tab_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_left_tab_selectedImage")]
		private var TabbedPane_left_tab_selectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_left_tab_selectedImage")]
		private var TabbedPane_left_tab_rolloverSelectedImage:Class;
		
		//========= header right scale-9 =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_right_tab_defaultImage")]
		private var TabbedPane_right_tab_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_right_tab_defaultImage")]
		private var TabbedPane_right_tab_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_right_tab_rolloverImage")]
		private var TabbedPane_right_tab_rolloverImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_right_tab_disabledImage")]
		private var TabbedPane_right_tab_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_right_tab_selectedImage")]
		private var TabbedPane_right_tab_selectedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_right_tab_selectedImage")]
		private var TabbedPane_right_tab_rolloverSelectedImage:Class;
		
		//========= Background Image scale-9 =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_top_contentRoundImage")]
		private var TabbedPane_top_contentRoundImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_bottom_contentRoundImage")]
		private var TabbedPane_bottom_contentRoundImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_left_contentRoundImage")]
		private var TabbedPane_left_contentRoundImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_right_contentRoundImage")]
		private var TabbedPane_right_contentRoundImage:Class;
		
		//========= Left Arrow Images =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowLeft_defaultImage")]
		private var TabbedPane_arrowLeft_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowLeft_defaultImage")]
		private var TabbedPane_arrowLeft_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowLeft_disabledImage")]
		private var TabbedPane_arrowLeft_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowLeft_rolloverImage")]
		private var TabbedPane_arrowLeft_rolloverImage:Class;
		
		//========= Right Arrow Images =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowRight_defaultImage")]
		private var TabbedPane_arrowRight_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowRight_defaultImage")]
		private var TabbedPane_arrowRight_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowRight_disabledImage")]
		private var TabbedPane_arrowRight_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_arrowRight_rolloverImage")]
		private var TabbedPane_arrowRight_rolloverImage:Class;
		
		//========= Close Button Images =======
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_closeButton_defaultImage")]
		private var TabbedPane_closeButton_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_closeButton_pressedImage")]
		private var TabbedPane_closeButton_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_closeButton_disabledImage")]
		private var TabbedPane_closeButton_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TabbedPane_closeButton_rolloverImage")]
		private var TabbedPane_closeButton_rolloverImage:Class;
		
		// JSlider
		//========= track scale-9 or not=======
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackImage")]
		private var Slider_vertical_trackImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackDisabledImage")]
		private var Slider_vertical_trackDisabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackProgressImage")]
		private var Slider_vertical_trackProgressImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackProgressDisabledImage")]
		private var Slider_vertical_trackProgressDisabledImage:Class;
		
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackImage")]
		private var Slider_horizontal_trackImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackDisabledImage")]
		private var Slider_horizontal_trackDisabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackProgressImage")]
		private var Slider_horizontal_trackProgressImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackProgressDisabledImage")]
		private var Slider_horizontal_trackProgressDisabledImage:Class;
		
		//========= Thumb Images =======
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_defaultImage")]
		private var Slider_thumbHorizontal_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_pressedImage")]
		private var Slider_thumbHorizontal_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_disabledImage")]
		private var Slider_thumbHorizontal_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_rolloverImage")]
		private var Slider_thumbHorizontal_rolloverImage:Class;
		
/* 		[Embed(source="assets/chrome.swf", symbol="Slider_thumbVertical_defaultImage")]
		private var Slider_thumbVertical_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbVertical_pressedImage")]
		private var Slider_thumbVertical_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbVertical_disabledImage")]
		private var Slider_thumbVertical_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbVertical_rolloverImage")]
		private var Slider_thumbVertical_rolloverImage:Class; */
		
		// JProgressBar __________________________
		//========= Background Images scale-9 or not ======= 
		[Embed(source="assets/chrome.swf", symbol="ProgressBar_verticalBGImage")]
		private var ProgressBar_verticalBGImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ProgressBar_horizotalBGImage")]
		private var ProgressBar_horizotalBGImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ProgressBar_verticalFGImage")]
		private var ProgressBar_verticalFGImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ProgressBar_horizotalFGImage")]
		private var ProgressBar_horizotalFGImage:Class;
		
		// JAdjuster
		//========= Arrow Images =======
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_defaultImage")]
		private var Adjuster_arrowButton_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_pressedImage")]
		private var Adjuster_arrowButton_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_disabledImage")]
		private var Adjuster_arrowButton_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="ComboBox_arrowButton_rolloverImage")]
		private var Adjuster_arrowButton_rolloverImage:Class;
		
		//========= Track scale-9 or not =======
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackImage")]
		private var Adjuster_Slider_vertical_trackImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackDisabledImage")]
		private var Adjuster_Slider_vertical_trackDisabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackProgressImage")]
		private var Adjuster_Slider_vertical_trackProgressImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_vertical_trackProgressDisabledImage")]
		private var Adjuster_Slider_vertical_trackProgressDisabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackImage")]
		private var Adjuster_Slider_horizontal_trackImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackDisabledImage")]
		private var Adjuster_Slider_horizontal_trackDisabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackProgressImage")]
		private var Adjuster_Slider_horizontal_trackProgressImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_horizontal_trackProgressDisabledImage")]
		private var Adjuster_Slider_horizontal_trackProgressDisabledImage:Class;
		
		//========= Thumb Images =======
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_defaultImage")]
		private var Adjuster_Slider_thumbHorizontal_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_pressedImage")]
		private var Adjuster_Slider_thumbHorizontal_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_disabledImage")]
		private var Adjuster_Slider_thumbHorizontal_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_rolloverImage")]
		private var Adjuster_Slider_thumbHorizontal_rolloverImage:Class;
		
	  	[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_defaultImage")]
		private var Adjuster_Slider_thumbVertical_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_pressedImage")]
		private var Adjuster_Slider_thumbVertical_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_disabledImage")]
		private var Adjuster_Slider_thumbVertical_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Slider_thumbHorizontal_rolloverImage")]
		private var Adjuster_Slider_thumbVertical_rolloverImage:Class;
		
		
		// JTree
		//========= Icon Images =======
		[Embed(source="assets/chrome.swf", symbol="Tree_leafImage")]
		private var Tree_leafImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Tree_folderExpandedImage")]
		private var Tree_folderExpandedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Tree_folderCollapsedImage")]
		private var Tree_folderCollapsedImage:Class;
		
		//========= Control Images =======
		[Embed(source="assets/chrome.swf", symbol="Tree_leafControlImage")]
		private var Tree_leafControlImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Tree_folderExpandedControlImage")]
		private var Tree_folderExpandedControlImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="Tree_folderCollapsedControlImage")]
		private var Tree_folderCollapsedControlImage:Class;
		
		// JSplitPane
		//========= Background Images scale-9 ======= 
		[Embed(source="assets/chrome.swf", symbol="SplitPane_divider_verticalBGImage")]
		private var SplitPane_divider_verticalBGImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="SplitPane_divider_horizotalBGImage")]
		private var SplitPane_divider_horizotalBGImage:Class;
		
		// JTable
		[Embed(source="assets/chrome.swf", symbol="TableHeader_cell_defaultImage")]
		private var TableHeader_cell_defaultImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TableHeader_cell_defaultImage")]
		private var TableHeader_cell_pressedImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TableHeader_cell_disabledImage")]
		private var TableHeader_cell_disabledImage:Class;
		
		[Embed(source="assets/chrome.swf", symbol="TableHeader_cell_rolloverImage")]
		private var TableHeader_cell_rolloverImage:Class;
	
		/**
		 * UI组件属性设置。
		 *  
		 * @param table
		 * 
		 */		
		override protected function initComponentDefaults(table : UIDefaults) : void {
			super.initComponentDefaults(table);
			// JButton
			var comDefaults:Array = [
				"Button.opaque", false, 
				"Button.defaultImage", Button_defaultImage,
				"Button.pressedImage", Button_pressedImage,
				"Button.disabledImage", Button_disabledImage,
				"Button.rolloverImage", Button_rolloverImage, 
				"Button.DefaultButton.defaultImage", Button_DefaultButton_defaultImage, 
				"Button.bg", SkinButtonBackground,
				//"Button.font", table.getFont("font12Bold"),
				"Button.margin", new InsetsUIResource(2, 10, 2, 10), //文字周围的空间
				"Button.textShiftOffset", 0 //鼠标点击时偏移
			];
			table.putDefaults(comDefaults);
			
			// JToggleButton
			comDefaults = [
				"ToggleButton.opaque", false, 
				"ToggleButton.defaultImage", ToggleButton_defaultImage,
				"ToggleButton.pressedImage", ToggleButton_pressedImage,
				"ToggleButton.disabledImage", ToggleButton_disabledImage,
				"ToggleButton.selectedImage", ToggleButton_selectedImage,
				"ToggleButton.disabledSelectedImage", ToggleButton_disabledSelectedImage,
				"ToggleButton.rolloverImage", ToggleButton_rolloverImage,
				"ToggleButton.rolloverSelectedImage", ToggleButton_rolloverSelectedImage,
				"ToggleButton.bg", SkinToggleButtonBackground,
				//"ToggleButton.font", table.getFont("font12Bold"),
				"ToggleButton.margin", table.getInsets("Button.margin"), //modify this to fit the image border margin
			];
			table.putDefaults(comDefaults);
			
			// JRadioButton
			comDefaults = [
				"RadioButton.icon", SkinRadioButtonIcon,
				"RadioButton.defaultImage", RadioButton_defaultImage,
				"RadioButton.pressedImage", RadioButton_pressedImage,
				"RadioButton.pressedSelectedImage", RadioButton_pressedSelectedImage,
				"RadioButton.disabledImage", RadioButton_disabledImage,
				"RadioButton.selectedImage", RadioButton_selectedImage,
				"RadioButton.disabledSelectedImage", RadioButton_disabledSelectedImage,
				"RadioButton.rolloverImage", RadioButton_rolloverImage,
				"RadioButton.rolloverSelectedImage", RadioButton_rolloverSelectedImage,
				//"RadioButton.font", table.getFont("font12Bold"),
			];
			table.putDefaults(comDefaults);
	
			// JCheckBox
			comDefaults = [
				"CheckBox.icon", SkinCheckBoxIcon,
				"CheckBox.defaultImage", CheckBox_defaultImage,
				"CheckBox.pressedImage", CheckBox_pressedImage,
				"CheckBox.pressedSelectedImage", CheckBox_pressedSelectedImage,
				"CheckBox.disabledImage", CheckBox_disabledImage,
				"CheckBox.selectedImage", CheckBox_selectedImage,
				"CheckBox.disabledSelectedImage", CheckBox_disabledSelectedImage,
				"CheckBox.rolloverImage", CheckBox_rolloverImage,
				"CheckBox.rolloverSelectedImage", CheckBox_rolloverSelectedImage,
				//"CheckBox.font", table.getFont("font12Bold"),
			];
			table.putDefaults(comDefaults);
			
			// *** ScrollBar
			comDefaults = [
				"ScrollBar.opaque", false, 
				"ScrollBar.thumbDecorator", SkinScrollBarThumb,
				"ScrollBar.minimumThumbLength", 12, //如果滑块长度小此值，则不显示滑块
			
				"ScrollBar.bg", SkinScrollBarBackground, 
				"ScrollBar.verticalBGImage", ScrollBar_verticalBGImage, 
				"ScrollBar.horizotalBGImage", ScrollBar_horizotalBGImage, 
				
				"ScrollBar.arrowLeft.defaultImage", ScrollBar_arrowLeft_defaultImage, 
				"ScrollBar.arrowLeft.pressedImage", ScrollBar_arrowLeft_pressedImage, 
				"ScrollBar.arrowLeft.disabledImage", ScrollBar_arrowLeft_disabledImage, 
				"ScrollBar.arrowLeft.rolloverImage", ScrollBar_arrowLeft_rolloverImage, 
				
				"ScrollBar.arrowRight.defaultImage", ScrollBar_arrowRight_defaultImage, 
				"ScrollBar.arrowRight.pressedImage", ScrollBar_arrowRight_pressedImage, 
				"ScrollBar.arrowRight.disabledImage", ScrollBar_arrowRight_disabledImage, 
				"ScrollBar.arrowRight.rolloverImage", ScrollBar_arrowRight_rolloverImage, 
				
				"ScrollBar.arrowUp.defaultImage", ScrollBar_arrowUp_defaultImage, 
				"ScrollBar.arrowUp.pressedImage", ScrollBar_arrowUp_pressedImage, 
				"ScrollBar.arrowUp.disabledImage", ScrollBar_arrowUp_disabledImage, 
				"ScrollBar.arrowUp.rolloverImage", ScrollBar_arrowUp_rolloverImage, 
				
				"ScrollBar.arrowDown.defaultImage", ScrollBar_arrowDown_defaultImage, 
				"ScrollBar.arrowDown.pressedImage", ScrollBar_arrowDown_pressedImage, 
				"ScrollBar.arrowDown.disabledImage", ScrollBar_arrowDown_disabledImage, 
				"ScrollBar.arrowDown.rolloverImage", ScrollBar_arrowDown_rolloverImage, 
				
				"ScrollBar.thumbVertical.defaultImage", ScrollBar_thumbVertical_defaultImage, 
				"ScrollBar.thumbVertical.pressedImage", ScrollBar_thumbVertical_pressedImage, 
				"ScrollBar.thumbVertical.disabledImage", ScrollBar_thumbVertical_disabledImage, 
				"ScrollBar.thumbVertical.rolloverImage", ScrollBar_thumbVertical_rolloverImage, 
				"ScrollBar.thumbVertical.iconImage", ScrollBar_thumbVertical_iconImage, 
				
				"ScrollBar.thumbHorizontal.defaultImage", ScrollBar_thumbHorizontal_defaultImage, 
				"ScrollBar.thumbHorizontal.pressedImage", ScrollBar_thumbHorizontal_pressedImage, 
				"ScrollBar.thumbHorizontal.disabledImage", ScrollBar_thumbHorizontal_disabledImage, 
				"ScrollBar.thumbHorizontal.rolloverImage", ScrollBar_thumbHorizontal_rolloverImage, 
				"ScrollBar.thumbHorizontal.iconImage", ScrollBar_thumbHorizontal_iconImage
			];
			table.putDefaults(comDefaults);

			//JTableHeader
			comDefaults = [
				"TableHeader.foreground", 0xFFFFFF,
				"TableHeader.font", table.getFont("font14"),
			];
			table.putDefaults(comDefaults);
			
			//JTextField
			comDefaults = [
				"TextField.opaque", true, 
				"TextField.bg", SkinTextFieldBackground,
				"TextField.border", new SkinEmptyBorder(2, 2, 2, 2), //modify this to fit the bg image
				"TextField.defaultImage", TextField_defaultImage, 
				"TextField.uneditableImage", TextField_uneditableImage, 
				"TextField.disabledImage", TextField_disabledImage
			];
			table.putDefaults(comDefaults);
			
			//JTextArea
			comDefaults = [
				"TextArea.opaque", true, 
				"TextArea.bg", SkinTextAreaBackground,
				"TextArea.border", new SkinEmptyBorder(2, 2, 2, 2), //modify this to fit the bg image
				"TextArea.defaultImage", TextArea_defaultImage, 
				"TextArea.uneditableImage", TextArea_uneditableImage, 
				"TextArea.disabledImage", TextArea_disabledImage
			];
			table.putDefaults(comDefaults);
			
			//JFrame
			comDefaults = [
				"Frame.resizer", ChromeResizer,
				"Frame.background", table.get("window"), 
				"Frame.foreground", table.get("windowText"),
				"Frame.opaque", true, 
				"Frame.font", table.get("frameFont"),
				"Frame.titleBarHeight", 34, //modify this to fit title bar height of bg image
				"Frame.border", new SkinEmptyBorder(2, 7, 7, 7), //Frame的边框。
				//增大高度,contentPane向下移动，TitleBar也会下移，Frame的背景下移
				//titleBarHeight+border.Height，就是contentPan的x。
				"Frame.backgroundMargin", new InsetsUIResource(34, 0, 0, 0), //背景的外间距。
				//增大高度,Frame的背景下移
				//border.Height+backgroundMargin.Height就是Frame背景的x。
				"Frame.bg", SkinFrameBackground, //this will use Frame.activeBG and Frame.inactiveBG
				"Frame.activeBG", Frame_activeBG, 
				"Frame.inactiveBG", Frame_inactiveBG, 
				"Frame.titleBarBG", SkinFrameTitleBarBG, 
				"Frame.titleBarButtonGap", 2, 
				"Frame.titleBarOpaque", false,
				"Frame.dragDirectly", true, 
				"Frame.icon", null,
				"Frame.iconifiedIcon", SkinFrameIconifiedIcon,
				"Frame.normalIcon", SkinFrameNormalIcon,
				"Frame.maximizeIcon", SkinFrameMaximizeIcon, 
				"Frame.closeIcon", SkinFrameCloseIcon, 
				
				"Frame.iconifiedIcon.defaultImage", Frame_iconifiedIcon_defaultImage, 
				"Frame.iconifiedIcon.pressedImage", Frame_iconifiedIcon_pressedImage, 
				"Frame.iconifiedIcon.disabledImage", Frame_iconifiedIcon_disabledImage, 
				"Frame.iconifiedIcon.rolloverImage", Frame_iconifiedIcon_rolloverImage, 
				
				"Frame.normalIcon.defaultImage", Frame_normalIcon_defaultImage, 
				"Frame.normalIcon.pressedImage", Frame_normalIcon_pressedImage, 
				"Frame.normalIcon.disabledImage", Frame_normalIcon_disabledImage, 
				"Frame.normalIcon.rolloverImage", Frame_normalIcon_rolloverImage, 
				
				"Frame.maximizeIcon.defaultImage", Frame_maximizeIcon_defaultImage, 
				"Frame.maximizeIcon.pressedImage", Frame_maximizeIcon_pressedImage, 
				"Frame.maximizeIcon.disabledImage", Frame_maximizeIcon_disabledImage, 
				"Frame.maximizeIcon.rolloverImage", Frame_maximizeIcon_rolloverImage,
				
				"Frame.closeIcon.defaultImage", Frame_closeIcon_defaultImage, 
				"Frame.closeIcon.pressedImage", Frame_closeIcon_pressedImage, 
				"Frame.closeIcon.disabledImage", Frame_closeIcon_disabledImage, 
				"Frame.closeIcon.rolloverImage", Frame_closeIcon_rolloverImage
			];
			table.putDefaults(comDefaults);
			
			//JToolTip
			comDefaults = [
				"ToolTip.opaque", false, 
				"ToolTip.bg", SkinToolTipBackground, 
				"ToolTip.bgImage", ToolTip_bgImage, 
				"ToolTip.border", new SkinEmptyBorder(2, 4, 2, 4), //modify this to fit the bg image
				"ToolTip.filters", [new DropShadowFilter(4.0, 45, 0, 1.0, 2.0, 2.0, 0.2)], 
			];
			table.putDefaults(comDefaults);
			
			//JComboBox
			comDefaults = [
				"ComboBox.opaque", false, 
				"ComboBox.bg", SkinComboBoxBackground,
				"ComboBox.border", new SkinEmptyBorder(2, 2, 2, 2), //modify this to fit the bg image
				"ComboBox.popupBorder", ChromeComboBoxPopupBorder, 
				"ComboBox.defaultImage", ComboBox_defaultImage, 
				"ComboBox.defaultRolloverImage", ComboBox_defaultRolloverImage, 
				"ComboBox.defaultPressedImage", ComboBox_defaultPressedImage, 
				"ComboBox.uneditableImage", ComboBox_uneditableImage, 
				"ComboBox.uneditableRolloverImage", ComboBox_uneditableRolloverImage, 
				"ComboBox.uneditablePressedImage", ComboBox_uneditablePressedImage, 
				"ComboBox.disabledImage", ComboBox_disabledImage, 
				"ComboBox.arrowButton.defaultImage", ComboBox_arrowButton_defaultImage,
				"ComboBox.arrowButton.rolloverImage", ComboBox_arrowButton_rolloverImage,
				"ComboBox.arrowButton.pressedImage", ComboBox_arrowButton_pressedImage,
				"ComboBox.arrowButton.disabledImage", ComboBox_arrowButton_disabledImage,
			];
			table.putDefaults(comDefaults);
			
			//JAccordion
			comDefaults = [
				"Accordion.header", SkinAccordionHeader, 
				"Accordion.font", table.get("font14"),
				"Accordion.motionSpeed", 100, 
				"Accordion.tabMargin", new InsetsUIResource(2, 10, 2, 10),  //modify this to fit header image
				"Accordion.header.defaultImage", Accordion_header_defaultImage,
				"Accordion.header.pressedImage", Accordion_header_pressedImage,
				"Accordion.header.disabledImage", Accordion_header_disabledImage,
				"Accordion.header.rolloverImage", Accordion_header_rolloverImage, 
				"Accordion.header.selectedImage", Accordion_header_selectedImage
			];
			table.putDefaults(comDefaults);
			
			//JTabbedPane
			comDefaults = [
				"TabbedPane.tab", SkinTabbedPaneTab, 
				"TabbedPane.tabMargin", new InsetsUIResource(2, 10, 2, 10),  //modify this to fit header image
				"TabbedPane.tabBorderInsets", new InsetsUIResource(0, 0, 0, 0),
				"TabbedPane.selectedTabExpandInsets", new InsetsUIResource(0, 0, 0, 0), 
				"TabbedPane.top.tab.defaultImage", TabbedPane_top_tab_defaultImage,
				"TabbedPane.top.tab.pressedImage", TabbedPane_top_tab_pressedImage,
				"TabbedPane.top.tab.disabledImage", TabbedPane_top_tab_disabledImage,
				"TabbedPane.top.tab.rolloverImage", TabbedPane_top_tab_rolloverImage, 
				"TabbedPane.top.tab.selectedImage", TabbedPane_top_tab_selectedImage, 
				"TabbedPane.top.tab.rolloverSelectedImage", TabbedPane_top_tab_rolloverSelectedImage, 
				
				"TabbedPane.bottom.tab.defaultImage", TabbedPane_bottom_tab_defaultImage,
				"TabbedPane.bottom.tab.pressedImage", TabbedPane_bottom_tab_pressedImage,
				"TabbedPane.bottom.tab.disabledImage", TabbedPane_bottom_tab_disabledImage,
				"TabbedPane.bottom.tab.rolloverImage", TabbedPane_bottom_tab_rolloverImage, 
				"TabbedPane.bottom.tab.selectedImage", TabbedPane_bottom_tab_selectedImage, 
				"TabbedPane.bottom.tab.rolloverSelectedImage", TabbedPane_bottom_tab_rolloverSelectedImage, 
				
				"TabbedPane.left.tab.defaultImage", TabbedPane_left_tab_defaultImage,
				"TabbedPane.left.tab.pressedImage", TabbedPane_left_tab_pressedImage,
				"TabbedPane.left.tab.disabledImage", TabbedPane_left_tab_disabledImage,
				"TabbedPane.left.tab.rolloverImage", TabbedPane_left_tab_rolloverImage, 
				"TabbedPane.left.tab.selectedImage", TabbedPane_left_tab_selectedImage, 
				"TabbedPane.left.tab.rolloverSelectedImage", TabbedPane_left_tab_rolloverSelectedImage, 
				
				"TabbedPane.right.tab.defaultImage", TabbedPane_right_tab_defaultImage,
				"TabbedPane.right.tab.pressedImage", TabbedPane_right_tab_pressedImage,
				"TabbedPane.right.tab.disabledImage", TabbedPane_right_tab_disabledImage,
				"TabbedPane.right.tab.rolloverImage", TabbedPane_right_tab_rolloverImage, 
				"TabbedPane.right.tab.selectedImage", TabbedPane_right_tab_selectedImage, 
				"TabbedPane.right.tab.rolloverSelectedImage", TabbedPane_right_tab_rolloverSelectedImage,  
				
				"TabbedPane.arrowLeft.defaultImage", TabbedPane_arrowLeft_defaultImage, 
				"TabbedPane.arrowLeft.pressedImage", TabbedPane_arrowLeft_pressedImage, 
				"TabbedPane.arrowLeft.disabledImage", TabbedPane_arrowLeft_disabledImage, 
				"TabbedPane.arrowLeft.rolloverImage", TabbedPane_arrowLeft_rolloverImage, 
				
				"TabbedPane.arrowRight.defaultImage", TabbedPane_arrowRight_defaultImage, 
				"TabbedPane.arrowRight.pressedImage", TabbedPane_arrowRight_pressedImage, 
				"TabbedPane.arrowRight.disabledImage", TabbedPane_arrowRight_disabledImage, 
				"TabbedPane.arrowRight.rolloverImage", TabbedPane_arrowRight_rolloverImage, 
				
				"TabbedPane.contentMargin", new InsetsUIResource(10, 10, 10, 10), //modify this to fit TabbedPane_contentRoundImage
				"TabbedPane.top.contentRoundImage", TabbedPane_top_contentRoundImage, 
				"TabbedPane.bottom.contentRoundImage", TabbedPane_bottom_contentRoundImage, 
				"TabbedPane.left.contentRoundImage", TabbedPane_left_contentRoundImage, 
				"TabbedPane.right.contentRoundImage", TabbedPane_right_contentRoundImage, 
				"TabbedPane.contentRoundLineThickness", 1, //modify this to fit contentRoundImage
				"TabbedPane.bg", null //bg is managed by SkinTabbedPaneUI
			];
			table.putDefaults(comDefaults);
			
			//JClosableTabbedPane
			comDefaults = [
				"ClosableTabbedPane.tab", ChromeClosableTabbedPaneTab, 
				"ClosableTabbedPane.tabMargin", new InsetsUIResource(2, 10, 2, 5),  //modify this to fit header image
				"ClosableTabbedPane.tabBorderInsets", new InsetsUIResource(0, 0, 0, 0),
				"ClosableTabbedPane.selectedTabExpandInsets", new InsetsUIResource(0, 0, 0, 0), 
				"ClosableTabbedPane.top.tab.defaultImage", TabbedPane_top_tab_defaultImage,
				"ClosableTabbedPane.top.tab.pressedImage", TabbedPane_top_tab_pressedImage,
				"ClosableTabbedPane.top.tab.disabledImage", TabbedPane_top_tab_disabledImage,
				"ClosableTabbedPane.top.tab.rolloverImage", TabbedPane_top_tab_rolloverImage, 
				"ClosableTabbedPane.top.tab.selectedImage", TabbedPane_top_tab_selectedImage, 
				"ClosableTabbedPane.top.tab.rolloverSelectedImage", TabbedPane_top_tab_rolloverSelectedImage, 
				
				"ClosableTabbedPane.bottom.tab.defaultImage", TabbedPane_bottom_tab_defaultImage,
				"ClosableTabbedPane.bottom.tab.pressedImage", TabbedPane_bottom_tab_pressedImage,
				"ClosableTabbedPane.bottom.tab.disabledImage", TabbedPane_bottom_tab_disabledImage,
				"ClosableTabbedPane.bottom.tab.rolloverImage", TabbedPane_bottom_tab_rolloverImage, 
				"ClosableTabbedPane.bottom.tab.selectedImage", TabbedPane_bottom_tab_selectedImage, 
				"ClosableTabbedPane.bottom.tab.rolloverSelectedImage", TabbedPane_bottom_tab_rolloverSelectedImage, 
				
				"ClosableTabbedPane.left.tab.defaultImage", TabbedPane_left_tab_defaultImage,
				"ClosableTabbedPane.left.tab.pressedImage", TabbedPane_left_tab_pressedImage,
				"ClosableTabbedPane.left.tab.disabledImage", TabbedPane_left_tab_disabledImage,
				"ClosableTabbedPane.left.tab.rolloverImage", TabbedPane_left_tab_rolloverImage, 
				"ClosableTabbedPane.left.tab.selectedImage", TabbedPane_left_tab_selectedImage, 
				"ClosableTabbedPane.left.tab.rolloverSelectedImage", TabbedPane_left_tab_rolloverSelectedImage, 
				
				"ClosableTabbedPane.right.tab.defaultImage", TabbedPane_right_tab_defaultImage,
				"ClosableTabbedPane.right.tab.pressedImage", TabbedPane_right_tab_pressedImage,
				"ClosableTabbedPane.right.tab.disabledImage", TabbedPane_right_tab_disabledImage,
				"ClosableTabbedPane.right.tab.rolloverImage", TabbedPane_right_tab_rolloverImage, 
				"ClosableTabbedPane.right.tab.selectedImage", TabbedPane_right_tab_selectedImage, 
				"ClosableTabbedPane.right.tab.rolloverSelectedImage", TabbedPane_right_tab_rolloverSelectedImage,  
				
				"ClosableTabbedPane.arrowLeft.defaultImage", TabbedPane_arrowLeft_defaultImage, 
				"ClosableTabbedPane.arrowLeft.pressedImage", TabbedPane_arrowLeft_pressedImage, 
				"ClosableTabbedPane.arrowLeft.disabledImage", TabbedPane_arrowLeft_disabledImage, 
				"ClosableTabbedPane.arrowLeft.rolloverImage", TabbedPane_arrowLeft_rolloverImage, 
				
				"ClosableTabbedPane.arrowRight.defaultImage", TabbedPane_arrowRight_defaultImage, 
				"ClosableTabbedPane.arrowRight.pressedImage", TabbedPane_arrowRight_pressedImage, 
				"ClosableTabbedPane.arrowRight.disabledImage", TabbedPane_arrowRight_disabledImage, 
				"ClosableTabbedPane.arrowRight.rolloverImage", TabbedPane_arrowRight_rolloverImage, 
				
				"ClosableTabbedPane.closeButton.defaultImage", TabbedPane_closeButton_defaultImage, 
				"ClosableTabbedPane.closeButton.pressedImage", TabbedPane_closeButton_pressedImage, 
				"ClosableTabbedPane.closeButton.disabledImage", TabbedPane_closeButton_disabledImage, 
				"ClosableTabbedPane.closeButton.rolloverImage", TabbedPane_closeButton_rolloverImage,
				
				"ClosableTabbedPane.contentMargin", new InsetsUIResource(10, 10, 10, 10), //modify this to fit TabbedPane_contentRoundImage
				"ClosableTabbedPane.top.contentRoundImage", TabbedPane_top_contentRoundImage, 
				"ClosableTabbedPane.bottom.contentRoundImage", TabbedPane_bottom_contentRoundImage, 
				"ClosableTabbedPane.left.contentRoundImage", TabbedPane_left_contentRoundImage, 
				"ClosableTabbedPane.right.contentRoundImage", TabbedPane_right_contentRoundImage, 
				"ClosableTabbedPane.contentRoundLineThickness", 1, //modify this to fit contentRoundImage
				"ClosableTabbedPane.closeButtonGap", 5, //关闭按钮与文字的间隔
				"ClosableTabbedPane.bg", null //bg is managed by SkinTabbedPaneUI
			];
			table.putDefaults(comDefaults);
			
			//JSlider
			comDefaults = [
				"Slider.vertical.trackImage", Slider_vertical_trackImage,
				"Slider.vertical.trackDisabledImage", Slider_vertical_trackDisabledImage,
				"Slider.vertical.trackProgressImage", Slider_vertical_trackProgressImage,
				"Slider.vertical.trackProgressDisabledImage", Slider_vertical_trackProgressDisabledImage,
				
				"Slider.horizontal.trackImage", Slider_horizontal_trackImage,
				"Slider.horizontal.trackDisabledImage", Slider_horizontal_trackDisabledImage,
				"Slider.horizontal.trackProgressImage", Slider_horizontal_trackProgressImage,
				"Slider.horizontal.trackProgressDisabledImage", Slider_horizontal_trackProgressDisabledImage,
				
				"Slider.thumbVertical.defaultImage", Slider_thumbHorizontal_defaultImage,
				"Slider.thumbVertical.pressedImage", Slider_thumbHorizontal_pressedImage,
				"Slider.thumbVertical.disabledImage", Slider_thumbHorizontal_disabledImage,
				"Slider.thumbVertical.rolloverImage", Slider_thumbHorizontal_rolloverImage,
				
				"Slider.thumbHorizontal.defaultImage", Slider_thumbHorizontal_defaultImage,
				"Slider.thumbHorizontal.pressedImage", Slider_thumbHorizontal_pressedImage,
				"Slider.thumbHorizontal.disabledImage", Slider_thumbHorizontal_disabledImage,
				"Slider.thumbHorizontal.rolloverImage", Slider_thumbHorizontal_rolloverImage,
				
				"Slider.thumbIcon", SkinSliderThumb,
			];
			table.putDefaults(comDefaults);
			
			//JProgressBar
			comDefaults = [
				"ProgressBar.border", null, 
				"ProgressBar.foreground", table.get("controlText"),
				"ProgressBar.bg", SkinProgressBarBackground, 
				"ProgressBar.fg", SkinProgressBarForeground,
				"ProgressBar.fgMargin", new InsetsUIResource(2, 2, 2, 2), //modify this to margin fg
				"ProgressBar.verticalBGImage", ProgressBar_verticalBGImage, 
				"ProgressBar.horizotalBGImage", ProgressBar_horizotalBGImage, 
				"ProgressBar.verticalFGImage", ProgressBar_verticalFGImage, 
				"ProgressBar.horizotalFGImage", ProgressBar_horizotalFGImage
			];
			table.putDefaults(comDefaults);
			
			
			//JAdjuster
			comDefaults = [
				"Adjuster.arrowButton.defaultImage", Adjuster_arrowButton_defaultImage, 
				"Adjuster.arrowButton.pressedImage", Adjuster_arrowButton_pressedImage, 
				"Adjuster.arrowButton.disabledImage", Adjuster_arrowButton_disabledImage, 
				"Adjuster.arrowButton.rolloverImage", Adjuster_arrowButton_rolloverImage, 
				
				"Adjuster.Slider.vertical.trackImage", Adjuster_Slider_vertical_trackImage,
				"Adjuster.Slider.vertical.trackDisabledImage", Adjuster_Slider_vertical_trackDisabledImage,
				"Adjuster.Slider.vertical.trackProgressImage", Adjuster_Slider_vertical_trackProgressImage,
				"Adjuster.Slider.vertical.trackProgressDisabledImage", Adjuster_Slider_vertical_trackProgressDisabledImage,
				
				"Adjuster.Slider.horizontal.trackImage", Adjuster_Slider_horizontal_trackImage,
				"Adjuster.Slider.horizontal.trackDisabledImage", Adjuster_Slider_horizontal_trackDisabledImage,
				"Adjuster.Slider.horizontal.trackProgressImage", Adjuster_Slider_horizontal_trackProgressImage,
				"Adjuster.Slider.horizontal.trackProgressDisabledImage", Adjuster_Slider_horizontal_trackProgressDisabledImage,
				
				"Adjuster.Slider.thumbVertical.defaultImage", Adjuster_Slider_thumbVertical_defaultImage,
				"Adjuster.Slider.thumbVertical.pressedImage", Adjuster_Slider_thumbVertical_pressedImage,
				"Adjuster.Slider.thumbVertical.disabledImage", Adjuster_Slider_thumbVertical_disabledImage,
				"Adjuster.Slider.thumbVertical.rolloverImage", Adjuster_Slider_thumbVertical_rolloverImage,
				
				"Adjuster.Slider.thumbHorizontal.defaultImage", Adjuster_Slider_thumbHorizontal_defaultImage,
				"Adjuster.Slider.thumbHorizontal.pressedImage", Adjuster_Slider_thumbHorizontal_pressedImage,
				"Adjuster.Slider.thumbHorizontal.disabledImage", Adjuster_Slider_thumbHorizontal_disabledImage,
				"Adjuster.Slider.thumbHorizontal.rolloverImage", Adjuster_Slider_thumbHorizontal_rolloverImage,
				
				"Adjuster.Slider.thumbIcon", SkinAdjusterSliderThumb, 
				
				"Adjuster.Slider.background", table.getFont("controlFont"),
				"Adjuster.Slider.foreground", table.get("controlText"),
				"Adjuster.Slider.opaque", false,  
				"Adjuster.Slider.focusable", true
			];
			table.putDefaults(comDefaults);
			
			 //JTree
			comDefaults = [
				"Tree.leafIcon", SkinTreeLeafIcon, 
				"Tree.folderExpandedIcon", SkinTreeFolderExpandedIcon, 
				"Tree.folderCollapsedIcon", SkinTreeFolderCollapsedIcon, 
				"Tree.leafImage", Tree_leafImage, 
				"Tree.folderExpandedImage", Tree_folderExpandedImage, 
				"Tree.folderCollapsedImage", Tree_folderCollapsedImage, 
				
				"Tree.leftChildIndent", 15, //modify this to fit control images width
				"Tree.rightChildIndent", 0, 
				"Tree.expandControl", SkinTreeExpandControl, 
				"Tree.leafControlImage", Tree_leafControlImage, 
				"Tree.folderExpandedControlImage", Tree_folderExpandedControlImage, 
				"Tree.folderCollapsedControlImage", Tree_folderCollapsedControlImage
			];
			table.putDefaults(comDefaults);
			
			//JSplitPane
			comDefaults = [
				"SplitPane.presentDragColor", new ASColorUIResource(0xCCCCCC, 60), 
				
				"SplitPane.defaultDividerSize", 6, //modify this to fit the divier images
				"SplitPane.divider.verticalBGImage", SplitPane_divider_verticalBGImage, 
				"SplitPane.divider.horizotalBGImage", SplitPane_divider_horizotalBGImage, 
				
/* 				"SplitPane.arrowLeft.defaultImage", SplitPane_arrowLeft_defaultImage, 
				"SplitPane.arrowLeft.pressedImage", SplitPane_arrowLeft_pressedImage, 
				"SplitPane.arrowLeft.disabledImage", SplitPane_arrowLeft_disabledImage, 
				"SplitPane.arrowLeft.rolloverImage", SplitPane_arrowLeft_rolloverImage, 
				
				"SplitPane.arrowRight.defaultImage", SplitPane_arrowRight_defaultImage, 
				"SplitPane.arrowRight.pressedImage", SplitPane_arrowRight_pressedImage, 
				"SplitPane.arrowRight.disabledImage", SplitPane_arrowRight_disabledImage, 
				"SplitPane.arrowRight.rolloverImage", SplitPane_arrowRight_rolloverImage, 
				
				"SplitPane.arrowUp.defaultImage", SplitPane_arrowUp_defaultImage, 
				"SplitPane.arrowUp.pressedImage", SplitPane_arrowUp_pressedImage, 
				"SplitPane.arrowUp.disabledImage", SplitPane_arrowUp_disabledImage, 
				"SplitPane.arrowUp.rolloverImage", SplitPane_arrowUp_rolloverImage, 
				
				"SplitPane.arrowDown.defaultImage", SplitPane_arrowDown_defaultImage, 
				"SplitPane.arrowDown.pressedImage", SplitPane_arrowDown_pressedImage, 
				"SplitPane.arrowDown.disabledImage", SplitPane_arrowDown_disabledImage, 
				"SplitPane.arrowDown.rolloverImage", SplitPane_arrowDown_rolloverImage */
			];
			table.putDefaults(comDefaults);
			
			
			// JTable
			comDefaults = [
				"Table.opaque", true, 
				"Table.focusable", true, 
				"Table.font", table.getFont("font12"),
			    "Table.selectionBackground", table.get("selectionBackground"),
			    "Table.selectionForeground", table.get("selectionForeground"), 
				"Table.gridColor", new ASColorUIResource(0xcccccc),
				"Table.border", undefined
			];
			table.putDefaults(comDefaults);
		
			//JTableHeader
			comDefaults = [
				"TableHeader.opaque", false, 
				"TableHeader.focusable", true, 
				"TableHeader.gridColor", new ASColorUIResource(0x0),
				"TableHeader.border", null, 
				"TableHeader.cellBorder", null, 
				"TableHeader.sortableCellBorder", null, 
			
				"TableHeader.cellBackground", SkinTableHeaderCellBackground,
				"TableHeader.sortableCellBackground", SkinTableHeaderSortableCellBackground, 
				"TableHeader.cell.defaultImage", TableHeader_cell_defaultImage,
				"TableHeader.cell.pressedImage", TableHeader_cell_pressedImage,
				"TableHeader.cell.disabledImage", TableHeader_cell_disabledImage,
				"TableHeader.cell.rolloverImage", TableHeader_cell_rolloverImage
			];
			table.putDefaults(comDefaults);
			
			//JToolBar
			comDefaults = [
				"ToolBar.background", table.get("window"),
				"ToolBar.foreground", table.get("windowText"),
				"ToolBar.opaque", false, 
				"ToolBar.focusable", false 
			];
			
			// *** PopupMenu
		    comDefaults = [
			    "PopupMenu.background", new ASColorUIResource(0xffffff),
		    ];
		    table.putDefaults(comDefaults);
		}
	}
}