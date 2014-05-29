/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Shape;
import org.aswing.plaf.basic.BasicSliderUI;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import flash.errors.Error;
class SkinSliderUI extends BasicSliderUI{
	
	private var vertical_trackImage:DisplayObject;
	private var vertical_trackDisabledImage:DisplayObject;
	private var vertical_trackProgressImage:DisplayObject;
	private var vertical_trackProgressDisabledImage:DisplayObject;
	
	private var horizontal_trackImage:DisplayObject;
	private var horizontal_trackDisabledImage:DisplayObject;
	private var horizontal_trackProgressImage:DisplayObject;
	private var horizontal_trackProgressDisabledImage:DisplayObject;
	
	private var trackContainer:Sprite;
	private var progressContainer:Sprite;
	private var thumIconSize:IntDimension;
	private var trackOriginalLength:Int;
	
	public function new(){
		super();
	}
	
	override private function installComponents():Void{
		progressCanvas = new Shape();//to make super class runnable
		var pp:String= getPropertyPrefix();
		vertical_trackImage =  flash.Lib.as(getInstance(pp+"vertical.trackImage") , DisplayObject);
		vertical_trackDisabledImage =  flash.Lib.as(getInstance(pp+"vertical.trackDisabledImage") , DisplayObject);
		vertical_trackProgressImage =  flash.Lib.as(getInstance(pp+"vertical.trackProgressImage") , DisplayObject);
		vertical_trackProgressDisabledImage =  flash.Lib.as(getInstance(pp+"vertical.trackProgressDisabledImage") , DisplayObject);
		horizontal_trackImage =  flash.Lib.as(getInstance(pp+"horizontal.trackImage") , DisplayObject);
		horizontal_trackDisabledImage = flash.Lib.as( getInstance(pp+"horizontal.trackDisabledImage") ,DisplayObject);
		horizontal_trackProgressImage = flash.Lib.as( getInstance(pp+"horizontal.trackProgressImage") ,DisplayObject);
		horizontal_trackProgressDisabledImage = flash.Lib.as( getInstance(pp+"horizontal.trackProgressDisabledImage") , DisplayObject);
		
		trackOriginalLength =Std.int( horizontal_trackImage.width);
		
		trackContainer = AsWingUtils.createSprite(null, "trackContainer");
		progressContainer = AsWingUtils.createSprite(null, "progressContainer");
		slider.addChild(trackContainer);
		slider.addChild(progressContainer);
		
		thumbIcon = getIcon(pp+"thumbIcon");
		var thumbAsset:DisplayObject = thumbIcon.getDisplay(slider);
		if(thumbAsset == null){
			throw new Error("Slider thumb icon must has its own display object(getDisplay()!=null)!");
		}
		slider.addChild(thumbAsset);
		thumIconSize = new IntDimension(thumbIcon.getIconWidth(slider), thumbIcon.getIconHeight(slider));
	}
	
	override private function uninstallComponents():Void{
		slider.removeChild(trackContainer);
		slider.removeChild(progressContainer);
		slider.removeChild(thumbIcon.getDisplay(slider));
		progressCanvas = null;
	}
	

	override private function getPrefferedLength():Int{
		return trackOriginalLength;
	}
		
	override private function getThumbSize():IntDimension{
		if(isVertical()){
			return new IntDimension(thumIconSize.height, thumIconSize.width);
		}else{
			return new IntDimension(thumIconSize.width, thumIconSize.height);
		}
	}
	
	override private function countTrackRect(b:IntRectangle):Void{
		var thumbSize:IntDimension = getThumbSize();
		var drawRect:IntRectangle;
		var left:Int= Std.int(thumIconSize.width/2);
		var mwidth:Int= thumIconSize.width;
		if(isVertical()){
			trackDrawRect.setRectXYWH(b.x, b.y, 
				thumbSize.width, b.height);
			trackRect.setRectXYWH(b.x, b.y+left, 
				thumbSize.width, b.height-mwidth);
		}else{
			trackDrawRect.setRectXYWH(b.x, b.y, 
				b.width, thumbSize.height);
			trackRect.setRectXYWH(b.x+left, b.y, 
				b.width-mwidth, thumbSize.height);
		}
	}
	
	override private function paintThumb(g:Graphics2D, drawRect:IntRectangle):Void{
		thumbIcon.updateIcon(slider, g, drawRect.x, drawRect.y);
	}

	override private function paintTrack(g:Graphics2D, drawRect:IntRectangle):Void{
		trackContainer.visible = slider.getPaintTrack();
		if(trackContainer.visible!=true){
			return;
		}
		if(trackContainer.numChildren > 0){
			trackContainer.removeChildAt(0);
		}
		var tImage:DisplayObject;
		if(slider.isEnabled()){
			if(isVertical()){
				tImage = vertical_trackImage;
			}else{
				tImage = horizontal_trackImage;
			}
		}else{
			if(isVertical()){
				tImage = vertical_trackDisabledImage;
			}else{
				tImage = horizontal_trackDisabledImage;
			}
		}
		trackContainer.addChild(tImage);
		trackContainer.x = drawRect.x;
		trackContainer.y = drawRect.y;
		tImage.width = drawRect.width;
		tImage.height = drawRect.height;
		paintTrackProgress(null, drawRect);
	}
	
	override private function paintTrackProgress(g:Graphics2D, trackDrawRect:IntRectangle):Void{
		progressContainer.visible = slider.getPaintTrack();
		if(progressContainer.visible!=true){
			return;
		}

		if(progressContainer.numChildren > 0){
			progressContainer.removeChildAt(0);
		}
		var tImage:DisplayObject;
		if(slider.isEnabled()){
			if(isVertical()){
				tImage = vertical_trackProgressImage;
			}else{
				tImage = horizontal_trackProgressImage;
			}
		}else{
			if(isVertical()){
				tImage = vertical_trackProgressDisabledImage;
			}else{
				tImage = horizontal_trackProgressDisabledImage;
			}
		}
		progressContainer.addChild(tImage);
				
		var rect:IntRectangle = trackRect.clone();
		var width:Int;
		var height:Int;
		var x:Int;
		var y:Int;
		var inverted:Bool= slider.getInverted();
		if(isVertical()){
			width = rect.width;
			height = Std.int(thumbRect.y + thumbRect.height/2 - rect.y);
			x = rect.x;
			if(inverted)	{
				y = rect.y;
			}else{
				height = Std.int(rect.y + rect.height - thumbRect.y - thumbRect.height/2);
				y = Std.int(thumbRect.y + thumbRect.height/2);
			}
		}else{
			height = rect.height;
			if(inverted)	{
				width = Std.int(rect.x + rect.width - thumbRect.x - thumbRect.width/2);
				x = Std.int(thumbRect.x + thumbRect.width/2);
			}else{
				width =Std.int( thumbRect.x + thumbRect.width/2 - rect.x);
				x = rect.x;
			}
			y = rect.y;
		}
		progressContainer.x = x;
		progressContainer.y = y;
		tImage.width = width;
		tImage.height = height;		
	}	
}