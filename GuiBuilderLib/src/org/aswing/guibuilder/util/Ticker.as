package org.aswing.guibuilder.util{

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.aswing.util.ArrayUtils;	

public class Ticker{
	
	private var timers:Array;
	
	public static const ins:Ticker = new Ticker();
	
	public function Ticker(){
		timers = new Array();
	}
	
	private function __timer(e:Event, timer:Timer, func:Function):void{
		func();
		ArrayUtils.removeFromArray(timers, timer);
	}
	
	public function callNextTick(func:Function, delay:int=10):void{
		var timer:Timer = new Timer(delay, 1);
		timer.addEventListener(TimerEvent.TIMER, Delegate.create(__timer, timer, func));
		timer.start();
	}
}
}