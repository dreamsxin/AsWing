package cases
{
import flash.display.Sprite;

import org.aswing.*;
import org.aswing.geom.IntDimension;
import org.aswing.border.*;
import flash.events.Event;


public class ProgressBar extends Sprite
{
	private var progBar:JProgressBar;
	private var indeterminateBar:JProgressBar;	
	private var scrollBar:JScrollBar;
	private var pane:JPanel;
	public function ProgressBar(){
		super();
		pane = new JPanel(new BorderLayout());
		pane.setSizeWH(400,300);
		progBar = new JProgressBar(JProgressBar.HORIZONTAL);
		progBar.setPreferredWidth(100);
		indeterminateBar = new JProgressBar(JProgressBar.VERTICAL);
		indeterminateBar.setIndeterminate(true);
		scrollBar = new JScrollBar(JScrollBar.HORIZONTAL, 0, 0, 0, 100);
		scrollBar.addStateListener(__scrolled);
		pane.append(scrollBar, BorderLayout.NORTH);

		initAsHorizontal();
		//initAsVertical();
		
		this.addChild(pane);
		pane.validate();		
	}
	
	private function initAsHorizontal():void{
		pane.append(progBar, BorderLayout.SOUTH);
		//progBar.setBorder(new BevelBorder(null, BevelBorder.RAISED));
		pane.append(indeterminateBar, BorderLayout.EAST);
		//indeterminateBar.setBorder(new BevelBorder());
	}
	
	private function initAsVertical():void{
		//should embed this font in input swf first
		progBar.setFont(new ASFont("Arial", 9, false, false, false, true));
		progBar.setOrientation(JProgressBar.VERTICAL);
		pane.append(progBar, BorderLayout.WEST);
	}
		
	private function __scrolled(e:Event):void{
		progBar.setValue(scrollBar.getValue());
		progBar.setString(progBar.getPercentComplete() * 100 + "%");
	}
}
}