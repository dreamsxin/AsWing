package cases
{
	import flash.display.Sprite;
	import org.aswing.*;
	import flash.text.TextFormat;

	public class TextAreaCase extends Sprite
	{
		private var textArea:JTextArea;
		
		public function TextAreaCase()
		{
			super();
			var panel:JPanel = new JPanel(new BorderLayout());
						
			textArea = new JTextArea();
			for(var i:int=0; i<40; i++){
				textArea.appendText("text " + i + "\n");
				if(i % 2 == 0){
					textArea.setDefaultTextFormat(new TextFormat(null, 24, 0xFF0000));
				}else{
					textArea.setDefaultTextFormat(new TextFormat(null, 11, 0x000000));
				}
			}
			
			var scrollPane:JScrollPane = new JScrollPane(textArea);
			panel.append(scrollPane, BorderLayout.CENTER);
			
			panel.setSizeWH(300, 300);
			addChild(panel);
			panel.validate();
		}
		
	}
}