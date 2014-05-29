package com.alvasun.laf.blue {
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
	import org.aswing.skinbuilder.SkinCheckBoxMenuItemBackground;
	import org.aswing.skinbuilder.SkinCheckBoxMenuItemCheckIcon;
	import org.aswing.skinbuilder.SkinComboBoxBackground;
	import org.aswing.skinbuilder.SkinComboBoxUI;
	import org.aswing.skinbuilder.SkinEmptyBorder;
	import org.aswing.skinbuilder.SkinFrameBackground;
	import org.aswing.skinbuilder.SkinFrameCloseIcon;
	import org.aswing.skinbuilder.SkinFrameIconifiedIcon;
	import org.aswing.skinbuilder.SkinFrameMaximizeIcon;
	import org.aswing.skinbuilder.SkinFrameNormalIcon;
	import org.aswing.skinbuilder.SkinFrameTitleBarBG;
	import org.aswing.skinbuilder.SkinMenuArrowIcon;
	import org.aswing.skinbuilder.SkinMenuBackground;
	import org.aswing.skinbuilder.SkinMenuBarBackground;
	import org.aswing.skinbuilder.SkinMenuItemBackground;
	import org.aswing.skinbuilder.SkinProgressBarBackground;
	import org.aswing.skinbuilder.SkinProgressBarForeground;
	import org.aswing.skinbuilder.SkinProgressBarUI;
	import org.aswing.skinbuilder.SkinRadioButtonIcon;
	import org.aswing.skinbuilder.SkinRadioButtonMenuItemBackground;
	import org.aswing.skinbuilder.SkinRadioButtonMenuItemCheckIcon;
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

	public class BluenessLAF extends BasicLookAndFeel 	{
		
		/**
		 * 一套Vista Blue的AsWing皮肤。基于PNG。
		 * 
		 * @author AlvaSun
		 */		
		public function BluenessLAF() {
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
				"TabbedPaneUI", BluenessTabbedPaneUI, 
				"ClosableTabbedPaneUI", BluenessCloseableTabbedPaneUI, 
				"ScrollBarUI", SkinScrollBarUI, 
				"ProgressBarUI", SkinProgressBarUI,
				"SplitPaneUI", SkinSplitPaneUI, 
 		   		"ComboBoxUI", SkinComboBoxUI,
 		   		"SliderUI", SkinSliderUI,	
			    "AdjusterUI", SkinAdjusterUI, 
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
				"menu", 0xfdfdfd,						/* 菜单背景颜色 */
				"menuText", 0x000000,					/* 菜单字体颜色 */
				//"text", 0xC0C0ff,                 	/* Text background color */
				//"textText", 0x00FF00,             	/* Text foreground color */
				//"textHighlight", 0x000080,        	/* Text background color when selected */
				"textHighlightText", 0xFFFFFF,    		/* Text color when selected */
				//"textInactiveText", 0x808080,     	/* Text color when disabled */
				"control", 0xFEFEFE,   					/* Default color for controls (buttons, sliders, etc) */
				"controlText", 0x000000,          		/* Default color for text in controls */
				//"controlHighlight", 0xEEEEEE,     	/* Specular highlight (opposite of the shadow) */
				//"controlLtHighlight", 0x666666,   	/* Highlight color for controls */
				//"controlShadow", 0xC7C7C5,        	/* Shadow color for controls */
				//"controlDkShadow", 0x666666,      	/* Dark shadow color for controls */
				//"scrollbar", 0xE0E0E0             	/* Scrollbar background (usually the "track") */
				"selectionBackground", 0xc4e2ff,
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
			var font11 : ASFontUIResource = new ASFontUIResource(fontName, 11);
			var font12 : ASFontUIResource = new ASFontUIResource(fontName, 12);
			var font12Bold : ASFontUIResource = new ASFontUIResource(fontName, 12, true);
			var font12Underline : ASFontUIResource = new ASFontUIResource(fontName, 12, false, false, true);
			var font14 : ASFontUIResource = new ASFontUIResource(fontName, 13);
			var font14Bold : ASFontUIResource = new ASFontUIResource(fontName, 13, true);
			var defaultSystemFonts:Array = [
				"systemFont", font12, 
				"menuFont", font12, 
				"controlFont", font12, 
				"windowFont", font12,
				"frameFont", font14Bold,
				"font11", font11,
				"font12", font12,
				"font12Bold", font12Bold,
				"font12Underline", font12Underline,
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
		[Embed(source="assets/png/System_hResizeCursor.png")]
		private var System_hResizeCursor : Class;
		
		[Embed(source="assets/png/System_vResizeCursor.png")]
		private var System_vResizeCursor : Class;
		
		[Embed(source="assets/png/System_hvResizeCursor.png")]
		private var System_hvResizeCursor : Class;
		
		[Embed(source="assets/png/System_hMoveCursor.png")]
		private var System_hMoveCursor : Class;
		
		[Embed(source="assets/png/System_vMoveCursor.png")]
		private var System_vMoveCursor : Class;
		
		// Button
		[Embed(source="assets/png/Button_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Button_defaultImage:Class;
		
		[Embed(source="assets/png/Button_pressedImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Button_pressedImage:Class;
		
		[Embed(source="assets/png/Button_rolloverImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Button_rolloverImage:Class;
		
		[Embed(source="assets/png/Button_disabledImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Button_disabledImage:Class;
		
		[Embed(source="assets/png/Button_DefaultButton_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Button_DefaultButton_defaultImage:Class;
		
		//ToggleButton
		[Embed(source="assets/png/ToggleButton_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var ToggleButton_defaultImage:Class;
		
		[Embed(source="assets/png/ToggleButton_pressedImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var ToggleButton_pressedImage:Class;
		
		[Embed(source="assets/png/ToggleButton_disabledImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var ToggleButton_disabledImage:Class;
		
		[Embed(source="assets/png/ToggleButton_selectedImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var ToggleButton_selectedImage:Class;
		
		[Embed(source="assets/png/ToggleButton_disabledSelectedImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var ToggleButton_disabledSelectedImage:Class;
		
		[Embed(source="assets/png/ToggleButton_rolloverImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var ToggleButton_rolloverImage:Class;
		
		[Embed(source="assets/png/ToggleButton_rolloverSelectedImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var ToggleButton_rolloverSelectedImage:Class;
		
		//RadioButton
		[Embed(source="assets/png/RadioButton_defaultImage.png")]
		private var RadioButton_defaultImage:Class;
		
		[Embed(source="assets/png/RadioButton_pressedImage.png")]
		private var RadioButton_pressedImage:Class;
		
		[Embed(source="assets/png/RadioButton_pressedSelectedImage.png")]
		private var RadioButton_pressedSelectedImage:Class;
		
		[Embed(source="assets/png/RadioButton_disabledImage.png")]
		private var RadioButton_disabledImage:Class;
		
		[Embed(source="assets/png/RadioButton_selectedImage.png")]
		private var RadioButton_selectedImage:Class;
		
		[Embed(source="assets/png/RadioButton_disabledSelectedImage.png")]
		private var RadioButton_disabledSelectedImage:Class;
		
		[Embed(source="assets/png/RadioButton_rolloverImage.png")]
		private var RadioButton_rolloverImage:Class;
		
		[Embed(source="assets/png/RadioButton_rolloverSelectedImage.png")]
		private var RadioButton_rolloverSelectedImage:Class;
		
		//CheckBox
		[Embed(source="assets/png/CheckBox_defaultImage.png")]
		private var CheckBox_defaultImage:Class;
		
		[Embed(source="assets/png/CheckBox_pressedImage.png")]
		private var CheckBox_pressedImage:Class;
		
		[Embed(source="assets/png/CheckBox_pressedSelectedImage.png")]
		private var CheckBox_pressedSelectedImage:Class;
		
		[Embed(source="assets/png/CheckBox_disabledImage.png")]
		private var CheckBox_disabledImage:Class;
		
		[Embed(source="assets/png/CheckBox_selectedImage.png")]
		private var CheckBox_selectedImage:Class;
		
		[Embed(source="assets/png/CheckBox_disabledSelectedImage.png")]
		private var CheckBox_disabledSelectedImage:Class;
		
		[Embed(source="assets/png/CheckBox_rolloverImage.png")]
		private var CheckBox_rolloverImage:Class;
		
		[Embed(source="assets/png/CheckBox_rolloverSelectedImage.png")]
		private var CheckBox_rolloverSelectedImage:Class;
		
		//TabbedPane
		//========= header top scale-9 =======
		[Embed(source="assets/png/TabbedPane_top_tab_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_top_tab_defaultImage:Class;
		
		[Embed(source="assets/png/TabbedPane_top_tab_pressedImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_top_tab_pressedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_top_tab_rolloverImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_top_tab_rolloverImage:Class;
		
		[Embed(source="assets/png/TabbedPane_top_tab_disabledImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_top_tab_disabledImage:Class;
		
		[Embed(source="assets/png/TabbedPane_top_tab_selectedImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_top_tab_selectedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_top_tab_rolloverSelectedImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_top_tab_rolloverSelectedImage:Class;
		
		//========= header bottom scale-9 =======
		[Embed(source="assets/png/TabbedPane_bottom_tab_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_bottom_tab_defaultImage:Class;
		
		[Embed(source="assets/png/TabbedPane_bottom_tab_pressedImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_bottom_tab_pressedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_bottom_tab_rolloverImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_bottom_tab_rolloverImage:Class;
		
		[Embed(source="assets/png/TabbedPane_bottom_tab_disabledImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_bottom_tab_disabledImage:Class;
		
		[Embed(source="assets/png/TabbedPane_bottom_tab_selectedImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_bottom_tab_selectedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_bottom_tab_rolloverSelectedImage.png", 
					scaleGridTop="4", scaleGridBottom="13", scaleGridLeft="4", scaleGridRight="45")]
		private var TabbedPane_bottom_tab_rolloverSelectedImage:Class;
		
		//========= header left scale-9 =======
		[Embed(source="assets/png/TabbedPane_left_tab_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_left_tab_defaultImage:Class;
		
		[Embed(source="assets/png/TabbedPane_left_tab_pressedImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_left_tab_pressedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_left_tab_rolloverImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_left_tab_rolloverImage:Class;
		
		[Embed(source="assets/png/TabbedPane_left_tab_disabledImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_left_tab_disabledImage:Class;
		
		[Embed(source="assets/png/TabbedPane_left_tab_selectedImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_left_tab_selectedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_left_tab_rolloverSelectedImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_left_tab_rolloverSelectedImage:Class;
		
		//========= header right scale-9 =======
		[Embed(source="assets/png/TabbedPane_right_tab_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_right_tab_defaultImage:Class;
		
		[Embed(source="assets/png/TabbedPane_right_tab_pressedImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_right_tab_pressedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_right_tab_rolloverImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_right_tab_rolloverImage:Class;
		
		[Embed(source="assets/png/TabbedPane_right_tab_disabledImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_right_tab_disabledImage:Class;
		
		[Embed(source="assets/png/TabbedPane_right_tab_selectedImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_right_tab_selectedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_right_tab_rolloverSelectedImage.png", 
					scaleGridTop="4", scaleGridBottom="45", scaleGridLeft="4", scaleGridRight="13")]
		private var TabbedPane_right_tab_rolloverSelectedImage:Class;
		
		//========= Background Image scale-9 =======
		[Embed(source="assets/png/TabbedPane_top_contentRoundImage.png", 
					scaleGridTop="2", scaleGridBottom="148", scaleGridLeft="2", scaleGridRight="198")]
		private var TabbedPane_top_contentRoundImage:Class;
		
		[Embed(source="assets/png/TabbedPane_bottom_contentRoundImage.png", 
					scaleGridTop="2", scaleGridBottom="148", scaleGridLeft="2", scaleGridRight="198")]
		private var TabbedPane_bottom_contentRoundImage:Class;
		
		[Embed(source="assets/png/TabbedPane_left_contentRoundImage.png", 
					scaleGridTop="2", scaleGridBottom="198", scaleGridLeft="2", scaleGridRight="148")]
		private var TabbedPane_left_contentRoundImage:Class;
		
		[Embed(source="assets/png/TabbedPane_right_contentRoundImage.png", 
					scaleGridTop="2", scaleGridBottom="198", scaleGridLeft="2", scaleGridRight="148")]
		private var TabbedPane_right_contentRoundImage:Class;
		
		//========= Left Arrow Images =======
		[Embed(source="assets/png/Common_arrow_left_defaultImage.png")]
		private var TabbedPane_arrowLeft_defaultImage:Class;
		
		[Embed(source="assets/png/Common_arrow_left_pressedImage.png")]
		private var TabbedPane_arrowLeft_pressedImage:Class;
		
		[Embed(source="assets/png/Common_arrow_left_disabledImage.png")]
		private var TabbedPane_arrowLeft_disabledImage:Class;
		
		[Embed(source="assets/png/Common_arrow_left_rolloverImage.png")]
		private var TabbedPane_arrowLeft_rolloverImage:Class;
		
		//========= Right Arrow Images =======
		[Embed(source="assets/png/Common_arrow_right_defaultImage.png")]
		private var TabbedPane_arrowRight_defaultImage:Class;
		
		[Embed(source="assets/png/Common_arrow_right_pressedImage.png")]
		private var TabbedPane_arrowRight_pressedImage:Class;
		
		[Embed(source="assets/png/Common_arrow_right_disabledImage.png")]
		private var TabbedPane_arrowRight_disabledImage:Class;
		
		[Embed(source="assets/png/Common_arrow_right_rolloverImage.png")]
		private var TabbedPane_arrowRight_rolloverImage:Class;
		
	
		//========= Close Button Images =======
		[Embed(source="assets/png/TabbedPane_closeButton_defaultImage.png")]
		private var TabbedPane_closeButton_defaultImage:Class;
		
		[Embed(source="assets/png/TabbedPane_closeButton_pressedImage.png")]
		private var TabbedPane_closeButton_pressedImage:Class;
		
		[Embed(source="assets/png/TabbedPane_closeButton_disabledImage.png")]
		private var TabbedPane_closeButton_disabledImage:Class;
		
		[Embed(source="assets/png/TabbedPane_closeButton_rolloverImage.png")]
		private var TabbedPane_closeButton_rolloverImage:Class;
		
		// ScrollBar
		//========= Left Arrow Images =======
		[Embed(source="assets/png/Common_arrow_left_defaultImage.png")]
		private var ScrollBar_arrowLeft_defaultImage:Class;
		
		[Embed(source="assets/png/Common_arrow_left_pressedImage.png")]
		private var ScrollBar_arrowLeft_pressedImage:Class;
		
		[Embed(source="assets/png/Common_arrow_left_disabledImage.png")]
		private var ScrollBar_arrowLeft_disabledImage:Class;
		
		[Embed(source="assets/png/Common_arrow_left_rolloverImage.png")]
		private var ScrollBar_arrowLeft_rolloverImage:Class;
		
		//========= Right Arrow Images =======
		[Embed(source="assets/png/Common_arrow_right_defaultImage.png")]
		private var ScrollBar_arrowRight_defaultImage:Class;
		
		[Embed(source="assets/png/Common_arrow_right_pressedImage.png")]
		private var ScrollBar_arrowRight_pressedImage:Class;
		
		[Embed(source="assets/png/Common_arrow_right_disabledImage.png")]
		private var ScrollBar_arrowRight_disabledImage:Class;
		
		[Embed(source="assets/png/Common_arrow_right_rolloverImage.png")]
		private var ScrollBar_arrowRight_rolloverImage:Class;
		
		//========= Up Arrow Images =======
		[Embed(source="assets/png/Common_arrow_up_defaultImage.png")]
		private var ScrollBar_arrowUp_defaultImage:Class;
		
		[Embed(source="assets/png/Common_arrow_up_pressedImage.png")]
		private var ScrollBar_arrowUp_pressedImage:Class;
		
		[Embed(source="assets/png/Common_arrow_up_disabledImage.png")]
		private var ScrollBar_arrowUp_disabledImage:Class;
		
		[Embed(source="assets/png/Common_arrow_up_rolloverImage.png")]
		private var ScrollBar_arrowUp_rolloverImage:Class;
		
		//========= Down Arrow Images =======
		[Embed(source="assets/png/Common_arrow_down_defaultImage.png")]
		private var ScrollBar_arrowDown_defaultImage:Class;
		
		[Embed(source="assets/png/Common_arrow_down_pressedImage.png")]
		private var ScrollBar_arrowDown_pressedImage:Class;
		
		[Embed(source="assets/png/Common_arrow_down_disabledImage.png")]
		private var ScrollBar_arrowDown_disabledImage:Class;
		
		[Embed(source="assets/png/Common_arrow_down_rolloverImage.png")]
		private var ScrollBar_arrowDown_rolloverImage:Class;
		
		//========= Background Images scale-9 ======= 
		[Embed(source="assets/png/ScrollBar_verticalBGImage.png", 
					scaleGridTop="3", scaleGridBottom="17", scaleGridLeft="3", scaleGridRight="13")]
		private var ScrollBar_verticalBGImage:Class;
		
		[Embed(source="assets/png/ScrollBar_horizontalBGImage.png", 
					scaleGridTop="3", scaleGridBottom="13", scaleGridLeft="3", scaleGridRight="17")]
		private var ScrollBar_horizontalBGImage:Class;
		
		//一般没有disabled的ScrollBar，故忽略。
//		[Embed(source="assets/png/ScrollBar_verticalBGDisabledImage.png", 
//					scaleGridTop="4", scaleGridBottom="16", scaleGridLeft="4", scaleGridRight="11")]
		private var ScrollBar_verticalBGDisabledImage:Class;
		
//		[Embed(source="assets/png/ScrollBar_horizontalBGDisabledImage.png", 
//					scaleGridTop="4", scaleGridBottom="16", scaleGridLeft="4", scaleGridRight="11")]
		private var ScrollBar_horizontalBGDisabledImage:Class;
		
		//========= Thumb Images scale-9 ======= 
		//vertical
		[Embed(source="assets/png/ScrollBar_thumbVertical_defaultImage.png", 
					scaleGridTop="5", scaleGridBottom="15", scaleGridLeft="5", scaleGridRight="10")]
		private var ScrollBar_thumbVertical_defaultImage:Class;
		
		[Embed(source="assets/png/ScrollBar_thumbVertical_pressedImage.png", 
					scaleGridTop="5", scaleGridBottom="15", scaleGridLeft="5", scaleGridRight="10")]
		private var ScrollBar_thumbVertical_pressedImage:Class;
		
		[Embed(source="assets/png/ScrollBar_thumbVertical_rolloverImage.png", 
					scaleGridTop="5", scaleGridBottom="15", scaleGridLeft="5", scaleGridRight="10")]
		private var ScrollBar_thumbVertical_rolloverImage:Class;
		
		[Embed(source="assets/png/ScrollBar_thumbVertical_disabledImage.png", 
					scaleGridTop="5", scaleGridBottom="15", scaleGridLeft="5", scaleGridRight="10")]
		private var ScrollBar_thumbVertical_disabledImage:Class;
		
		[Embed(source="assets/png/ScrollBar_thumbVertical_iconImage.png")]
		private var ScrollBar_thumbVertical_iconImage:Class;
		
		//horizontal
		[Embed(source="assets/png/ScrollBar_thumbHorizontal_defaultImage.png", 
					scaleGridTop="5", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="15")]
		private var ScrollBar_thumbHorizontal_defaultImage:Class;
		
		[Embed(source="assets/png/ScrollBar_thumbHorizontal_pressedImage.png", 
					scaleGridTop="5", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="15")]
		private var ScrollBar_thumbHorizontal_pressedImage:Class;
		
		[Embed(source="assets/png/ScrollBar_thumbHorizontal_rolloverImage.png", 
					scaleGridTop="5", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="15")]
		private var ScrollBar_thumbHorizontal_rolloverImage:Class;
		
		[Embed(source="assets/png/ScrollBar_thumbHorizontal_disabledImage.png", 
					scaleGridTop="5", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="15")]
		private var ScrollBar_thumbHorizontal_disabledImage:Class;
	
		[Embed(source="assets/png/ScrollBar_thumbHorizontal_iconImage.png")]
		private var ScrollBar_thumbHorizontal_iconImage:Class;
		
		//ProgressBar __________________________
		//========= Background Images scale-9 or not ======= 
		[Embed(source="assets/png/ProgressBar_verticalBGImage.png", 
					scaleGridTop="2", scaleGridBottom="37", scaleGridLeft="2", scaleGridRight="12")]
		private var ProgressBar_verticalBGImage:Class;
		
		[Embed(source="assets/png/ProgressBar_horizontalBGImage.png", 
					scaleGridTop="2", scaleGridBottom="12", scaleGridLeft="2", scaleGridRight="37")]
		private var ProgressBar_horizontalBGImage:Class;
		
		//========= Foreground Images scale-9 or not ======= 
		[Embed(source="assets/png/ProgressBar_verticalFGImage.png")]
		private var ProgressBar_verticalFGImage:Class;
		
		[Embed(source="assets/png/ProgressBar_horizontalFGImage.png")]
		private var ProgressBar_horizontalFGImage:Class;
		
		//TextField 
		[Embed(source="assets/png/TextField_defaultImage.png", 
					scaleGridTop="6", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="60")]
		private var TextField_defaultImage:Class;
		
		[Embed(source="assets/png/TextField_uneditableImage.png", 
					scaleGridTop="6", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="60")]
		private var TextField_uneditableImage:Class;
		
		[Embed(source="assets/png/TextField_disabledImage.png", 
					scaleGridTop="6", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="60")]
		private var TextField_disabledImage:Class;
		
		//TextArea 
		[Embed(source="assets/png/TextArea_defaultImage.png", 
					scaleGridTop="6", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="60")]
		private var TextArea_defaultImage:Class;
		
		[Embed(source="assets/png/TextArea_uneditableImage.png", 
					scaleGridTop="6", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="60")]
		private var TextArea_uneditableImage:Class;
		
		[Embed(source="assets/png/TextArea_disabledImage.png", 
					scaleGridTop="6", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="60")]
		private var TextArea_disabledImage:Class;
		
		//Frame
		//Backgorund scale-9 (Include title bar background all in one picture)
		[Embed(source="assets/png/Frame_activeBG.png", 
					scaleGridTop="27", scaleGridBottom="162", scaleGridLeft="8", scaleGridRight="370")]
		private var Frame_activeBG:Class;
		
		[Embed(source="assets/png/Frame_inactiveBG.png", 
					scaleGridTop="27", scaleGridBottom="162", scaleGridLeft="8", scaleGridRight="370")]
		private var Frame_inactiveBG:Class;
		
		//========= Frame_iconifiedIcon Images =======
		[Embed(source="assets/png/Frame_iconifiedIcon_defaultImage.png")]
		private var Frame_iconifiedIcon_defaultImage:Class;
		
		[Embed(source="assets/png/Frame_iconifiedIcon_pressedImage.png")]
		private var Frame_iconifiedIcon_pressedImage:Class;
		
		[Embed(source="assets/png/Frame_iconifiedIcon_disabledImage.png")]
		private var Frame_iconifiedIcon_disabledImage:Class;
		
		[Embed(source="assets/png/Frame_iconifiedIcon_rolloverImage.png")]
		private var Frame_iconifiedIcon_rolloverImage:Class;
		
		//========= Frame_normalIcon Images =======
		[Embed(source="assets/png/Frame_normalIcon_defaultImage.png")]
		private var Frame_normalIcon_defaultImage:Class;
		
		[Embed(source="assets/png/Frame_normalIcon_pressedImage.png")]
		private var Frame_normalIcon_pressedImage:Class;
		
		[Embed(source="assets/png/Frame_normalIcon_disabledImage.png")]
		private var Frame_normalIcon_disabledImage:Class;
		
		[Embed(source="assets/png/Frame_normalIcon_rolloverImage.png")]
		private var Frame_normalIcon_rolloverImage:Class;
		
		//========= Frame_maximizeIcon Images =======
		[Embed(source="assets/png/Frame_maximizeIcon_defaultImage.png")]
		private var Frame_maximizeIcon_defaultImage:Class;
		
		[Embed(source="assets/png/Frame_maximizeIcon_pressedImage.png")]
		private var Frame_maximizeIcon_pressedImage:Class;
		
		[Embed(source="assets/png/Frame_maximizeIcon_disabledImage.png")]
		private var Frame_maximizeIcon_disabledImage:Class;
		
		[Embed(source="assets/png/Frame_maximizeIcon_rolloverImage.png")]
		private var Frame_maximizeIcon_rolloverImage:Class;
		
		//========= Down Arrow Images =======
		[Embed(source="assets/png/Frame_closeIcon_defaultImage.png")]
		private var Frame_closeIcon_defaultImage:Class;
		
		[Embed(source="assets/png/Frame_closeIcon_pressedImage.png")]
		private var Frame_closeIcon_pressedImage:Class;
		
		[Embed(source="assets/png/Frame_closeIcon_disabledImage.png")]
		private var Frame_closeIcon_disabledImage:Class;
		
		[Embed(source="assets/png/Frame_closeIcon_rolloverImage.png")]
		private var Frame_closeIcon_rolloverImage:Class;
		
		//ToolTip
		[Embed(source="assets/png/ToolTip_bgImage.png", 
					scaleGridTop="5", scaleGridBottom="51", scaleGridLeft="5", scaleGridRight="22")]
		private var ToolTip_bgImage:Class;
		
		//========= Background Images scale-9 ======= 
		[Embed(source="assets/png/SplitPane_divider_verticalBGImage.png", 
			scaleGridTop="1", scaleGridBottom="4", scaleGridLeft="1", scaleGridRight="4")] 
		private var SplitPane_divider_verticalBGImage:Class;
		
		[Embed(source="assets/png/SplitPane_divider_horizontalBGImage.png", 
			scaleGridTop="1", scaleGridBottom="4", scaleGridLeft="1", scaleGridRight="4")]
		private var SplitPane_divider_horizontalBGImage:Class;
		
		//by default the disabled bg state is null(means same to normal state), but you can add it by remove the comments
		//[Embed(source="assets/png/SplitPane_divider_verticalBGDisabledImage.png", 
		//	scaleGridTop="1", scaleGridBottom="4", scaleGridLeft="1", scaleGridRight="4")]
		private var SplitPane_divider_verticalBGDisabledImage:Class;
		
		//[Embed(source="assets/png/SplitPane_divider_horizontalBGDisabledImage.png", 
		//	scaleGridTop="1", scaleGridBottom="4", scaleGridLeft="1", scaleGridRight="4")]
		private var SplitPane_divider_horizontalBGDisabledImage:Class;
		
		// JComboBox
		//========= BG Images =======
		[Embed(source="assets/png/ComboBox_defaultImage.png", 
					scaleGridTop="5", scaleGridBottom="20", scaleGridLeft="5", scaleGridRight="23")]
		private var ComboBox_defaultImage:Class;
		
		[Embed(source="assets/png/ComboBox_defaultRolloverImage.png", 
					scaleGridTop="5", scaleGridBottom="20", scaleGridLeft="5", scaleGridRight="23")]
		private var ComboBox_defaultRolloverImage:Class;
		
		[Embed(source="assets/png/ComboBox_defaultPressedImage.png",
					scaleGridTop="5", scaleGridBottom="20", scaleGridLeft="5", scaleGridRight="23")]
		private var ComboBox_defaultPressedImage:Class;
		
		[Embed(source="assets/png/ComboBox_uneditableImage.png",
					scaleGridTop="5", scaleGridBottom="20", scaleGridLeft="5", scaleGridRight="23")]
		private var ComboBox_uneditableImage:Class;
		
		[Embed(source="assets/png/ComboBox_uneditableRolloverImage.png",
					scaleGridTop="5", scaleGridBottom="20", scaleGridLeft="5", scaleGridRight="23")]
		private var ComboBox_uneditableRolloverImage:Class;
		
		[Embed(source="assets/png/ComboBox_uneditablePressedImage.png",
					scaleGridTop="5", scaleGridBottom="20", scaleGridLeft="5", scaleGridRight="23")]
		private var ComboBox_uneditablePressedImage:Class;
		
		[Embed(source="assets/png/ComboBox_disabledImage.png",
					scaleGridTop="5", scaleGridBottom="20", scaleGridLeft="5", scaleGridRight="23")]
		private var ComboBox_disabledImage:Class;
		
		//========= Arrow Button Images =======
		[Embed(source="assets/png/ComboBox_arrowButton_defaultImage.png")]
		private var ComboBox_arrowButton_defaultImage:Class;
		
		[Embed(source="assets/png/ComboBox_arrowButton_pressedImage.png")]
		private var ComboBox_arrowButton_pressedImage:Class;
		
		[Embed(source="assets/png/ComboBox_arrowButton_disabledImage.png")]
		private var ComboBox_arrowButton_disabledImage:Class;
		
		[Embed(source="assets/png/ComboBox_arrowButton_rolloverImage.png")]
		private var ComboBox_arrowButton_rolloverImage:Class;
		
		//Slider _______________________________
		//========= track scale-9 or not=======
		[Embed(source="assets/png/Slider_vertical_trackImage.png", 
					scaleGridTop="5", scaleGridBottom="127", scaleGridLeft="8", scaleGridRight="10")]
		private var Slider_vertical_trackImage:Class;
		[Embed(source="assets/png/Slider_vertical_trackDisabledImage.png", 
					scaleGridTop="5", scaleGridBottom="127", scaleGridLeft="8", scaleGridRight="10")]
		private var Slider_vertical_trackDisabledImage:Class;
		
		[Embed(source="assets/png/Slider_vertical_trackProgressImage.png")]
		private var Slider_vertical_trackProgressImage:Class;
		[Embed(source="assets/png/Slider_vertical_trackProgressDisabledImage.png")]
		private var Slider_vertical_trackProgressDisabledImage:Class;
		
		[Embed(source="assets/png/Slider_horizontal_trackImage.png", 
					scaleGridTop="8", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="127")]
		private var Slider_horizontal_trackImage:Class;
		[Embed(source="assets/png/Slider_horizontal_trackDisabledImage.png", 
					scaleGridTop="8", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="127")]
		private var Slider_horizontal_trackDisabledImage:Class;
		
		[Embed(source="assets/png/Slider_horizontal_trackProgressImage.png")]
		private var Slider_horizontal_trackProgressImage:Class;
		[Embed(source="assets/png/Slider_horizontal_trackProgressDisabledImage.png")]
		private var Slider_horizontal_trackProgressDisabledImage:Class;
		
		//========= Thumb Images =======
		[Embed(source="assets/png/Slider_thumbHorizontal_defaultImage.png")]
		private var Slider_thumbHorizontal_defaultImage:Class;
		
		[Embed(source="assets/png/Slider_thumbHorizontal_pressedImage.png")]
		private var Slider_thumbHorizontal_pressedImage:Class;
		
		[Embed(source="assets/png/Slider_thumbHorizontal_disabledImage.png")]
		private var Slider_thumbHorizontal_disabledImage:Class;
		
		[Embed(source="assets/png/Slider_thumbHorizontal_rolloverImage.png")]
		private var Slider_thumbHorizontal_rolloverImage:Class;
		
		
		[Embed(source="assets/png/Slider_thumbVertical_defaultImage.png")]
		private var Slider_thumbVertical_defaultImage:Class;
		
		[Embed(source="assets/png/Slider_thumbVertical_pressedImage.png")]
		private var Slider_thumbVertical_pressedImage:Class;
		
		[Embed(source="assets/png/Slider_thumbVertical_disabledImage.png")]
		private var Slider_thumbVertical_disabledImage:Class;
		
		[Embed(source="assets/png/Slider_thumbVertical_rolloverImage.png")]
		private var Slider_thumbVertical_rolloverImage:Class;
		
		//Adjuster
		//========= Arrow Images =======
		[Embed(source="assets/png/Adjuster_arrowButton_defaultImage.png")]
		private var Adjuster_arrowButton_defaultImage:Class;
		
		[Embed(source="assets/png/Adjuster_arrowButton_pressedImage.png")]
		private var Adjuster_arrowButton_pressedImage:Class;
		
		[Embed(source="assets/png/Adjuster_arrowButton_disabledImage.png")]
		private var Adjuster_arrowButton_disabledImage:Class;
		
		[Embed(source="assets/png/Adjuster_arrowButton_rolloverImage.png")]
		private var Adjuster_arrowButton_rolloverImage:Class;
		
		//========= Track scale-9 or not =======
		[Embed(source="assets/png/Slider_vertical_trackImage.png", 
					scaleGridTop="5", scaleGridBottom="127", scaleGridLeft="8", scaleGridRight="10")]
		private var Adjuster_Slider_vertical_trackImage:Class;
		[Embed(source="assets/png/Slider_vertical_trackDisabledImage.png", 
					scaleGridTop="5", scaleGridBottom="127", scaleGridLeft="8", scaleGridRight="10")]
		private var Adjuster_Slider_vertical_trackDisabledImage:Class;
		
		[Embed(source="assets/png/Slider_vertical_trackProgressImage.png")]
		private var Adjuster_Slider_vertical_trackProgressImage:Class;
		[Embed(source="assets/png/Slider_vertical_trackProgressDisabledImage.png")]
		private var Adjuster_Slider_vertical_trackProgressDisabledImage:Class;
		
		[Embed(source="assets/png/Slider_horizontal_trackImage.png", 
					scaleGridTop="8", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="127")]
		private var Adjuster_Slider_horizontal_trackImage:Class;
		[Embed(source="assets/png/Slider_horizontal_trackDisabledImage.png", 
					scaleGridTop="8", scaleGridBottom="10", scaleGridLeft="5", scaleGridRight="127")]
		private var Adjuster_Slider_horizontal_trackDisabledImage:Class;
		
		[Embed(source="assets/png/Slider_horizontal_trackProgressImage.png")]
		private var Adjuster_Slider_horizontal_trackProgressImage:Class;
		[Embed(source="assets/png/Slider_horizontal_trackProgressDisabledImage.png")]
		private var Adjuster_Slider_horizontal_trackProgressDisabledImage:Class;
		
		//========= Thumb Images =======
		[Embed(source="assets/png/Slider_thumbHorizontal_defaultImage.png")]
		private var Adjuster_Slider_thumbHorizontal_defaultImage:Class;
		
		[Embed(source="assets/png/Slider_thumbHorizontal_pressedImage.png")]
		private var Adjuster_Slider_thumbHorizontal_pressedImage:Class;
		
		[Embed(source="assets/png/Slider_thumbHorizontal_disabledImage.png")]
		private var Adjuster_Slider_thumbHorizontal_disabledImage:Class;
		
		[Embed(source="assets/png/Slider_thumbHorizontal_rolloverImage.png")]
		private var Adjuster_Slider_thumbHorizontal_rolloverImage:Class;
		
		
		[Embed(source="assets/png/Slider_thumbVertical_defaultImage.png")]
		private var Adjuster_Slider_thumbVertical_defaultImage:Class;
		
		[Embed(source="assets/png/Slider_thumbVertical_pressedImage.png")]
		private var Adjuster_Slider_thumbVertical_pressedImage:Class;
		
		[Embed(source="assets/png/Slider_thumbVertical_disabledImage.png")]
		private var Adjuster_Slider_thumbVertical_disabledImage:Class;
		
		[Embed(source="assets/png/Slider_thumbVertical_rolloverImage.png")]
		private var Adjuster_Slider_thumbVertical_rolloverImage:Class;
		
		//Accordion
		//======================================================================
		[Embed(source="assets/png/ToggleButton_defaultImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Accordion_header_defaultImage:Class;
		
		[Embed(source="assets/png/ToggleButton_pressedImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Accordion_header_pressedImage:Class;
		
		[Embed(source="assets/png/ToggleButton_rolloverImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Accordion_header_rolloverImage:Class;
		
		[Embed(source="assets/png/ToggleButton_disabledImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Accordion_header_disabledImage:Class;
		
		[Embed(source="assets/png/ToggleButton_selectedImage.png", 
					scaleGridTop="4", scaleGridBottom="15", scaleGridLeft="6", scaleGridRight="43")]
		private var Accordion_header_selectedImage:Class;
		
		//Table Header 
		//========= Cell Background Images =======
		[Embed(source="assets/png/TableHeader_cell_defaultImage.png", 
					scaleGridTop="3", scaleGridBottom="20", scaleGridLeft="3", scaleGridRight="37")]
		private var TableHeader_cell_defaultImage:Class;
		
		[Embed(source="assets/png/TableHeader_cell_pressedImage.png", 
					scaleGridTop="3", scaleGridBottom="20", scaleGridLeft="3", scaleGridRight="37")]
		private var TableHeader_cell_pressedImage:Class;
		
		[Embed(source="assets/png/TableHeader_cell_disabledImage.png", 
					scaleGridTop="3", scaleGridBottom="20", scaleGridLeft="3", scaleGridRight="37")]
		private var TableHeader_cell_disabledImage:Class;
		
		[Embed(source="assets/png/TableHeader_cell_rolloverImage.png", 
					scaleGridTop="3", scaleGridBottom="20", scaleGridLeft="3", scaleGridRight="37")]
		private var TableHeader_cell_rolloverImage:Class;
		
		//Tree
		//========= Icon Images =======
		[Embed(source="assets/png/Tree_leafImage.png")]
		private var Tree_leafImage:Class;
		
		[Embed(source="assets/png/Tree_folderExpandedImage.png")]
		private var Tree_folderExpandedImage:Class;
		
		[Embed(source="assets/png/Tree_folderCollapsedImage.png")]
		private var Tree_folderCollapsedImage:Class;
		
		//========= Control Images =======
		[Embed(source="assets/png/Tree_leafControlImage.png")]
		private var Tree_leafControlImage:Class;
		
		[Embed(source="assets/png/Tree_folderExpandedControlImage.png")]
		private var Tree_folderExpandedControlImage:Class;
		
		[Embed(source="assets/png/Tree_folderCollapsedControlImage.png")]
		private var Tree_folderCollapsedControlImage:Class;
		
		//Menu 
		[Embed(source="assets/png/MenuBar_bgImage.png")]
		private var MenuBar_bgImage:Class;
		[Embed(source="assets/png/PopupMenu_bgImage.png", 
					scaleGridTop="10", scaleGridBottom="40", scaleGridLeft="35", scaleGridRight="170")]
		private var PopupMenu_bgImage:Class;
		
		//MenuItemss
		[Embed(source="assets/png/Menu_rolloverImage.png", 
					scaleGridTop="5", scaleGridBottom="17", scaleGridLeft="5", scaleGridRight="20")]
		private var Menu_rolloverImage:Class;
		
		[Embed(source="assets/png/Menu_rolloverImage.png", 
					scaleGridTop="5", scaleGridBottom="17", scaleGridLeft="5", scaleGridRight="20")]
		private var MenuItem_rolloverImage:Class;
		
		[Embed(source="assets/png/Menu_rolloverImage.png", 
					scaleGridTop="5", scaleGridBottom="17", scaleGridLeft="5", scaleGridRight="20")]
		private var CheckBoxMenuItem_rolloverImage:Class;
		
		[Embed(source="assets/png/Menu_rolloverImage.png", 
					scaleGridTop="5", scaleGridBottom="17", scaleGridLeft="5", scaleGridRight="20")]
		private var RadioButtonMenuItem_rolloverImage:Class;
		
		[Embed(source="assets/png/Menu_arrowIconImage.png")]
		private var Menu_arrowIconImage:Class;
		
		[Embed(source="assets/png/RadioButtonMenuItem_checkIconImage.png")]
		private var RadioButtonMenuItem_checkIconImage:Class;
		
		[Embed(source="assets/png/CheckBoxMenuItem_checkIconImage.png")]
		private var CheckBoxMenuItem_checkIconImage:Class;
		
		/**
		 * UI组件属性设置。
		 *  
		 * @param table
		 * 
		 */		
		override protected function initComponentDefaults(table : UIDefaults) : void {
			super.initComponentDefaults(table);
			
			// *** Button
			var comDefaults:Array = [
				"Button.opaque", false, 
				"Button.defaultImage", Button_defaultImage,
				"Button.pressedImage", Button_pressedImage,
				"Button.disabledImage", Button_disabledImage,
				"Button.rolloverImage", Button_rolloverImage, 
				"Button.DefaultButton.defaultImage", Button_DefaultButton_defaultImage, 
				"Button.bg", SkinButtonBackground,
				"Button.margin", new InsetsUIResource(2, 10, 2, 10), //文字周围的空间
				"Button.textShiftOffset", 0 //鼠标点击时偏移
			];
			table.putDefaults(comDefaults);
			
			// *** LabelButton
			comDefaults = [
				"LabelButton.foreground", new ASColorUIResource(0x2c628b),
				"LabelButton.rollOver", new ASColorUIResource(0x3ed6fd),		
				"LabelButton.pressed", new ASColorUIResource(0x3c7fb1),		
				"LabelButton.font", table.getFont("font12Underline"),
			];
			table.putDefaults(comDefaults);
			
			// *** ToggleButton
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
				"ToggleButton.margin", new InsetsUIResource(2, 10, 2, 10), //文字周围的空间
			];
			table.putDefaults(comDefaults);
			
			// *** RadioButton
			comDefaults = [
				"RadioButton.icon", SkinRadioButtonIcon,
				"RadioButton.defaultImage", RadioButton_defaultImage,
				"RadioButton.pressedImage", RadioButton_pressedImage,
				"RadioButton.pressedSelectedImage", RadioButton_pressedSelectedImage,
				"RadioButton.disabledImage", RadioButton_disabledImage,
				"RadioButton.selectedImage", RadioButton_selectedImage,
				"RadioButton.disabledSelectedImage", RadioButton_disabledSelectedImage,
				"RadioButton.rolloverImage", RadioButton_rolloverImage,
				"RadioButton.rolloverSelectedImage", RadioButton_rolloverSelectedImage
			];
			table.putDefaults(comDefaults);
	
			// *** CheckBox
			comDefaults = [
				"CheckBox.icon", SkinCheckBoxIcon,
				"CheckBox.defaultImage", CheckBox_defaultImage,
				"CheckBox.pressedImage", CheckBox_pressedImage,
				"CheckBox.pressedSelectedImage", CheckBox_pressedSelectedImage,
				"CheckBox.disabledImage", CheckBox_disabledImage,
				"CheckBox.selectedImage", CheckBox_selectedImage,
				"CheckBox.disabledSelectedImage", CheckBox_disabledSelectedImage,
				"CheckBox.rolloverImage", CheckBox_rolloverImage,
				"CheckBox.rolloverSelectedImage", CheckBox_rolloverSelectedImage
			];
			table.putDefaults(comDefaults);
			
			// *** TabbedPane
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
			
			// *** ClosableTabbedPane
			comDefaults = [
				"ClosableTabbedPane.tab", BluenessClosableTabbedPaneTab, 
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
				"ClosableTabbedPane.closeButtonGap", 10, //关闭按钮与文字的间隔
				"ClosableTabbedPane.bg", null //bg is managed by SkinTabbedPaneUI
			];
			table.putDefaults(comDefaults);
			
			// *** Separator
			comDefaults = [
				"Separator.background", new ASColorUIResource(0xEEEEEE),
			];
			table.putDefaults(comDefaults);
			
			// *** ScrollBar
			comDefaults = [
				"ScrollBar.opaque", false, 
				"ScrollBar.thumbDecorator", SkinScrollBarThumb,
				"ScrollBar.minimumThumbLength", 12, //如果滑块长度小此值，则不显示滑块
			
				"ScrollBar.bg", SkinScrollBarBackground, 
				"ScrollBar.verticalBGImage", ScrollBar_verticalBGImage, 
				"ScrollBar.horizotalBGImage", ScrollBar_horizontalBGImage, 
				
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
			
			// *** ProgressBar
			comDefaults = [
				"ProgressBar.border", null, 
				"ProgressBar.font", table.get("font11"),
				"ProgressBar.foreground", table.get("controlText"),
				"ProgressBar.bg", SkinProgressBarBackground, 
				"ProgressBar.fg", SkinProgressBarForeground,
				"ProgressBar.fgMargin", new InsetsUIResource(1, 1, 1, 1), //modify this to margin fg, concider HORIZONTAL, vertical will be transfered
				"ProgressBar.verticalBGImage", ProgressBar_verticalBGImage, 
				"ProgressBar.horizotalBGImage", ProgressBar_horizontalBGImage, 
				"ProgressBar.verticalFGImage", ProgressBar_verticalFGImage, 
				"ProgressBar.horizotalFGImage", ProgressBar_horizontalFGImage,
				"ProgressBar.indeterminateDelay", 50,
			];
			table.putDefaults(comDefaults);
			
			// *** TextField
			comDefaults = [
				"TextField.opaque", true, 
				"TextField.bg", SkinTextFieldBackground,
				"TextField.border", new SkinEmptyBorder(2, 3, 2, 3), //modify this to fit the bg image
				"TextField.defaultImage", TextField_defaultImage, 
				"TextField.uneditableImage", TextField_uneditableImage, 
				"TextField.disabledImage", TextField_disabledImage
			];
			table.putDefaults(comDefaults);
			
			// *** TextArea
			comDefaults = [
				"TextArea.opaque", true, 
				"TextArea.bg", SkinTextAreaBackground,
				"TextArea.border", new SkinEmptyBorder(2, 3, 2, 3), //modify this to fit the bg image
				"TextArea.defaultImage", TextArea_defaultImage, 
				"TextArea.uneditableImage", TextArea_uneditableImage, 
				"TextArea.disabledImage", TextArea_disabledImage
			];
			table.putDefaults(comDefaults);
			
			// *** JFrame
			comDefaults = [
				"Frame.resizer", BluenessResizer,
				"Frame.background", table.get("window"), 
				"Frame.foreground", table.get("windowText"),
				"Frame.opaque", true, 
				"Frame.font", table.get("frameFont"),
				"Frame.titleBarHeight", 27, //modify this to fit title bar height of bg image
				"Frame.border", new SkinEmptyBorder(1, 8, 8, 8), //Frame的边框。
				//增大高度,contentPane向下移动，TitleBar也会下移，Frame的背景下移
				//titleBarHeight+border.Height，就是contentPan的x。
				"Frame.backgroundMargin", new InsetsUIResource(26, 0, 0, 0), //背景的外间距。
				//增大高度,Frame的背景下移
				//border.Height+backgroundMargin.Height就是Frame背景的x。
				"Frame.bg", SkinFrameBackground, //this will use Frame.activeBG and Frame.inactiveBG
				"Frame.activeBG", Frame_activeBG, 
				"Frame.inactiveBG", Frame_inactiveBG, 
				"Frame.titleBarBG", SkinFrameTitleBarBG, 
				"Frame.titleBarButtonGap", 0, 
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
			
			//JSplitPane
			comDefaults = [
				"SplitPane.presentDragColor", new ASColorUIResource(0xCCCCCC, 60), 
				"SplitPane.defaultDividerSize", 5, //modify this to fit the divier images
				"SplitPane.divider.verticalBGImage", SplitPane_divider_verticalBGImage, 
				"SplitPane.divider.horizotalBGImage", SplitPane_divider_horizontalBGImage, 
				
// 				"SplitPane.arrowLeft.defaultImage", SplitPane_arrowLeft_defaultImage, 
//				"SplitPane.arrowLeft.pressedImage", SplitPane_arrowLeft_pressedImage, 
//				"SplitPane.arrowLeft.disabledImage", SplitPane_arrowLeft_disabledImage, 
//				"SplitPane.arrowLeft.rolloverImage", SplitPane_arrowLeft_rolloverImage, 
//				
//				"SplitPane.arrowRight.defaultImage", SplitPane_arrowRight_defaultImage, 
//				"SplitPane.arrowRight.pressedImage", SplitPane_arrowRight_pressedImage, 
//				"SplitPane.arrowRight.disabledImage", SplitPane_arrowRight_disabledImage, 
//				"SplitPane.arrowRight.rolloverImage", SplitPane_arrowRight_rolloverImage, 
//				
//				"SplitPane.arrowUp.defaultImage", SplitPane_arrowUp_defaultImage, 
//				"SplitPane.arrowUp.pressedImage", SplitPane_arrowUp_pressedImage, 
//				"SplitPane.arrowUp.disabledImage", SplitPane_arrowUp_disabledImage, 
//				"SplitPane.arrowUp.rolloverImage", SplitPane_arrowUp_rolloverImage, 
//				
//				"SplitPane.arrowDown.defaultImage", SplitPane_arrowDown_defaultImage, 
//				"SplitPane.arrowDown.pressedImage", SplitPane_arrowDown_pressedImage, 
//				"SplitPane.arrowDown.disabledImage", SplitPane_arrowDown_disabledImage, 
//				"SplitPane.arrowDown.rolloverImage", SplitPane_arrowDown_rolloverImage 
			];
			table.putDefaults(comDefaults);
			
			//JComboBox
			comDefaults = [
				"ComboBox.opaque", false, 
				"ComboBox.bg", SkinComboBoxBackground,
				"ComboBox.border", new SkinEmptyBorder(1, 2, 0, 2), //modify this to fit the bg image
				"ComboBox.popupBorder", BluenessComboBoxPopupBorder, 
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
			
			// *** Slider
			comDefaults = [
				"Slider.vertical.trackImage", Slider_vertical_trackImage,
				"Slider.vertical.trackDisabledImage", Slider_vertical_trackDisabledImage,
				"Slider.vertical.trackProgressImage", Slider_vertical_trackProgressImage,
				"Slider.vertical.trackProgressDisabledImage", Slider_vertical_trackProgressDisabledImage,
				
				"Slider.horizontal.trackImage", Slider_horizontal_trackImage,
				"Slider.horizontal.trackDisabledImage", Slider_horizontal_trackDisabledImage,
				"Slider.horizontal.trackProgressImage", Slider_horizontal_trackProgressImage,
				"Slider.horizontal.trackProgressDisabledImage", Slider_horizontal_trackProgressDisabledImage,
				
				"Slider.thumbVertical.defaultImage", Slider_thumbVertical_defaultImage,
				"Slider.thumbVertical.pressedImage", Slider_thumbVertical_pressedImage,
				"Slider.thumbVertical.disabledImage", Slider_thumbVertical_disabledImage,
				"Slider.thumbVertical.rolloverImage", Slider_thumbVertical_rolloverImage,
				
				"Slider.thumbHorizontal.defaultImage", Slider_thumbHorizontal_defaultImage,
				"Slider.thumbHorizontal.pressedImage", Slider_thumbHorizontal_pressedImage,
				"Slider.thumbHorizontal.disabledImage", Slider_thumbHorizontal_disabledImage,
				"Slider.thumbHorizontal.rolloverImage", Slider_thumbHorizontal_rolloverImage,
				
				"Slider.thumbIcon", SkinSliderThumb,
			];
			table.putDefaults(comDefaults);
			
			// *** Adjuster
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
			
			//JAccordion
			comDefaults = [
				"Accordion.header", SkinAccordionHeader, 
				"Accordion.font", table.get("font12Bold"),
				"Accordion.motionSpeed", 100, 
				"Accordion.tabMargin", new InsetsUIResource(2, 10, 2, 10),  //modify this to fit header image
				"Accordion.header.defaultImage", Accordion_header_defaultImage,
				"Accordion.header.pressedImage", Accordion_header_pressedImage,
				"Accordion.header.disabledImage", Accordion_header_disabledImage,
				"Accordion.header.rolloverImage", Accordion_header_rolloverImage, 
				"Accordion.header.selectedImage", Accordion_header_selectedImage
			];
			table.putDefaults(comDefaults);
			
			 // *** Table
			comDefaults = [
				"Table.opaque", true, 
				"Table.focusable", true, 
				"Table.font", table.getFont("font12"),
				"Table.gridColor", new ASColorUIResource(0xd5d5d5),
				//"Table.background", new ASColorUIResource(0xffffff),
			];
			table.putDefaults(comDefaults);
			
			 // *** TableHeader
			comDefaults = [
				"TableHeader.opaque", true, 
				"TableHeader.focusable", true, 
				"TableHeader.font", table.getFont("font12Bold"),
				"TableHeader.gridColor", new ASColorUIResource(0xd5d5d5),
				"TableHeader.border", undefined, 
				"TableHeader.cellBorder", undefined, 
				"TableHeader.sortableCellBorder", undefined, 
				
				"TableHeader.cellBackground", SkinTableHeaderCellBackground,
				"TableHeader.sortableCellBackground", SkinTableHeaderSortableCellBackground, 
				
				"TableHeader.cell.defaultImage", TableHeader_cell_defaultImage,
				"TableHeader.cell.pressedImage", TableHeader_cell_pressedImage,
				"TableHeader.cell.disabledImage", TableHeader_cell_disabledImage,
				"TableHeader.cell.rolloverImage", TableHeader_cell_rolloverImage
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
				"Tree.rowHeight", 22, 
				"Tree.expandControl", SkinTreeExpandControl, 
				"Tree.leafControlImage", Tree_leafControlImage, 
				"Tree.folderExpandedControlImage", Tree_folderExpandedControlImage, 
				"Tree.folderCollapsedControlImage", Tree_folderCollapsedControlImage
			];
			table.putDefaults(comDefaults);
			
			 // *** MenuItem
		    comDefaults = [
		    	"MenuItem.opaque", false,  
			    "MenuItem.selectionForeground", table.get("menuText"),
			    "MenuItem.acceleratorSelectionForeground", table.get("menuText"),
				"MenuItem.defaultImage", null, 
				"MenuItem.pressedImage", null, 
				"MenuItem.disabledImage", null,
				"MenuItem.rolloverImage", MenuItem_rolloverImage, 
				"MenuItem.bg", SkinMenuItemBackground, 
				"MenuItem.margin", new InsetsUIResource(0, 0, 0, 0),
		    ];
		    table.putDefaults(comDefaults);
		    
		     // *** CheckBoxMenuItem
		    comDefaults = [
		    	"CheckBoxMenuItem.opaque", false,  
			    "CheckBoxMenuItem.selectionForeground", table.get("menuText"),
			    "CheckBoxMenuItem.acceleratorSelectionForeground", table.get("menuText"),
				"CheckBoxMenuItem.defaultImage", null, 
				"CheckBoxMenuItem.pressedImage", null, 
				"CheckBoxMenuItem.disabledImage", null,
				"CheckBoxMenuItem.rolloverImage", CheckBoxMenuItem_rolloverImage, 
				"CheckBoxMenuItem.bg", SkinCheckBoxMenuItemBackground, 
				"CheckBoxMenuItem.checkIconImage", CheckBoxMenuItem_checkIconImage, 
		    	"CheckBoxMenuItem.checkIcon", SkinCheckBoxMenuItemCheckIcon,
				"CheckBoxMenuItem.margin", new InsetsUIResource(0, 0, 0, 0)
		    ];
		    table.putDefaults(comDefaults);
		    
		     // *** RadioButtonMenuItem
		    comDefaults = [
		    	"RadioButtonMenuItem.opaque", false,  
			    "RadioButtonMenuItem.selectionForeground", table.get("menuText"),
			    "RadioButtonMenuItem.acceleratorSelectionForeground", table.get("menuText"),
				"RadioButtonMenuItem.defaultImage", null, 
				"RadioButtonMenuItem.pressedImage", null, 
				"RadioButtonMenuItem.disabledImage", null,
				"RadioButtonMenuItem.rolloverImage", RadioButtonMenuItem_rolloverImage, 
				"RadioButtonMenuItem.bg", SkinRadioButtonMenuItemBackground, 
				"RadioButtonMenuItem.checkIconImage", RadioButtonMenuItem_checkIconImage, 
		    	"RadioButtonMenuItem.checkIcon", SkinRadioButtonMenuItemCheckIcon, 
				"RadioButtonMenuItem.margin", new InsetsUIResource(0, 0, 0, 0)
		    ];
		    table.putDefaults(comDefaults);
		    
		    comDefaults = [
		    	"Menu.opaque", false,  
			    "Menu.selectionForeground", table.get("menuText"),
			    "Menu.acceleratorSelectionForeground", table.get("menuText"),
				"Menu.bg", SkinMenuBackground, 
				"Menu.selectedImage", MenuItem_rolloverImage, 
				"Menu.rolloverImage", MenuItem_rolloverImage, 
				"Menu.arrowIconImage", Menu_arrowIconImage, 
		    	"Menu.arrowIcon", SkinMenuArrowIcon,
		    	"Menu.margin", new InsetsUIResource(3, 3, 3, 3),
		    ];
		    table.putDefaults(comDefaults);
		    
		     // *** PopupMenu
		    comDefaults = [
		       	"PopupMenu.bgImage", PopupMenu_bgImage, 
	    		"PopupMenu.border", new SkinEmptyBorder(3, 3, 3, 3), 
	    		"PopupMenu.bg", BluenessPopupMenuBackground,
		    ];
		    table.putDefaults(comDefaults);
		    
		    // *** MenuBar
		    comDefaults = [
		        "MenuBar.bgImage", MenuBar_bgImage, 
		        "MenuBar.bg", SkinMenuBarBackground,
		    	"MenuBar.border", undefined
		    ];
		    table.putDefaults(comDefaults);
		}
	}
}