package org.aswing.air
{
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Screen;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.aswing.AsWingManager;
	import org.aswing.JFrame;
	import org.aswing.event.AWEvent;
	import org.aswing.event.FrameEvent;
	import org.aswing.geom.IntDimension;

	public class JNativeFrame extends JFrame
	{
		private var nativeWindow:NativeWindow;
		private var ignoreNativeResize:Boolean;
		public function JNativeFrame(win:NativeWindow=null,title:String="", modal:Boolean=false)
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
				
				setNativeWindow(new NativeWindow(ops));
			}

			super(nativeWindow.stage, title, modal);
			super.setSizeWH(nativeWindow.width,nativeWindow.height);
			
			this.show();

			this.getResizer().setEnabled(false);
			this.setDragable(false);
			this.getTitleBar().getSelf().addEventListener(MouseEvent.MOUSE_DOWN,__onTitleBarMouseDown);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onResizeCommand);
			this.addEventListener(FrameEvent.FRAME_CLOSING, onClosing);
			this.setTitle(title);
			
			this.setSize(new IntDimension(nativeWindow.width,nativeWindow.height));

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
			
			nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE,__onResize);
		}
		public function getNativeWindow():NativeWindow
		{
			return nativeWindow;
		}
		private function __onTitleBarMouseDown(e:MouseEvent):void
		{
			nativeWindow.startMove();
			e.stopImmediatePropagation();
			e.stopPropagation();
		}
		private function __onTitleBarDbClick(e:MouseEvent):void
		{
			if(this.getState() == JFrame.NORMAL)
			{
				nativeWindow.maximize();
				this.setState(JFrame.MAXIMIZED, true);
			}
			else
			{
				this.setState(JFrame.NORMAL, true);
				nativeWindow.restore();
			}
			this.getResizer().setEnabled(false);
		}
		
		private function __onTitleBarMinButtonMouseDown(e:AWEvent):void
		{
			nativeWindow.minimize();
		}
		private function __onTitleBarMaxButtonMouseDown(e:AWEvent):void
		{
			
			nativeWindow.maximize();
			this.setState(JFrame.MAXIMIZED, true);
			this.getResizer().setEnabled(false);
			
			

		}
		private function __onTitleBarRestoreButtonMouseDown(e:AWEvent):void
		{
			
			this.setState(JFrame.NORMAL, true);
			nativeWindow.restore();
			this.getResizer().setEnabled(false);

			
			
		}
		private function __onTitleBarCloseButtonMouseDown(e:MouseEvent):void
		{
			
		}
		
		private function __onResize(e:NativeWindowBoundsEvent):void
		{
			if(!ignoreNativeResize)
				super.setSize(new IntDimension(e.afterBounds.width,e.afterBounds.height));
		}

	    private function onResizeCommand(event:MouseEvent):void{
	        var resizeFrom:String = "";
	        if(mouseY < 8){resizeFrom = "T";}
	        else if(mouseY > this.height - 8){resizeFrom = "B";}
	        if(mouseX < 8){resizeFrom += "L";}
	        else if(mouseX > this.width -8){resizeFrom += "R";}

	        	
	        if(resizeFrom)
	        	nativeWindow.startResize(resizeFrom);
	    }
	    private function onClosing(e:FrameEvent):void
	    {
	    	var u:int = this.getDefaultCloseOperation();
	    	if(u == JFrame.DISPOSE_ON_CLOSE)
	    		this.nativeWindow.close();
	    	if(u == JFrame.HIDE_ON_CLOSE)
	    		this.nativeWindow.visible = false;
	    }
	    public override function setTitle(t:String):void
	    {
	    	super.setTitle(t);
	    	nativeWindow.title = t;
	    }
	    public override function setVisible(v:Boolean):void
	    {
	    	super.setVisible(v);
	    	this.nativeWindow.visible = v;
	    }
	    public override function setState(s:int, programmatic:Boolean=true):void
	    {
	    	
	    	switch(s)
	    	{
	    		case JFrame.MAXIMIZED:
	    		{
	    			nativeWindow.maximize();
	    			break;
	    		}
	    		case JFrame.ICONIFIED:
	    		{
	    			nativeWindow.minimize();
	    			return;
	    		}
	    	}
	    	super.setState(s,programmatic);
	    	
	    	if(s == JFrame.NORMAL)
	    		nativeWindow.restore();
	    	this.getResizer().setEnabled(false);
	    }
	    public override function setSize(newSize:IntDimension):void
	    {
	    	if(this.getState() != JFrame.MAXIMIZED)
	    	{
		    	ignoreNativeResize = true;
		    	nativeWindow.width = newSize.width;
		    	nativeWindow.height = newSize.height;
		    	ignoreNativeResize = false;
	    	}
	    	else
	    	{
	    		nativeWindow.maxSize = new Point(newSize.width,newSize.height);
	    	}
	    	super.setSize(newSize);
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