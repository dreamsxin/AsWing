/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
 	import org.aswing.geom.IntRectangle;
	import org.aswing.JScrollBar;
	import org.aswing.Insets;
	import org.aswing.geom.IntDimension;
	import org.aswing.JButton;
	import org.aswing.Component;
	import org.aswing.skinbuilder.SkinButtonIcon; 
	import org.aswing.plaf.basic.BasicScrollBarUI;
class SkinScrollBarUI extends BasicScrollBarUI{
	
	private var scrollBarHeight:Int;
	
	public function new(){
		super();
	}
	
    override private function createArrowButton():JButton{
		var b:JButton = new JButton();
		b.setFocusable(false);
		b.setOpaque(false);
		b.setBackgroundDecorator(null);
		b.setBorder(null);
		b.setMargin(new Insets());
		return b;
    }	

	override private function createIcons():Void{
		var pp:String= getPropertyPrefix();
    	leftIcon = new SkinButtonIcon(-1, -1, pp+"arrowLeft.", scrollbar);
    	rightIcon = new SkinButtonIcon(-1, -1, pp+"arrowRight.", scrollbar);
    	upIcon = new SkinButtonIcon(-1, -1, pp+"arrowUp.", scrollbar);
    	downIcon = new SkinButtonIcon(-1, -1, pp+"arrowDown.", scrollbar);
    	
    	scrollBarWidth = upIcon.getIconWidth(scrollbar);
    	scrollBarHeight = upIcon.getIconHeight(scrollbar);
    }
    //--------------------------Dimensions----------------------------
    
    override public function getPreferredSize(c:Component):IntDimension{
		var w:Int, h:Int;
		if(isVertical()){
			w = scrollBarWidth;
			h = scrollBarHeight*2;
		}else{
			w = scrollBarHeight*2;
			h = scrollBarWidth;
		}
		return scrollbar.getInsets().getOutsideSize(new IntDimension(w, h));
    }

    override public function getMaximumSize(c:Component):IntDimension{
		var w:Int, h:Int;
		if(isVertical()){
			w = scrollBarWidth;
			h = 100000;
		}else{
			w = 100000;
			h = scrollBarWidth;
		}
		return scrollbar.getInsets().getOutsideSize(new IntDimension(w, h));
    }

    override public function getMinimumSize(c:Component):IntDimension{
		return getPreferredSize(c);
    }
	
	//--------------------------Layout----------------------------
	override private function layoutVScrollbar(sb:JScrollBar):Void{
    	var rd:IntRectangle = sb.getPaintBounds();
    	var w:Int= scrollBarWidth;
		var h:Int= scrollBarHeight;
    	decrButton.setComBoundsXYWH(rd.x, rd.y, w, h);
    	incrButton.setComBoundsXYWH(rd.x, Std.int(rd.y + rd.height - h), w, h);
	}
	
	override private function layoutHScrollbar(sb:JScrollBar):Void{
    	var rd:IntRectangle = sb.getPaintBounds();
    	var w:Int= scrollBarWidth;
		var h:Int= scrollBarHeight;
    	decrButton.setComBoundsXYWH(rd.x, rd.y, h, w);
    	incrButton.setComBoundsXYWH(Std.int(rd.x + rd.width - h), rd.y, h, w);
	}
}