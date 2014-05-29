package org.aswing.air
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	import org.aswing.*;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	import org.aswing.geom.IntRectangle;

	public class JHTMLLoader extends Component implements Viewportable  
	{
		
		public static const AUTO_INCREMENT:int = int.MIN_VALUE;
		private var htmlLoader:HTMLLoader;
		private var viewPos:IntPoint;
		private var viewportSizeTesting:Boolean;
		private var lastMaxScrollV:int;
		private var lastMaxScrollH:int;
			
		private var verticalUnitIncrement:int;
		private var verticalBlockIncrement:int;
		private var horizontalUnitIncrement:int;
		private var horizontalBlockIncrement:int;
		

		public function JHTMLLoader(url:String):void
		{
			super();
			viewPos = new IntPoint();
			viewportSizeTesting = false;			

			
			verticalUnitIncrement = AUTO_INCREMENT;
			verticalBlockIncrement = AUTO_INCREMENT;
			horizontalUnitIncrement = AUTO_INCREMENT;
			horizontalBlockIncrement = AUTO_INCREMENT;
			
			htmlLoader = new HTMLLoader();
			//htmlLoader.runtimeApplicationDomain = ApplicationDomain.currentDomain;
			addChild(htmlLoader);
			htmlLoader.addEventListener(Event.SCROLL, __onTextAreaTextScroll);
			
			
			htmlLoader.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP,__onNativeDargEnter);
			htmlLoader.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER,__onNativeDargEnter);
			
			var req:URLRequest = new URLRequest(url);
			htmlLoader.load(req);

		}
		private function __onNativeDargEnter(e:NativeDragEvent):void
		{
			e.preventDefault();
		}
		override protected function size():void{
			super.size();
			applyBoundsToHtml(getPaintBounds());
		}
	    override public function getInternalFocusObject():InteractiveObject{
	    	return getHTMLLoader();
	    }
		
		override protected function paint(b:IntRectangle):void{
			super.paint(b);
			applyBoundsToHtml(b);
		}
		
	    protected function applyBoundsToHtml(b:IntRectangle):void{
			var t:HTMLLoader = getHTMLLoader();
			t.x = b.x;
			t.y = b.y;
			t.width = b.width;
			t.height = b.height;
	    }	
		public function getHTMLLoader():HTMLLoader
		{
			
			return htmlLoader;
		}
	    
		protected function fireStateChanged(programmatic:Boolean=true):void{
			dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
		}
		override protected function countPreferredSize():IntDimension{
			var size:IntDimension;
			var width:int = getHTMLLoader().contentWidth;
			var height:int = getHTMLLoader().contentHeight;
			size = new IntDimension(width, height);
			return getInsets().getOutsideSize(size);
		}	
		private function __onTextAreaTextScroll(e:Event):void{
	    	if(viewportSizeTesting){
	    		return;
	    	}
	    	var t:HTMLLoader = getHTMLLoader();
			var newViewPos:IntPoint = new IntPoint(t.scrollH, t.scrollV);
			if(!getViewPosition().equals(newViewPos)){
				viewPos.setLocation(newViewPos);
				//notify scroll bar to syn
				fireStateChanged(true);
			}
			revalidate();
			/*
			if(lastMaxScrollV != t.maxScrollV || lastMaxScrollH != t.maxScrollH){
				lastMaxScrollV = t.maxScrollV;
				lastMaxScrollH = t.maxScrollH;
				revalidate();
			}
			*/
		}
	    protected function validateScroll():void{
			var xS:int = viewPos.x;
			var yS:int = viewPos.y;
	    	var t:HTMLLoader = getHTMLLoader();
			if(t.scrollH != xS){
				t.scrollH = xS;
			}
			if(t.scrollV != yS){
				t.scrollV = yS;
			}
			//t.background = false; //avoid TextField background lose effect bug
	    }

		public function getVerticalUnitIncrement():int
		{
	    	if(verticalUnitIncrement == AUTO_INCREMENT){
	    		return 1;
	    	}else{
	    		return verticalUnitIncrement;
	    	}
		}
		
		public function getVerticalBlockIncrement():int
		{
	    	if(verticalBlockIncrement == AUTO_INCREMENT){
	    		return 10;
	    	}else{
	    		return verticalBlockIncrement;
	    	}
		}
		
		public function getHorizontalUnitIncrement():int
		{
	    	if(verticalUnitIncrement == AUTO_INCREMENT){
	    		return 1;
	    	}else{
	    		return verticalUnitIncrement;
	    	}
		}
		
		public function getHorizontalBlockIncrement():int
		{
	    	if(horizontalBlockIncrement == AUTO_INCREMENT){
	    		return 10;
	    	}else{
	    		return horizontalBlockIncrement;
	    	}
		}
		
		public function setVerticalUnitIncrement(increment:int):void
		{
	    	if(verticalUnitIncrement != increment){
	    		verticalUnitIncrement = increment;
				fireStateChanged();
	    	}
		}
		
		public function setVerticalBlockIncrement(increment:int):void
		{
	    	if(verticalBlockIncrement != increment){
	    		verticalBlockIncrement = increment;
				fireStateChanged();
	    	}
		}
		
		public function setHorizontalUnitIncrement(increment:int):void
		{
	    	if(horizontalUnitIncrement != increment){
	    		horizontalUnitIncrement = increment;
				fireStateChanged();
	    	}
		}
		
		public function setHorizontalBlockIncrement(increment:int):void
		{
	    	if(horizontalBlockIncrement != increment){
	    		horizontalBlockIncrement = increment;
				fireStateChanged();
	    	}
		}

		
		public function setViewportTestSize(s:IntDimension):void
		{
	    	viewportSizeTesting = true;
	    	setSize(s);
	    	validateScroll();
	    	viewportSizeTesting = false;
		}
		
		public function getExtentSize():IntDimension
		{
			var s:IntDimension = getInsets().getInsideSize(getSize());
			
			
	    	var t:HTMLLoader = getHTMLLoader();
			var extentVer:int = s.height;
			var extentHor:int = s.width;
	    	//return new IntDimension(extentHor, extentVer);
	    	return s;
		}
		
		public function getViewSize():IntDimension
		{
			var t:HTMLLoader = getHTMLLoader();
			return new IntDimension(t.contentWidth, t.contentHeight);
		}
		
		public function getViewPosition():IntPoint
		{
			return viewPos.clone();
		}
		
		public function setViewPosition(p:IntPoint, programmatic:Boolean=true):void
		{
			if(!viewPos.equals(p)){
				restrictionViewPos(p);
				if(viewPos.equals(p)){
					return;
				}
				viewPos.setLocation(p);
				validateScroll();
				fireStateChanged(programmatic);
			}
		}
		public function scrollToBottomLeft():void{
			setViewPosition(new IntPoint(0, int.MAX_VALUE));
		}
		/**
		 * Scrolls to view bottom right content. 
		 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
		 * if it is located in a <code>JScrollPane</code>.
		 */	
		public function scrollToBottomRight():void{
			setViewPosition(new IntPoint(int.MAX_VALUE, int.MAX_VALUE));
		}
		/**
		 * Scrolls to view top left content. 
		 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
		 * if it is located in a <code>JScrollPane</code>.
		 */	
		public function scrollToTopLeft():void{
			setViewPosition(new IntPoint(0, 0));
		}
		/**
		 * Scrolls to view to right content. 
		 * This will make the scrollbars of <code>JScrollPane</code> scrolled automatically, 
		 * if it is located in a <code>JScrollPane</code>.
		 */	
		public function scrollToTopRight():void{
			setViewPosition(new IntPoint(int.MAX_VALUE, 0));
		}	    
	
		public function scrollRectToVisible(contentRect:IntRectangle, programmatic:Boolean=true):void
		{
			setViewPosition(new IntPoint(contentRect.x, contentRect.y), programmatic);
		}
		
		public function addStateListener(listener:Function, priority:int=0.0, useWeakReference:Boolean=false):void
		{
			
			addEventListener(InteractiveEvent.STATE_CHANGED, listener, false, priority);
		}
		
		public function removeStateListener(listener:Function):void
		{
			removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
		}
		
		public function getViewportPane():Component
		{
			return this;
		}
		
		protected function restrictionViewPos(p:IntPoint):IntPoint{
			var maxPos:IntPoint = getViewMaxPos();
			p.x = Math.max(0, Math.min(maxPos.x, p.x));
			p.y = Math.max(0, Math.min(maxPos.y, p.y));
			return p;
		}
		
		private function getViewMaxPos():IntPoint{
			var showSize:IntDimension = getExtentSize();
			var viewSize:IntDimension = getViewSize();
			var p:IntPoint = new IntPoint(viewSize.width-showSize.width, viewSize.height-showSize.height);
			if(p.x < 0) p.x = 0;
			if(p.y < 0) p.y = 0;
			return p;
		}
		
		
	}
}