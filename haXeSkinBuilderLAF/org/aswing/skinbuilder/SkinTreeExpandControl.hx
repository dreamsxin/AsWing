package org.aswing.skinbuilder;


import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.geom.Matrix;

import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.BitmapBrush;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.tree.ExpandControl;
import org.aswing.tree.TreePath;

class SkinTreeExpandControl extends DefaultsDecoratorBase   implements ExpandControl   implements UIResource {
	
	private var leafControlImage:DisplayObject;
	private var folderExpandedControlImage:DisplayObject;
	private var folderCollapsedControlImage:DisplayObject;
	private   var loaded:Bool;
	private var leafBitmapBuffer:BitmapData;
	private var expandedBitmapBuffer:BitmapData;
	private var collapsedBitmapBuffer:BitmapData;
	
	public function new(){
		loaded=false;
			leafBitmapBuffer = new BitmapData(1, 1, true, 0x00000000);
		expandedBitmapBuffer = new BitmapData(1, 1, true, 0x00000000);
		collapsedBitmapBuffer = new BitmapData(1, 1, true, 0x00000000);
		super();
	}
	
	public function paintExpandControl(c:Component, g:Graphics2D, bounds:IntRectangle, 
		totalChildIndent:Int, path:TreePath, row:Int, expanded:Bool, leaf:Bool):Void{
		if(loaded!=true){
			var ui:ComponentUI = getDefaultsOwner(c);
			leafControlImage = flash.Lib.as(ui.getInstance("Tree.leafControlImage") , DisplayObject);
			folderExpandedControlImage =flash.Lib.as( ui.getInstance("Tree.folderExpandedControlImage") , DisplayObject);
			folderCollapsedControlImage = flash.Lib.as(ui.getInstance("Tree.folderCollapsedControlImage") , DisplayObject);
			loaded = true;
		}
		
		var x:Int= bounds.x - totalChildIndent;
		var y:Int= bounds.y;
		var w:Int= bounds.width;
		var h:Int= bounds.height;
		var matrix:Matrix = new Matrix();
		matrix.translate(x, y);
		if(leaf)	{
			w = Std.int(leafControlImage.width);
			if(w != leafBitmapBuffer.width || h != leafBitmapBuffer.height){
				leafControlImage.width = w;
				leafControlImage.height = h;
				leafBitmapBuffer = new BitmapData(w, h, true, 0x00000000);
				leafBitmapBuffer.draw(leafControlImage);
			}
			g.beginFill(new BitmapBrush(leafBitmapBuffer, matrix, false));
		}else if(expanded)	{
			w = Std.int(folderExpandedControlImage.width);
			if(w != expandedBitmapBuffer.width || h != expandedBitmapBuffer.height){
				folderExpandedControlImage.width = w;
				folderExpandedControlImage.height = h;
				expandedBitmapBuffer = new BitmapData(w, h, true, 0x00000000);
				expandedBitmapBuffer.draw(folderExpandedControlImage);
			}
			g.beginFill(new BitmapBrush(expandedBitmapBuffer, matrix, false));
		}else{
			w = Std.int(folderCollapsedControlImage.width);
			if(w != collapsedBitmapBuffer.width || h != collapsedBitmapBuffer.height){
				folderCollapsedControlImage.width = w;
				folderCollapsedControlImage.height = h;
				collapsedBitmapBuffer = new BitmapData(w, h, true, 0x00000000);
				collapsedBitmapBuffer.draw(folderCollapsedControlImage);
			}
			g.beginFill(new BitmapBrush(collapsedBitmapBuffer, matrix, false));
		}
		g.rectangle(x, y, w, h);
		g.endFill();
	}
	
}