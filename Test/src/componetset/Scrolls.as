package componetset{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.BorderLayout;
import org.aswing.JComboBox;
import org.aswing.JTextField;
import org.aswing.JAdjuster;
import org.aswing.JTextArea;
import org.aswing.SoftBox;
import org.aswing.JScrollPane;
import org.aswing.ASColor;
import org.aswing.AssetPane;
import flash.display.DisplayObject;
import org.aswing.geom.IntDimension;
import org.aswing.JSlider;
import org.aswing.JProgressBar;

public class Scrolls extends JPanel{
	[Embed(source="princess.jpg")]
	private var imgClass:Class;
	
	public function Scrolls(){
		super();
		name = "Scrolls";
		
		var scrollPane:JScrollPane = new JScrollPane(new AssetPane(new imgClass() as DisplayObject));
		scrollPane.setPreferredSize(new IntDimension(300, 300));
		
		append(scrollPane);
		
		var slider:JSlider = new JSlider();
		append(slider);
		slider.setMajorTickSpacing(20);
		slider.setMinorTickSpacing(4);
		slider.setPaintTicks(true);
		slider.setShowValueTip(true);
		
		var progress:JProgressBar = new JProgressBar();
		progress.setIndeterminate(true);
		append(progress);
	}
	
}
}