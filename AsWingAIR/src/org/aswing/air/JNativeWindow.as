package org.aswing.air
{
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.aswing.AsWingManager;
	import org.aswing.JWindow;
	import org.aswing.geom.IntDimension;
	public class JNativeWindow extends JWindow
	{
		private var nativeWindow:NativeWindow;
		private var ignoreNativeResize:Boolean;
		public function JNativeWindow(win:NativeWindow=null,modal:Boolean=false)
		{
			
			if(win)
			{
				setNativeWindow(win);
			}
			else
			{
				var ops:NativeWindowInitOptions = new NativeWindowInitOptions();
				ops.systemChrome = NativeWindowSystemChrome.NONE;
				ops.transparent = true;
				ops.type = NativeWindowType.LIGHTWEIGHT;
				setNativeWindow(new NativeWindow(ops));
			}

			super(nativeWindow.stage, modal);
			super.setSize(new IntDimension(nativeWindow.width,nativeWindow.height));
			
			
			var t:int = this.getMinimumWidth();
			this.show();



			nativeWindow.visible = true;
			nativeWindow.activate();

		}
		public override function setName(name:String):void
		{
			if(AsWingManager.getRoot() == this)
			{
					
					//isRoot
			}
			else
				super.setName(name);
		}
		private function setNativeWindow(win:NativeWindow):void
		{
			nativeWindow = win;
	        nativeWindow.stage.align = StageAlign.TOP_LEFT;
	        nativeWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			var rect:Rectangle = Screen.mainScreen.visibleBounds;
			nativeWindow.maxSize = new Point(rect.width,rect.height);
			nativeWindow.minSize = new Point(0,0);
			nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE,__onResize);
		}
		private function __onResize(e:NativeWindowBoundsEvent):void
		{
			if(!ignoreNativeResize)
				super.setSize(new IntDimension(e.afterBounds.width,e.afterBounds.height));
		}
		public function getNativeWindow():NativeWindow
		{
			return nativeWindow;
		}
	    public override function setVisible(v:Boolean):void
	    {
	    	super.setVisible(v);
	    	this.nativeWindow.visible = v;
	    }
	    
	    public override function setSize(newSize:IntDimension):void
	    {
	    	ignoreNativeResize = true;
	    	nativeWindow.width = newSize.width;
	    	nativeWindow.height = newSize.height;
	    	ignoreNativeResize = false;
	    	super.setSize(new IntDimension(nativeWindow.width,nativeWindow.height));
	    }
	    public override function getX():int
	    {
	    	return nativeWindow.x;
	    }
	    public override function getY():int
	    {
	    	return nativeWindow.y;
	    }
	    public override function setX(x:int):void
	    {
	    	nativeWindow.x = x;
	    }
	    public override function setY(y:int):void
	    {
	    	nativeWindow.y = y;
	    }
	    public override function startDrag(lockCenter:Boolean=false, bounds:Rectangle=null):void
	    {
	    	nativeWindow.startMove();
	    }
	    public override function stopDrag():void
	    {
	    	nativeWindow.activate();
	    }
	}
}