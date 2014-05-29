package;


import componetset.Buttons;
import componetset.Scrolls;
import componetset.Containers;
import componetset.HeavyComs;
import componetset.Windows;
import componetset.Menus;
import componetset.Decorators;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldType;
import org.aswing.AsWingManager;
import org.aswing.AWSprite;
import org.aswing.Component;
import org.aswing.JTabbedPane;
import org.aswing.JTextComponent;
import org.aswing.JTextField;
import org.aswing.JWindow;
import org.aswing.UIManager;
import org.aswing.SolidBackground;
import org.aswing.border.EmptyBorder;
import org.aswing.Insets;
	class ComSet extends Sprite{ 
	
	private var tabpane:JTabbedPane;
	public static var WINDOW:JWindow;
	
	public function new(){
		super();
 
		 

		// return;
		WINDOW = new JWindow(this);
		
		tabpane = new JTabbedPane(); 
	
		tabpane.append(new Windows());
		tabpane.append(new Buttons()); 
		tabpane.append(new Scrolls());
		tabpane.append(new Containers());
		tabpane.append(new HeavyComs());
		tabpane.append(new Menus()); 
		
		tabpane.append(new Decorators());
		
		
		
		
		WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window"))); 
		
		WINDOW.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));
		WINDOW.setContentPane(tabpane);
		WINDOW.setSizeWH(800, 600);
		WINDOW.show();
		
		return;
		
		var textField:TextField = new TextField();
		textField.text = "1111";
		textField.type = TextFieldType.INPUT;
		addChild(textField);
	}
	
}
