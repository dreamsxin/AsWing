package com.alvasun.laf.blue {

	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.JButton;
	import org.aswing.UIManager;
	import org.aswing.event.ResizedEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.plaf.basic.tabbedpane.ClosableTab;
	import org.aswing.skinbuilder.SkinButtonIcon;
	import org.aswing.skinbuilder.SkinTabbedPaneTab;	
	
	public class BluenessClosableTabbedPaneTab extends SkinTabbedPaneTab implements ClosableTab {
		
		protected var closeButton:JButton;
		protected var closeButtonSize:IntDimension;
		private var closeButtonGap : int;
		
		public function BluenessClosableTabbedPaneTab(){
			super();
		}
		
		override public function initTab(owner:Component):void{
			super.initTab(owner);
			closeButton = new JButton();
			closeButton.setOpaque(false);
			closeButton.setMargin(new Insets());
			closeButton.setBackgroundDecorator(null);
			closeButton.setIcon(new SkinButtonIcon(-1, -1, getPropertyPrefix()+"closeButton.", owner));
			closeButton.pack();
			closeButtonSize = closeButton.getSize();
			button.addChild(closeButton);
			button.mouseChildren = true;
			button.addEventListener(ResizedEvent.RESIZED, __buttonResized);
			closeButtonGap = UIManager.getInt(getPropertyPrefix() + "closeButtonGap");
		}
		
		override protected function getPropertyPrefix():String{
			return "ClosableTabbedPane.";
		}
		
		public function getCloseButton():Component{
			return closeButton;
		}
		
		private function __buttonResized(e:ResizedEvent):void{
			var oriMargin:Insets = button.getMargin();
			oriMargin.right -= closeButtonSize.width;
			closeButton.setLocationXY(
				e.getNewSize().width - oriMargin.right - closeButtonSize.width + closeButtonGap, 
				(e.getNewSize().height - closeButtonSize.height)/2);
		}
		
		override public function setMargin(m:Insets):void{
			m = m.clone();
			m.right += closeButtonSize.width + closeButtonGap;
	    	button.setMargin(m);
	    }
	}
}