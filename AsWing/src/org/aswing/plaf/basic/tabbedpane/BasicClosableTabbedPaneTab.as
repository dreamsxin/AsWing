package org.aswing.plaf.basic.tabbedpane{

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.events.Event;

import org.aswing.*;
import org.aswing.border.EmptyBorder;
import org.aswing.event.InteractiveEvent;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

/**
 * The basic imp for ClosableTab
 * @author iiley
 */
public class BasicClosableTabbedPaneTab implements ClosableTab, GroundDecorator, UIResource{
	
	protected var panel:Container;
	protected var label:JButton;
	protected var button:AbstractButton;
	protected var margin:Insets;
	protected var owner:Component;
	protected var placement:int;
	protected var shape:Shape;
	
	public function BasicClosableTabbedPaneTab(){
		super();
		shape = new Shape();
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void{
		shape.graphics.clear();
		if(owner){
			c = owner;
		}
		b = margin.getOutsideBounds(b);
		var btn:AbstractButton = label;
		if(btn){
			var model:ButtonModel = btn.getModel();
			var isPressing:Boolean = model.isPressed() || model.isSelected();
			g = new Graphics2D(shape.graphics);
			var cl:ASColor = c.getMideground();
			var style:StyleResult;
			var adjuster:StyleTune = c.getStyleTune().mide.clone();
			if(!c.isEnabled()){
				adjuster = adjuster.sharpen(0.4);
			}else if(isPressing){
				cl = cl.offsetHLS(0, 0.08, 0);
			}else if(model.isRollOver()){
				cl = cl.offsetHLS(-0.2, 0, 0.37);
				//cl = cl.offsetHLS(0, 0.08, 0);
			}
			style = new StyleResult(cl, adjuster);
			if(isPressing){
				style.cdark = style.cdark.changeAlpha(0);
			}
			var direction:Number = Math.PI/2;
			var matrixB:IntRectangle = b.clone();
			b = b.clone();
			
			var placement:int = getTabPlacement();
			var highlightBrush:SolidBrush = new SolidBrush(style.clight.offsetHLS(0, 0.14, 0.1));
			if(placement == JTabbedPane.TOP){
				direction = Math.PI/2;
				b.height += style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round*2 > 0){
					g.fillRectangle(highlightBrush, b.x+style.round, b.y+1, b.width - style.round*2, 1);
				}
			}else if(placement == JTabbedPane.BOTTOM){
				direction = -Math.PI/2;
				b.height += style.round*2;
				b.y -= style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.width - style.round*2 > 0){
					g.fillRectangle(highlightBrush, b.x+style.round, b.y+b.height-2, b.width - style.round*2, 1);
				}
			}else if(placement == JTabbedPane.LEFT){
				direction = 0;
				b.width += style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round*2 > 0){
					g.fillRectangle(highlightBrush, 
						b.x+1, b.y+style.round, 1, b.height - style.round*2);
				}
			}else{//right				
				direction = Math.PI;
				b.width += style.round*2;
				b.x -= style.round*2;
				BasicGraphicsUtils.fillGradientRoundRect(g, b, style, direction, false, matrixB);
				BasicGraphicsUtils.drawGradientRoundRectLine(g, b, 1, style, direction, true, matrixB);
				if(b.height - style.round*2 > 0){
					g.fillRectangle(highlightBrush, 
						b.x+b.width-2, b.y+style.round, 1, b.height - style.round*2);
				}
			}
		}
	}
	
	//---------------------
	
	public function initTab(owner:Component):void{
		this.owner = owner;
		panel = new Container();
		panel.setLayout(new BorderLayout());
		label = new JButton();
		label.setOpaque(false);
		label.setBackgroundDecorator(null);
		label.setMargin(new Insets());
		panel.append(label, BorderLayout.CENTER);
		button = createCloseButton();
		var bc:Container = new Container();
		bc.setLayout(new CenterLayout());
		bc.append(button);
		panel.append(bc, BorderLayout.EAST);
		label.setFocusable(false);
		button.setFocusable(false);
		margin = new Insets(0,0,0,0);
		
		panel.setBackgroundDecorator(this);
		label.addEventListener(InteractiveEvent.STATE_CHANGED, __repaintPanel);
	}
	
	public function setComBounds(b:IntRectangle):void{
		panel.setComBounds(b);
		panel.validate();
		panel.repaint();
	}
	
	protected function __repaintPanel(event:Event):void{
		panel.repaint();
	}
	
	public function setTabPlacement(tp:int):void{	
		placement = tp;
	}
	
	public function getTabPlacement():int{
		return placement;
	}
	
	protected function createCloseButton():AbstractButton{
		var button:AbstractButton = new JButton();
		button.setMargin(new Insets());
		button.setOpaque(false);
		button.setBackgroundDecorator(null);
		button.setIcon(new CloseIcon());
		return button;
	}
	
	public function setFont(font:ASFont):void{
		label.setFont(font);
	}
	
	public function setForeground(color:ASColor):void{
		label.setForeground(color);
	}
	
	public function setMargin(m:Insets):void{
		if(!margin.equals(m)){
			panel.setBorder(new EmptyBorder(null, m));
			margin = m.clone();
		}
	}
	
	public function setEnabled(b:Boolean):void{
		label.setEnabled(b);
		button.setEnabled(b);
	}
	
	public function getCloseButton():Component{
		return button;
	}
	
	public function setVerticalAlignment(alignment:int):void{
		label.setVerticalAlignment(alignment);
	}
	
	public function getTabComponent():Component{
		return panel;
	}
	
	public function setHorizontalTextPosition(textPosition:int):void{
		label.setHorizontalTextPosition(textPosition);
	}
	
	public function setTextAndIcon(text:String, icon:Icon):void{
		label.setText(text);
		label.setIcon(icon);
	}
	
	public function setIconTextGap(iconTextGap:int):void{
		label.setIconTextGap(iconTextGap);
	}
	
	public function setSelected(b:Boolean):void{
		label.setSelected(b);
	}
	
	public function setVerticalTextPosition(textPosition:int):void{
		label.setVerticalTextPosition(textPosition);
	}
	
	public function setHorizontalAlignment(alignment:int):void{
		label.setHorizontalAlignment(alignment);
	}
	
}
}