package;
import flash.display.Sprite;
import flash.Lib; 
import flash.text.TextField;
import flash.text.TextFieldType;
import org.aswing.AsWingManager;
import org.aswing.Component;
import org.aswing.JButton;
import org.aswing.JLabel;
import org.aswing.JPanel;
import org.aswing.JSeparator;
import org.aswing.JToggleButton;
import org.aswing.JToolBar;
 

class Main  extends Sprite
{
	 
   public function new()
   {
      super();  
	  AsWingManager.initAsStandard( Lib.current);
	   Lib.current.addChild(this); 
	   Lib.current.addChild(new ComSet());  
	 
		return;
	 
		 /*
		 var tf1:JTextComponent = new JTextComponent();
		 tf1.setText("Input Text");
		 tf1.setSizeWH(120, 30); 
		 
		 addChild(tf1); 
		 var comp:AWSprite = new AWSprite();
		 addChild(comp);  */
		var comp:JPanel = new JPanel();
		addChild(comp); 
		 comp.setSizeWH(800, 600); 
		 var toolbar:JToolBar = new JToolBar();  
		toolbar.append(new JLabel("This is a ToolBar"));
		toolbar.append(new JSeparator(JSeparator.VERTICAL));
		toolbar.append(new JButton("Button"));
		toolbar.append(new JButton("Button 2"));
		toolbar.append(new JToggleButton("Toggle Button"));
		comp.append(toolbar);
		comp.doLayout();
		toolbar.doLayout();
		var textField:TextField = new TextField();
		textField.text = "1111";
		textField.type = TextFieldType.INPUT;
		comp.addChild(textField);
	return; 
   } 

 static public function main()
   {
            new Main();


   }
}
