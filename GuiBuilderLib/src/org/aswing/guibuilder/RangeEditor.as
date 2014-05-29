package org.aswing.guibuilder{

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.aswing.Component;
import org.aswing.Cursor;
import org.aswing.CursorManager;
import org.aswing.event.MovedEvent;
import org.aswing.event.ResizedEvent;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntPoint;
import org.aswing.geom.IntRectangle;
import org.aswing.guibuilder.util.Delegate;


public class RangeEditor{
	
	protected var comp:Component;
	
	protected var resizeArrowCursor:DisplayObject;
	protected var moveArrowCursor:DisplayObject;
	
	protected var editorMC:Sprite;
	protected var moveMC:Sprite;
	
	protected var topResizeMC:Sprite;
	protected var leftResizeMC:Sprite;
	protected var bottomResizeMC:Sprite;
	protected var rightResizeMC:Sprite;
	
	protected var topLeftResizeMC:Sprite;
	protected var topRightResizeMC:Sprite;
	protected var bottomLeftResizeMC:Sprite;
	protected var bottomRightResizeMC:Sprite;
	
	protected var dragging:Boolean;
	
	protected var moveAlongGrid:Boolean;
	protected var scaleAlongGrid:Boolean;
	protected var gridResolutionX:uint;
	protected var gridResolutionY:uint;
	
	public function RangeEditor(){
		super();
		
		editorMC = new Sprite();
		editorMC.mouseEnabled = false;
		
		moveMC = createDotter(-100000, 1, 1, 0, 0, true);
		topResizeMC = createDotter(90, 0, 1, 0, -1);
		leftResizeMC = createDotter(0, 1, 0, -1, 0);
		bottomResizeMC = createDotter(90, 0, 0, 0, 1);
		rightResizeMC = createDotter(0, 0, 0, 1, 0);
		
		topLeftResizeMC = createDotter(45, 1, 1, -1, -1);
		topRightResizeMC = createDotter(-45, 0, 1, 1, -1);
		bottomLeftResizeMC = createDotter(-45, 1, 0, -1, 1);
		bottomRightResizeMC = createDotter(45, 0, 0, 1, 1);
		
		resizeArrowCursor = Cursor.createCursor(Cursor.H_RESIZE_CURSOR);
		moveArrowCursor = Cursor.createCursor(Cursor.HV_MOVE_CURSOR);
	
		// For now, grid is disabled by default
		moveAlongGrid 	= false;
		scaleAlongGrid 	= false;
		gridResolutionX = 10;
		gridResolutionY = 10;
	}
	
	private var startPos:Point;
	private var startRange:IntRectangle;
	private var xScale:int;
	private var yScale:int;
	private var xMove:int;
	private var yMove:int;
	
	private function __dotterRollover(e:MouseEvent, rotation:Number):void{
		if(comp == null){
			return;
		}
		if(!dragging){
			if(rotation < -360){//means move
				CursorManager.getManager().showCustomCursor(moveArrowCursor);
			}else{
				CursorManager.getManager().showCustomCursor(resizeArrowCursor);
				resizeArrowCursor.rotation = rotation;
			}
		}
	}
	
	private function __dotterRollout(e:MouseEvent):void{
		if(comp == null){
			return;
		}
		if(!dragging){
			CursorManager.getManager().hideCustomCursor(resizeArrowCursor);
			CursorManager.getManager().hideCustomCursor(moveArrowCursor);
		}
	}
	
	private function __dotterMouseDown(e:MouseEvent, xMove:int, yMove:int, 
		xScale:int, yScale:int, move:Boolean):void{
		if(comp == null){
			return;
		}
		startPos = new Point(e.stageX, e.stageY);
		startRange = comp.getComBounds();
		this.xMove = xMove;
		this.yMove = yMove;
		this.xScale = xScale;
		this.yScale = yScale;
		dragging = true;
		editorMC.stage.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		editorMC.stage.addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
	}
	
	private function __mouseMove(e:MouseEvent):void{
		if(comp == null){
			return;
		}
		var curPos:Point = new Point(e.stageX, e.stageY);
		var dx:Number = curPos.x - startPos.x;
		var dy:Number = curPos.y - startPos.y;
		var newRange:IntRectangle = startRange.clone();
		newRange.x += xMove*dx;
		newRange.y += yMove*dy;
		
		// Align new coordinates along grid
		if( moveAlongGrid ) {
			newRange.x = newRange.x - ( newRange.x % gridResolutionX );
			newRange.y = newRange.y - ( newRange.y % gridResolutionY );
		}
		
		newRange.width += xScale*dx;
		newRange.height += yScale * dy;
		
		// Align scale along grid
		if( scaleAlongGrid ) {
			newRange.width 	= newRange.width 	- ( newRange.width 	% gridResolutionX );
			newRange.height = newRange.height - ( newRange.height % gridResolutionY );
		}
		comp.setBounds(newRange);
	}
	
	private function __mouseUp(e:MouseEvent):void{
		editorMC.stage.removeEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		editorMC.stage.removeEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		CursorManager.getManager().hideCustomCursor(resizeArrowCursor);
		dragging = false;
	}
	
	public function addTo(con:DisplayObjectContainer):void{
		con.addChild(editorMC);
	}
	
	protected function createDotter(rotation:Number, xMove:int, yMove:int, 
		xScale:int, yScale:int, move:Boolean=false):Sprite{
		var sp:Sprite = new Sprite();
		if(move){
			sp.graphics.beginFill(0, 0);
			sp.graphics.drawRect(3, 3, 8, 6);
			sp.graphics.endFill();
		}else{
			sp.graphics.lineStyle(0, 0x000099, 1, false, LineScaleMode.NORMAL, null, JointStyle.BEVEL);
			sp.graphics.beginFill(0x0066FF, 0.3);
			sp.graphics.drawRect(-3, -3, 6, 6);
			sp.graphics.endFill();
			sp.graphics.lineStyle();
		}
		
		sp.addEventListener(MouseEvent.MOUSE_DOWN, 
			Delegate.create(__dotterMouseDown, xMove, yMove, xScale, yScale, move));
		sp.addEventListener(MouseEvent.ROLL_OVER, 
			Delegate.create(__dotterRollover, rotation));
		sp.addEventListener(MouseEvent.ROLL_OUT, __dotterRollout);
		editorMC.addChild(sp);
		return sp;
	}
	
	public function bindTo(c:Component):void{
		if(c != comp){
			if(editorMC.stage){
				editorMC.stage.removeEventListener(MouseEvent.MOUSE_UP, __mouseUp);
				editorMC.stage.removeEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
				CursorManager.getManager().hideCustomCursor(resizeArrowCursor);
				CursorManager.getManager().hideCustomCursor(moveArrowCursor);
			}
			if(comp){
				comp.removeEventListener(MovedEvent.MOVED, __compMoved);
				comp.removeEventListener(ResizedEvent.RESIZED, __compResized);
			}
			comp = c;
			if(comp){
				comp.addEventListener(MovedEvent.MOVED, __compMoved);
				comp.addEventListener(ResizedEvent.RESIZED, __compResized);
			}
			synEditorRange();
		}
	}
	
	/**
	 * Returns the component the RangeEditor is currently bound to
	 * @return The component the RangeEditor is currently bound to
	 */
	public function getBoundComp():Component {
		return comp;
	}
	
	protected function synEditorRange():void{
		editorMC.graphics.clear();
		if(comp == null || editorMC.stage == null || comp.stage == null){
			editorMC.visible = false;
			return;
		}
		editorMC.visible = true;
		var size:IntDimension = comp.getSize();
		var gp:IntPoint = comp.getGlobalLocation();
		var p:Point = editorMC.parent.globalToLocal(gp.toPoint());
		editorMC.x = p.x;
		editorMC.y = p.y;
		editorMC.graphics.lineStyle(0, 0, 1, false, LineScaleMode.NORMAL, null, JointStyle.BEVEL);
		editorMC.graphics.drawRect(0, 0, size.width, size.height);
		editorMC.graphics.lineStyle();
		
		locateDotter(topLeftResizeMC, size, 0, 0);
		locateDotter(topResizeMC, size, 0.5, 0);
		locateDotter(topRightResizeMC, size, 1, 0);
		locateDotter(bottomLeftResizeMC, size, 0, 1);
		
		locateDotter(bottomResizeMC, size, 0.5, 1);
		locateDotter(bottomRightResizeMC, size, 1, 1);
		locateDotter(leftResizeMC, size, 0, 0.5);
		locateDotter(rightResizeMC, size, 1, 0.5);
	}
	
	private function locateDotter(dotter:Sprite, size:IntDimension, xPos:Number, yPos:Number):void{
		dotter.x = size.width*xPos;
		dotter.y = size.height*yPos;
	}
	
	private function __compMoved(e:MovedEvent):void{
		synEditorRange();
	}
	
	private function __compResized(e:ResizedEvent):void{
		synEditorRange();
	}
	
	public function setEnableGrid( enable:Boolean, resolutionX:uint = 10, resolutionY:uint = 10 ):void {
		moveAlongGrid 	= enable;
		gridResolutionX = resolutionX;
		gridResolutionY = resolutionY;
	}
	public function setGridResolutionX( resolutionX:uint ):void {
		gridResolutionX = resolutionX;
	}
	public function setGridResolutionY( resolutionY:uint ):void {
		gridResolutionY = resolutionY;
	}
	
	public function getGridEnabled():Boolean {
		return moveAlongGrid;
	}
	public function getGridResolutionX():uint {
		return gridResolutionX;
	}
	public function getGridResolutionY():uint {
		return gridResolutionY;
	}
}
}