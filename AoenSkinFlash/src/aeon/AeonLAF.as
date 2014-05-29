/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package aeon{

import org.aswing.plaf.basic.BasicLookAndFeel;
import org.aswing.plaf.*;
import org.aswing.*;
import org.aswing.skinbuilder.*;

/**
 * SkinBuilder LookAndFeel let you change the skin easily 
 * with only Replace the image files(and modify the scale 9 properties 
 * if the new image size is not same).
 * @author iiley
 */
public class AeonLAF extends BasicLookAndFeel{
	
	public function AeonLAF(){
		super();
	}
	
	override protected function initClassDefaults(table:UIDefaults):void{
		super.initClassDefaults(table);
		var uiDefaults:Array = [ 
			   "ScrollBarUI", SkinScrollBarUI, 
			   "ProgressBarUI", SkinProgressBarUI,
			   "ComboBoxUI", SkinComboBoxUI,	   
			   "SliderUI", SkinSliderUI,		   
			   "AdjusterUI", SkinAdjusterUI, 
			   "TabbedPaneUI", SkinTabbedPaneUI,
			   "SplitPaneUI", SkinSplitPaneUI,
			   "ClosableTabbedPaneUI", SkinClosableTabbedPaneUI,
			   //"TableUI", org.aswing.plaf.basic.BasicTableUI, 
			   //"TableHeaderUI", org.aswing.plaf.basic.BasicTableHeaderUI
		   ];
		table.putDefaults(uiDefaults);
	}

	override protected function initSystemColorDefaults(table:UIDefaults):void{
		super.initSystemColorDefaults(table);
			var defaultSystemColors:Array = [
				//"activeCaption", 0xF2F2F2, /* Color for captions (title bars) when they are active. */
				"activeCaptionText", 0xFFFFFF, /* Text color for text in captions (title bars). */
				//"activeCaptionBorder", 0xC0C0C0, /* Border color for caption (title bar) window borders. */
				//"inactiveCaption", 0xE7E7E7, /* Color for captions (title bars) when not active. */
				"inactiveCaptionText", 0xDDDDDD, /* Text color for text in inactive captions (title bars). */
				//"inactiveCaptionBorder", 0x888888, /* Border color for inactive caption (title bar) window borders. */
				"window", 0xCACDCC, /* Default color for the interior of windows */
				//"windowBorder", 0x000000, /* ??? */
				"windowText", 0xFFFFFF, /* ??? */
				//"menu", 0xCCCCCC, /* Background color for menus */
				//"menuText", 0x000000, /* Text color for menus  */
				//"text", 0xC0C0C0, /* Text background color */
				//"textText", 0x000000, /* Text foreground color */
				//"textHighlight", 0x000080, /* Text background color when selected */
				//"textHighlightText", 0xFFFFFF, /* Text color when selected */
				//"textInactiveText", 0x808080, /* Text color when disabled */
				//"control", 0xF4F4F4,//0xEFEFEF, /* Default color for controls (buttons, sliders, etc) */
				"controlText", 0x002a37, /* Default color for text in controls */
				//"controlHighlight", 0xEEEEEE, /* Specular highlight (opposite of the shadow) */
				//"controlLtHighlight", 0x666666, /* Highlight color for controls */
				//"controlShadow", 0xC7C7C5, /* Shadow color for controls */
				//"controlDkShadow", 0x666666, /* Dark shadow color for controls */
				//"scrollbar", 0xE0E0E0 /* Scrollbar background (usually the "track") */
			];
					
			for(var i:Number=0; i<defaultSystemColors.length; i+=2){
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
			table.put("focusInner", new ASColorUIResource(0x40FF40, 0.3));
			table.put("focusOutter", new ASColorUIResource(0x40FF40, 0.4));
	}
	
	override protected function initSystemFontDefaults(table:UIDefaults):void{
		super.initSystemFontDefaults(table);
		var defaultSystemFonts:Array = [
				"systemFont", new ASFontUIResource("Tahoma", 11), 
				"menuFont", new ASFontUIResource("Tahoma", 11), 
				"controlFont", new ASFontUIResource("Tahoma", 11), 
				"windowFont", new ASFontUIResource("Tahoma", 11, true)
		];
		table.putDefaults(defaultSystemFonts);
	}
	
	override protected function initCommonUtils(table:UIDefaults):void{
		super.initCommonUtils(table);
		
		var arrowColors:Array = [
			"resizeArrow", new ASColorUIResource(0xF2F2F2),
			"resizeArrowLight", new ASColorUIResource(0xCCCCCC),
			"resizeArrowDark", new ASColorUIResource(0x000000)
		];
		table.putDefaults(arrowColors);
		
		var cursors:Array = [
			"System.hResizeCursor", System_hResizeCursor,
			"System.vResizeCursor", System_vResizeCursor,
			"System.hMoveCursor", System_hMoveCursor,
			"System.vMoveCursor", System_vMoveCursor
		];
		table.putDefaults(cursors);
	}
		
	
	//-----------------------------------------------------------------------------
	//___________________________ initComponentDefaults ___________________________
	//=============================================================================
	
	override protected function initComponentDefaults(table:UIDefaults):void{
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
			"Button.margin", new InsetsUIResource(3, 3, 3, 2), //modify this to fit the image border margin 
			"Button.textShiftOffset", 0
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
			"ToggleButton.margin", new InsetsUIResource(2, 3, 3, 2) //modify this to fit the image border margin
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
		
		// *** ScrollBar
		
		comDefaults = [
			"ScrollBar.opaque", false, 
			"ScrollBar.thumbDecorator", SkinScrollBarThumb,
			
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
		
		// *** TextField
		comDefaults = [
			"TextField.opaque", true, 
			"TextField.bg", SkinTextFieldBackground,
			"TextField.border", new SkinEmptyBorder(3, 3, 3, 3), //modify this to fit the bg image
			"TextField.defaultImage", TextField_defaultImage, 
			"TextField.uneditableImage", TextField_uneditableImage, 
			"TextField.disabledImage", TextField_disabledImage
		];
		table.putDefaults(comDefaults);
		
		// *** TextArea
		comDefaults = [
			"TextArea.opaque", true, 
			"TextArea.bg", SkinTextAreaBackground,
			"TextArea.border", new SkinEmptyBorder(3, 3, 3, 3), //modify this to fit the bg image
			"TextArea.defaultImage", TextArea_defaultImage, 
			"TextArea.uneditableImage", TextArea_uneditableImage, 
			"TextArea.disabledImage", TextArea_disabledImage
		];
		table.putDefaults(comDefaults);
		
		
		// *** Frame
		comDefaults = [
			"Frame.background", table.get("window"), 
			"Frame.foreground", table.get("windowText"),
			"Frame.opaque", true, 
			"Frame.bg", SkinFrameBackground, //this will use Frame.activeBG and Frame.inactiveBG
			"Frame.titleBarHeight", 38, //modify this to fit title bar height of bg image
			"Frame.border", new SkinEmptyBorder(0, 17, 12, 17), //modify this to fit the frame bg image
			"Frame.activeBG", Frame_activeBG, 
			"Frame.inactiveBG", Frame_inactiveBG, 		
			"Frame.titleBarBG", SkinFrameTitleBarBG, 
			"Frame.titleBarButtonGap", 2,  
			"Frame.titleBarOpaque", false, 
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
		
		
		// *** ToolTip
		comDefaults = [
			"ToolTip.opaque", false, 
			"ToolTip.bg", SkinToolTipBackground, 
			"ToolTip.bgImage", ToolTip_bgImage, 
			"ToolTip.border", new SkinEmptyBorder(2, 2, 2, 2) //modify this to fit the bg image
		];
		table.putDefaults(comDefaults);
		
		// *** ComboBox
		comDefaults = [
			"ComboBox.opaque", false, 
			"ComboBox.bg", SkinComboBoxBackground,
			"ComboBox.border", new SkinEmptyBorder(3, 3, 3, 3), //modify this to fit the bg image
			"ComboBox.defaultImage", ComboBox_defaultImage, 
			"ComboBox.uneditableImage", ComboBox_uneditableImage, 
			"ComboBox.disabledImage", ComboBox_disabledImage, 
			"ComboBox.defaultRolloverImage", ComboBox_defaultRolloverImage, 
			"ComboBox.uneditableRolloverImage", ComboBox_uneditableRolloverImage, 
			"ComboBox.defaultPressedImage", ComboBox_defaultPressedImage, 
			"ComboBox.uneditablePressedImage", ComboBox_uneditablePressedImage, 
			"ComboBox.arrowButton.defaultImage", ComboBox_arrowButton_defaultImage,
			"ComboBox.arrowButton.pressedImage", ComboBox_arrowButton_pressedImage,
			"ComboBox.arrowButton.disabledImage", ComboBox_arrowButton_disabledImage,
			"ComboBox.arrowButton.rolloverImage", ComboBox_arrowButton_rolloverImage
		];
		table.putDefaults(comDefaults);
		
		// *** Accordion
		comDefaults = [
			"Accordion.header", SkinAccordionHeader, 
			"Accordion.tabMargin", new InsetsUIResource(2, 3, 3, 2),  //modify this to fit header image
			"Accordion.header.defaultImage", Accordion_header_defaultImage,
			"Accordion.header.pressedImage", Accordion_header_pressedImage,
			"Accordion.header.disabledImage", Accordion_header_disabledImage,
			"Accordion.header.rolloverImage", Accordion_header_rolloverImage, 
			"Accordion.header.selectedImage", Accordion_header_selectedImage
		];
		table.putDefaults(comDefaults);
		
		
		// *** TabbedPane
		comDefaults = [
			"TabbedPane.tab", SkinTabbedPaneTab, 
			"TabbedPane.tabMargin", new InsetsUIResource(1, 3, 1, 3),  //modify this to fit header image
			"TabbedPane.tabBorderInsets", new InsetsUIResource(0, 4, 0, 4),
			"TabbedPane.selectedTabExpandInsets", new InsetsUIResource(0, 4, 0, 4), 
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
			
			"TabbedPane.contentMargin", new InsetsUIResource(4, 4, 4, 4), //modify this to fit TabbedPane_contentRoundImage
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
			"ClosableTabbedPane.tab", SkinClosableTabbedPaneTab, 
			"ClosableTabbedPane.tabMargin", new InsetsUIResource(2, 3, 1, 3),  //modify this to fit header image
			"ClosableTabbedPane.tabBorderInsets", new InsetsUIResource(0, 4, 0, 4),
			"ClosableTabbedPane.selectedTabExpandInsets", new InsetsUIResource(0, 4, 0, 4), 
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
			
			"ClosableTabbedPane.contentMargin", new InsetsUIResource(4, 4, 4, 4), //modify this to fit TabbedPane_contentRoundImage
			"ClosableTabbedPane.top.contentRoundImage", TabbedPane_top_contentRoundImage, 
			"ClosableTabbedPane.bottom.contentRoundImage", TabbedPane_bottom_contentRoundImage, 
			"ClosableTabbedPane.left.contentRoundImage", TabbedPane_left_contentRoundImage, 
			"ClosableTabbedPane.right.contentRoundImage", TabbedPane_right_contentRoundImage, 
			"ClosableTabbedPane.contentRoundLineThickness", 1, //modify this to fit contentRoundImage
			"ClosableTabbedPane.bg", null //bg is managed by SkinTabbedPaneUI
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
			
			"Slider.thumbIcon", SkinSliderThumb
		];
		table.putDefaults(comDefaults);
		
		
		 // *** Tree
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
		
		// *** SplitPane
		comDefaults = [
			"SplitPane.presentDragColor", new ASColorUIResource(0x000000, 40), 
			
			"SplitPane.defaultDividerSize", 10, //modify this to fit the divier images
			"SplitPane.divider.verticalBGImage", SplitPane_divider_verticalBGImage, 
			"SplitPane.divider.horizotalBGImage", SplitPane_divider_horizotalBGImage, 
			
			"SplitPane.arrowLeft.defaultImage", SplitPane_arrowLeft_defaultImage, 
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
			"SplitPane.arrowDown.rolloverImage", SplitPane_arrowDown_rolloverImage
		];
		table.putDefaults(comDefaults);
		
		
		
		// *** ProgressBar
		comDefaults = [
			"ProgressBar.border", null, 
			"ProgressBar.foreground", table.get("controlText"),
			"ProgressBar.bg", SkinProgressBarBackground, 
			"ProgressBar.fg", SkinProgressBarForeground,
			"ProgressBar.fgMargin", new InsetsUIResource(0, 0, 0, 0), //modify this to margin fg
			"ProgressBar.verticalBGImage", ProgressBar_verticalBGImage, 
			"ProgressBar.horizotalBGImage", ProgressBar_horizotalBGImage, 
			"ProgressBar.verticalFGImage", ProgressBar_verticalFGImage, 
			"ProgressBar.horizotalFGImage", ProgressBar_horizotalFGImage
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
		
		
		 // *** TableHeader
		comDefaults = [
			"TableHeader.opaque", false, 
			"TableHeader.focusable", true, 
			"TableHeader.gridColor", new ASColorUIResource(0x444444),
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
		
		
		 // *** ToolBar
		comDefaults = [
			"ToolBar.background", table.get("window"),
			"ToolBar.foreground", table.get("windowText"),
			"ToolBar.opaque", false, 
			"ToolBar.focusable", false 
		];
		
		table.putDefaults(comDefaults);
		
	}	
	
}
}