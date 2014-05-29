package{

import aeon.AeonLAF;

import componetset.*;

import flash.display.*;

import org.aswing.*;
import org.aswing.border.EmptyBorder;
import org.aswing.skinbuilder.SkinBuilderLAF;

[SWF (width="800", height="600", backgroundColor="0xFFFFFF")]
public class ComSetSkin extends Sprite{
	
	private var tabpane:JTabbedPane;
	public static var WINDOW:JWindow;
	
	public function ComSetSkin(){
		super();
		AsWingManager.initAsStandard(this);
		UIManager.setLookAndFeel(new AeonLAF());
		
		WINDOW = new JWindow();
		
		tabpane = new JTabbedPane();
		tabpane.append(new Buttons());
		tabpane.append(new Scrolls());
		tabpane.append(new Containers());
		tabpane.append(new HeavyComs());
		tabpane.append(new Windows());
		tabpane.append(new Menus());
		tabpane.append(new Decorators());
		tabpane.setOpaque(true);
		//tabpane.setBackground(ASColor.HALO_BLUE);
		
		WINDOW.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));
		WINDOW.setContentPane(tabpane);
		WINDOW.setSizeWH(800, 600);
		WINDOW.show();
	}
}
}