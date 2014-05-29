package {

import org.aswing.*;
import org.aswing.image.png.*;
import org.aswing.border.*;
import flash.events.*;
import flash.filesystem.*;
import flash.net.*;
import flash.display.*;
import flash.utils.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import com.hexagonstar.util.debug.Debug;

[SWF(width="900", height="700")]
public class AsPngEncoderTest extends Sprite{
	
	private var window:JWindow;
	private var sourcePane:AssetPane;
	private var encodePane:AssetPane;
	private var palettePane:JPanel;
	private var paletteShape:Shape;
	private var infoText:JTextArea;
	private var openButton:JButton;
	private var saveButton:JButton;
	
	private var encoderCombo:JComboBox;
	
	private var encoders:Array;
	private var file:File;
	private var sourceImageLoader:Loader;
	private var sourceImage:BitmapData;
	
	private var encodeImageLoader:Loader;
	private var encodeImage:BitmapData;
	
	public function AsPngEncoderTest(){
		super();
		
		AsWingManager.initAsStandard(this);
		
		sourceImageLoader = new Loader();
		encodeImageLoader = new Loader();
		encoders = [
					new Strategy32BitAlpha(), 
					new Strategy32BitOpaque(), 
					new Strategy8BitMedianCutAlpha(256, 4), 
					new Strategy8BitMedianCutAlpha(128, 4),  
					new Strategy8BitMedianCutAlpha(64), 
					new Strategy8BitMedianCutAlpha(16), 
					new Strategy8BitMedianCutAlpha(8), 
					new Strategy8BitMedianCutAlpha(4), 
					new Strategy8BitMedianCutAlpha(2), 
					new Strategy8BitMedianCutOpaque(256), 
					new Strategy8BitMedianCutOpaque(64), 
					new Strategy8BitMedianCutOpaque(9), 
					new Strategy8BitUniformQuantAlpha(), 
					new Strategy8BitUniformQuant(6, 7, 6), 
					new Strategy8BitUniformQuant(6, 6, 6), 
					new Strategy8BitUniformQuant(8, 8, 4), 
					new Strategy8BitUniformQuant(5, 5, 5), 
					new Strategy8BitUniformQuant(4, 4, 4), 
					new Strategy8BitUniformQuant(2, 2, 2)
					];
		
		window = new JWindow();
		sourcePane = new AssetPane();
		sourcePane.setBackgroundDecorator(new TransparentBG());
		encodePane = new AssetPane();
		encodePane.setBackgroundDecorator(new TransparentBG());
		palettePane = new JPanel();
		palettePane.setPreferredSize(new IntDimension(32*8+2, 8*8+2));
		palettePane.setBorder(new BevelBorder(null, BevelBorder.LOWERED, null, null, null, null, 1));
		paletteShape = new Shape();
		paletteShape.x = paletteShape.y = 1;
		paletteShape.cacheAsBitmap = true;
		palettePane.addChild(paletteShape);
		infoText = new JTextArea("", 8, 30);
		infoText.setWordWrap(true);
		openButton = new JButton("Open a Image");
		saveButton = new JButton("Save as PNG");
		encoderCombo = new JComboBox(encoders);
		encoderCombo.setSelectedIndex(0);
		encoderCombo.setPreferredWidth(240);
		encoderCombo.setEditable(false);
		
		var pane:JPanel = new JPanel(new BorderLayout(0, 4));
		
		var centerPane:Box = Box.createHorizontalBox(2);
		var sc1:JScrollPane = new JScrollPane(sourcePane);
		sc1.setBorder(new TitledBorder(null, "Source Image"));
		var sc2:JScrollPane = new JScrollPane(encodePane);
		sc2.setBorder(new TitledBorder(null, "Encoded Image"));
		centerPane.appendAll(sc1, sc2);
		pane.append(centerPane, BorderLayout.CENTER);
		
		var southPane:SoftBox = SoftBox.createHorizontalBox(2);
		var palPane:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 2, 2));
		palPane.appendAll(new JLabel("Palette:"), palettePane, new JScrollPane(infoText));
		var buttonPane:SoftBox = SoftBox.createVerticalBox(2);
		buttonPane.appendAll(openButton, encoderCombo, saveButton);
		southPane.appendAll(palPane, buttonPane);
		pane.append(southPane, BorderLayout.SOUTH);
		
		window.setContentPane(pane);
		window.setSizeWH(stage.stageWidth, stage.stageHeight);
		window.show();
		
		stage.addEventListener(Event.RESIZE, __stageResized);
		openButton.addActionListener(__open);
		encoderCombo.addActionListener(__encoderChanged);
		saveButton.addActionListener(__save);
		
		file = new File();
		file.addEventListener(Event.SELECT, __fileSelected);
		saveFile = new File();
		saveFile.addEventListener(Event.SELECT, __fileSaveSelected);
		
		sourceImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, __sourceLoaded);
		encodeImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, __encodeLoaded);
		
	}
	
	private function log(text:String):void{
		infoText.appendByReplace(text + "\n");
		infoText.scrollToBottomLeft();
	}
	
	private var encodedPng:ByteArray;
	private function startEncode():void{
		if(sourceImage == null) return;
		
		var t:int = getTimer();
		var encoder:AsPngEncoder = new AsPngEncoder();
		var png:ByteArray = encoder.encode(sourceImage, encoderCombo.getSelectedItem());
		var usedT:int = (getTimer() - t);
		log("Encode time : " + usedT);
		log("Encoded png size : " + png.length/1024 + "kb");
		encodedPng = png;
		
		AsWingManager.callNextFrame(loadEncodedAndPaintPalette);
	}
	
	private function loadEncodedAndPaintPalette():void{
		encodeImageLoader.loadBytes(encodedPng);
		
		paletteShape.graphics.clear();
		var gr:Graphics2D = new Graphics2D(paletteShape.graphics);
		var encoder:EncodeStrategyBase = encoderCombo.getSelectedItem() as EncodeStrategyBase;
		if(encoder == null) return;
		var plte:PLTE = encoder.getPLTE();
		if(plte == null) return;
		var paletteData:ByteArray = plte.getData();
		var trns:tRNS = encoder.gettRNS();
		var trnsData:ByteArray = (trns != null ? trns.getData() : null);
		var brush:SolidBrush = new SolidBrush(ASColor.BLACK);
		var pen:Pen = new Pen(new ASColor(0x222222), 0);
		gr.beginDraw(pen);
		paletteData.position = 0;
		if(trnsData) trnsData.position = 0;
		var T:int = 8;
		log("Palette color number : " + paletteData.length/3);
		var alphaNumber:int = 0;
		for(var y:int=0; y<8; y++){
			for(var x:int=0; x<32; x++){
				var r:uint = paletteData.readUnsignedByte();
				var g:uint = paletteData.readUnsignedByte();
				var b:uint = paletteData.readUnsignedByte();
				var rgb:uint = ((r<<16) | (g<<8) | b);
				brush.setColor(new ASColor(rgb));
				gr.fillRectangle(brush, x*T, y*T, T, T);
				
				if(trnsData && trnsData.bytesAvailable > 0){
					var alpha:Number = 1;
					var a:uint = trnsData.readUnsignedByte();
					if(a < 255){
						brush.setColor(ASColor.getASColor(a, a, a));
						gr.fillRectangle(brush, x*T, y*T, T/2, T/2);
						alphaNumber++;
					}
				}
				
				if(paletteData.bytesAvailable < 3){
					gr.endDraw();
					log("Alpha Number : " + alphaNumber);
					return;
				}
			}
		}
		gr.endDraw();
		log("Alpha Number : " + alphaNumber);
	}
	
	private function __encoderChanged(e:Event):void{
		startEncode();
	}
	
	private function __open(e:Event):void{
		file.browseForOpen("Select a Image file", [new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png")]);
	}
	
	private var saveFile:File;
	private function __save(e:Event):void{
		saveFile.browseForSave("Save as a png");
	}
	
	private function __fileSelected(e:Event):void{
		trace("__fileSelected : " + file.nativePath);
		var bytes:ByteArray = new ByteArray();
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.READ);
		stream.readBytes(bytes);
		stream.close();
		sourceImageLoader.loadBytes(bytes);
	}
	
	private function __fileSaveSelected(e:Event):void{
		var stream:FileStream = new FileStream();
		if(!saveFile.exists){
			trace("create new file");
		}
		stream.open(saveFile, FileMode.WRITE);
		stream.writeBytes(encodedPng);
		stream.close();
	}
	
	private function __sourceLoaded(e:Event):void{
		var bm:Bitmap = sourceImageLoader.content as Bitmap;
		sourceImageLoader.unload();
		sourcePane.setAsset(bm);
		sourceImage = bm.bitmapData;
		startEncode();
	}
	
	private function __encodeLoaded(e:Event):void{
		var bm:Bitmap = encodeImageLoader.content as Bitmap;
		encodeImageLoader.unload();
		encodePane.setAsset(bm);
		encodeImage = bm.bitmapData;
	}
	
	private function __stageResized(e:Event):void{
		window.setSizeWH(stage.stageWidth, stage.stageHeight);
	}
}
}

import org.aswing.*;
import org.aswing.graphics.*;
import org.aswing.geom.*;
import flash.display.*;

class TransparentBG implements GroundDecorator{
	
	private var lastBounds:IntRectangle;
	private var shape:Shape;
	public function TransparentBG(){
		shape = new Shape();
		lastBounds = new IntRectangle();
	}
	
	public function updateDecorator(com:Component, g:Graphics2D, b:IntRectangle):void{
		shape.x = b.x;
		shape.y = b.y;
		if(b.width == lastBounds.width && b.height == lastBounds.height){
			return;
		}
		lastBounds.setRect(b);
		var T:int = 8;
		var brush:SolidBrush = new SolidBrush(ASColor.BLACK);
		shape.graphics.clear();
		var grey:ASColor = new ASColor(0xCCCCCC);
		g = new Graphics2D(shape.graphics);
		for(var x:int=0; x<b.width; x+=T){
			for(var y:int=0; y<b.height; y+=T){
				brush.setColor((x/T+y/T)%2 == 0 ? ASColor.WHITE : grey);
				g.fillRectangle(brush, x, y, T, T);
			}
		}
		shape.cacheAsBitmap = true;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
}
