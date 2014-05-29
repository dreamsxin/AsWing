/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
import org.aswing.plaf.basic.tabbedpane.Tab;
import org.aswing.AbstractButton;
import org.aswing.geom.IntRectangle;
import org.aswing.plaf.basic.BasicTabbedPaneUI;
import org.aswing.JButton;
import org.aswing.Component;

import org.aswing.GroundDecorator;
import org.aswing.AsWingUtils;
import flash.display.Sprite;
import org.aswing.event.InteractiveEvent;
import org.aswing.Insets;
import org.aswing.skinbuilder.SkinButtonIcon;
import flash.display.DisplayObject;
import org.aswing.skinbuilder.SkinTabbedPaneTab;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
class SkinTabbedPaneUI extends BasicTabbedPaneUI   implements GroundDecorator   implements UIResource {
	
	private var contentRoundImageContainer:Sprite;
	private var top_contentRoundImage:DisplayObject;
	private var bottom_contentRoundImage:DisplayObject;
	private var left_contentRoundImage:DisplayObject;
	private var right_contentRoundImage:DisplayObject;
	private var contentRoundImageSetPlacement:Int;
		
	public function new(){
		super();
		contentRoundImageContainer = AsWingUtils.createSprite(null, "contentRoundImageContainer");
	}
	
	override private function installDefaults():Void{
		super.installDefaults();
		
		top_contentRoundImage = flash.Lib.as( getInstance(getPropertyPrefix() + "top.contentRoundImage") , DisplayObject);
		contentRoundImageContainer.addChild(top_contentRoundImage);
		contentRoundImageSetPlacement = JTabbedPane.TOP;
		
		bottom_contentRoundImage = flash.Lib.as( getInstance(getPropertyPrefix() + "bottom.contentRoundImage") , DisplayObject);
		left_contentRoundImage = flash.Lib.as( getInstance(getPropertyPrefix() + "left.contentRoundImage"), DisplayObject);
		right_contentRoundImage = flash.Lib.as( getInstance(getPropertyPrefix() + "right.contentRoundImage") , DisplayObject);
		
		tabbedPane.setBackgroundDecorator(this);
	}
	
	override private function uninstallDefaults():Void{
		super.uninstallDefaults();
		if(contentRoundImageContainer.numChildren > 0){
			contentRoundImageContainer.removeChildAt(0);
		}

		while(tabs.length > 0){
			var header:Tab = flash.Lib.as(tabs.pop(),Tab);
			tabBarMC.removeChild(header.getTabComponent());
		}
	}
    
	override private function createNextButton():AbstractButton{
		var b:JButton = new JButton();
		b.setIcon(new SkinButtonIcon(-1, -1, getPropertyPrefix() + "arrowRight.", tabbedPane));
		b.setBackgroundDecorator(null);
		return b;
	}
	
	override private function createPrevButton():AbstractButton{
		var b:JButton = new JButton();
		b.setIcon(new SkinButtonIcon(-1, -1, getPropertyPrefix() + "arrowLeft.", tabbedPane));
		b.setBackgroundDecorator(null);
		return b;
	}

	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):Void{}
	public function getDisplay(c:Component):DisplayObject{
		return contentRoundImageContainer;
	}
	
    override private function drawBaseLine(tabBarBounds:IntRectangle, g:Graphics2D, fullB:IntRectangle, selTabB:IntRectangle):Void{
    	var b:IntRectangle = tabBarBounds.clone();
    	var placement:Int= tabbedPane.getTabPlacement();
    	
    	var contentRoundImage:DisplayObject;
		if(placement == JTabbedPane.TOP){
			contentRoundImage = top_contentRoundImage;
		}else if(placement == JTabbedPane.BOTTOM){
			contentRoundImage = bottom_contentRoundImage;
		}else if(placement == JTabbedPane.LEFT){
			contentRoundImage = left_contentRoundImage;
		}else{
			contentRoundImage = right_contentRoundImage;
		}
		
    	if(contentRoundImage.parent != contentRoundImageContainer){
    		contentRoundImageContainer.removeChildAt(0);
    		contentRoundImageContainer.addChild(contentRoundImage);
    	}
    	
    	if(isTabHorizontalPlacing()){
    		var isTop:Bool= (placement == JTabbedPane.TOP);
    		if(isTop)	{
    			b.y = b.y + b.height - contentMargin.top;
    		}
    		b.height = contentMargin.top;
    		b.width = fullB.width;
    		b.x = fullB.x;
			if(isTop)	{
				contentRoundImage.x = b.x;
				contentRoundImage.y = b.y;
				contentRoundImage.width = fullB.width;
				contentRoundImage.height = fullB.rightBottom().y - b.y;
			}else{
				contentRoundImage.x = fullB.x;
				contentRoundImage.y = fullB.y;
				contentRoundImage.width = fullB.width;
				contentRoundImage.height = b.y+b.height-fullB.y;
			}
    	}else{
    		var isLeft:Bool= (placement == JTabbedPane.LEFT);
    		if(isLeft)	{
    			b.x = b.x + b.width - contentMargin.top;
    		}
    		b.width = contentMargin.top;
    		b.height = fullB.height;
    		b.y = fullB.y;
			if(isLeft)	{
				contentRoundImage.x = b.x;
				contentRoundImage.y = b.y;
				contentRoundImage.width = fullB.rightTop().x-b.x;
				contentRoundImage.height = b.height;
			}else{
				contentRoundImage.x = fullB.x;
				contentRoundImage.y = fullB.y;
				contentRoundImage.width = b.x+b.width-fullB.x;
				contentRoundImage.height = b.height;
			}
    	}
    }    
    
    override private function drawTabBorderAt(index:Int, b:IntRectangle, paneBounds:IntRectangle, g:Graphics2D):Void{
    	var placement:Int= tabbedPane.getTabPlacement();
    	b = b.clone();//make a clone to be safty modification
    	if(index == tabbedPane.getSelectedIndex()){
    		if(isTabHorizontalPlacing()){
    			b.x -= selectedTabExpandInsets.left;
    			b.width += (selectedTabExpandInsets.left + selectedTabExpandInsets.right);
	    		b.height += Math.round(topBlankSpace/2+contentRoundLineThickness);
    			if(placement == JTabbedPane.BOTTOM){
	    			b.y -= contentRoundLineThickness;
    			}else{
	    			b.y -= Math.round(topBlankSpace/2);
    			}
    		}else{
    			b.y -= selectedTabExpandInsets.left;
    			b.height += (selectedTabExpandInsets.left + selectedTabExpandInsets.right);
	    		b.width += Math.round(topBlankSpace/2+contentRoundLineThickness);
    			if(placement == JTabbedPane.RIGHT){
	    			b.x -= contentRoundLineThickness;
    			}else{
	    			b.x -= Math.round(topBlankSpace/2);
    			}
    		}
    	}
    	//This is important, should call this in sub-implemented drawTabBorderAt method
    	setDrawnTabBounds(index, b, paneBounds);
		var tab:SkinTabbedPaneTab = flash.Lib.as(getTab(index), SkinTabbedPaneTab);
		tab.setTabPlacement(placement);
    }
	
	override private function drawTabAt(index:Int, bounds:IntRectangle, paneBounds:IntRectangle, g:Graphics2D, transformedTabMargin:Insets):Void{
		//trace("drawTabAt : " + index + ", bounds : " + bounds + ", g : " + g);
		drawTabBorderAt(index, bounds, paneBounds, g);
		
		var tab:Tab = getTab(index);
		tab.setSelected(index == tabbedPane.getSelectedIndex());
		var tc:Component = tab.getTabComponent();
		tc.setComBounds(getDrawnTabBounds(index));
		if(index == tabbedPane.getSelectedIndex()){
			if (tc.parent.contains(topTabCom)){
				tc.parent.swapChildren(tc, topTabCom);
			}
			topTabCom = tc;
		}
	}
	
    override private function createNewTab():Tab{
    	var tab:Tab = super.createNewTab();
    	topTabCom = tab.getTabComponent();
    	return tab;
    }
    	
    override private function setTabMarginProperty(tab:Tab, margin:Insets):Void{
    	tab.setMargin(margin);
    }
	
	override private function __onSelectionChanged(e:InteractiveEvent):Void{
		tabbedPane.revalidate();
		tabbedPane.paintImmediately();
	}  
}