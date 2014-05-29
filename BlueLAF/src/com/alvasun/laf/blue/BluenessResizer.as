package com.alvasun.laf.blue {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import org.aswing.Cursor;
	import org.aswing.resizer.DefaultResizer;
	
	/**
	 * 窗口缩放器。
	 *  
	 * @author AlvaSun
	 * 
	 */	
	public class BluenessResizer extends DefaultResizer {
		
		private static const H : uint = 1;
		private static const V : uint = 2;
		private static const HV : uint = 3;
		
		private var h : DisplayObject;
		private var v : DisplayObject;
		private var hv : DisplayObject;
		
		private var resizeArrowCursorDOC : DisplayObjectContainer;
		
		public function BluenessResizer() {
		}
		
		//根据选择角度不同，显示对应的箭头
		override public function setArrowRotation(r : Number) : void {
			switch(r) {
				case 90:
					resizeArrowCursor.rotation = 0;
					showCursorAt(V);
					break;
				
				case 45:
					resizeArrowCursor.rotation = 0;
					showCursorAt(HV);
					break;
					
				case -45:
					resizeArrowCursor.rotation = 90;
					showCursorAt(HV);
					break;
					
				case 0:
				default:
					resizeArrowCursor.rotation = 0;
					showCursorAt(H);
					break;
			}
		}
		
		override protected function createResizeMCs() : void {
			super.createResizeMCs();
			//应该有8种情形
			//resizeArrowCursor
			h = Cursor.createCursor(Cursor.H_RESIZE_CURSOR);
			v = Cursor.createCursor(Cursor.V_RESIZE_CURSOR);
			hv = Cursor.createCursor(Cursor.HV_RESIZE_CURSOR);
			resizeArrowCursorDOC = new Sprite();
			resizeArrowCursorDOC.name = "resizeCursor";
			resizeArrowCursor = resizeArrowCursorDOC;
			
			resizeArrowCursorDOC.addChild(h);
			resizeArrowCursorDOC.addChild(v);
			resizeArrowCursorDOC.addChild(hv);
			showCursorAt(0);
		}
		
		private function showCursorAt(index : uint) : void {
			h.visible = index == H;
			v.visible = index == V;
			hv.visible = index == HV;
		}

	}
}