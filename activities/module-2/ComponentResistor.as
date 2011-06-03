﻿package {

    import flash.display.Loader;
    import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
	import flash.geom.Rectangle;//kpc
    import flash.geom.Matrix;//kpc
	import flash.display.CapsStyle; //KPC
    import flash.net.URLRequest;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
	import flash.events.KeyboardEvent;
	import flash.text.*;
	//import flash.text.TextField;
    //import flash.text.TextFormat;
    //import flash.text.TextFieldAutoSize;
	//add dimension
	
	import Lead;
    import org.concord.sparks.JavaScript;
    import Globe;
	
//copy angle code from wire
//copy dimension function from wire  _x1, _y1, _angle
    
    public class ComponentResistor extends ComponentObj {
        
        
        private var m_bandCount:int;
        private var m_resistanceValue:Number = NaN;
        private var m_pngBandSuffix:String;
        
        private var bandOneColor:String = "blue";
        private var bandTwoColor:String = "blue";
        private var bandThreeColor:String = "blue";
        private var bandFourColor:String = "blue";
        private var bandToleranceColor:String = "blue";
		
		private var colors:Array = null;
		
        
        private var graphicsLayer:DisplayObjectContainer;
		private var lead1:Lead;
		private var lead2:Lead;
		private var lead1ConnectPointX:Number;  //KPC
		private var lead2ConnectPointX:Number;  //KPC
		private var lead1ConnectPointY:Number;  //KPC
		private var lead2ConnectPointY:Number;  //KPC
		
		
		private var _leadColor1:uint; //KPC copy from wire
		private var _leadColor2:uint;  //KPC copy from wire
		private var connectLeads:Shape = new Shape(); //KPC
		
		private var _x1:Number;
		private var _y1:Number;
		private var _x2:Number;
		private var _y2:Number;
		private var _angle:Number;
		
		private var _lead_x1:Number;
		private var _lead_y1:Number;
		private var _lead_x2:Number;
		private var _lead_y2:Number;
		
		private var _leadLength:Number;
    
        private var m_bandOneLoader:Loader = null;
        private var m_bandTwoLoader:Loader = null;
        private var m_bandThreeLoader:Loader = null;
        private var m_bandFourLoader:Loader = null;
        private var m_bandToleranceLoader:Loader = null;
		
		private var bandZoom:Boolean = true;
		private var embedVerdana:Font = new Font1();
		private var embedArialBlack:Font = new Font2();
		
		private var printColor:TextField = new TextField();
		private var labelTextField = new TextField();
		private var format:TextFormat = new TextFormat();
		private var formatLabel:TextFormat = new TextFormat();
		
		//private var printColor:Font = new Font1();
		//private var printColor:TextField = new TextField();
        //private var format:TextFormat = new TextFormat();
		private var bandX:Number;
		private var bandY:Number;
		private var printColorX:Number;
		private var printColorY:Number;
		private var band_ScaleX:Number;
		private var band_ScaleY:Number;
		private var band1_ScaleY:Number;
		//private var textX:Number;
		//private var textY:Number;
		private const textTrim:Number = 8;

        
        public function ComponentResistor(bandCount:int, pngBandSuffix:String) {
            
			super();
            graphicsLayer = DisplayObjectContainer(this.getChildByName('graphics_mc'));
			_leadLength = 45; //5//length of exposed metal ends of wire in pixels
		
            //get leads and position leads
			this.putLeadsOnBottom();
            lead1 = this.getEnds()[0];
            lead2 = this.getEnds()[1];
     

            m_bandCount = bandCount;
            m_pngBandSuffix = pngBandSuffix;
            
            //testResistorTips();
			setupBandZoom();
			
			
			this.graphicsLayer.getChildByName('label_mc').visible=false;
	
			//graphicsLayer.alpha = .5;
		//Beginning of KPC Code for moving Resistors Ends and readjusting wire
			this.addChild(connectLeads);
			swapChildren(connectLeads, graphicsLayer);
			
			//drawLeads();  //KPC
			
			//COMMENT OUT THE NEXT FOUR LINES TO DISABLE USER FROM MOVING LEADS
			/*lead1.addEventListener(MouseEvent.MOUSE_DOWN, lead1Move);
			lead2.addEventListener(MouseEvent.MOUSE_DOWN, lead2Move);
			graphicsLayer.addEventListener(MouseEvent.MOUSE_DOWN, rotateIt);
			
			lead1.buttonMode = true;
			lead2.buttonMode = true;
			*/
        }
		
		public function dimension(x1:Number,y1:Number,x2:Number,y2:Number):void {
			
			if(x1<=x2) {
				_x1 = x1;
				_y1 = y1;
				_x2 = x2;
				_y2 = y2;
			} else {
				_x1 = x2;
				_y1 = y2;
				_x2 = x1;
				_y2 = y1;
			}
			
			var angle:Number = Math.atan( (_y2-_y1) / (_x2-_x1) );  // angle of the line's slope in radians
			_angle = angle;
			var leadOffset_x:Number = _leadLength * Math.cos(angle);
			var leadOffset_y:Number = _leadLength * Math.sin(angle);
			
			
			_lead_x1 = _x1 + leadOffset_x;
			_lead_y1 = _y1 + leadOffset_y;
			_lead_x2 = _x2 - leadOffset_x;
			_lead_y2 = _y2 - leadOffset_y;
			
		
			 
			positionLeads(lead1, _x1, _y1, _angle);
            positionLeads(lead2, _x2, _y2, _angle);
			drawLeads();
			
		}
		
		public function drawLeads():void  {
			
			_leadColor1 = 0xA0A0A0; // the lead's outer color - the lead is two-toned
			_leadColor2 = 0xE5E5E5;
		
			
			lead1ConnectPointY = lead1.y - 40;
			lead2ConnectPointY = lead2.y + 40;
			
			connectLeads.graphics.clear();
			
			
			connectLeads.graphics.lineStyle(8.5, 0x565656, 1.0,false, "normal", CapsStyle.NONE, null, 0);
			//connectLeads.graphics.beginFill(0x00FF00);
			connectLeads.graphics.moveTo(_lead_x1, _lead_y1); 
			connectLeads.graphics.lineTo(_lead_x2, _lead_y2);	
			
			
			connectLeads.graphics.lineStyle(5, _leadColor1, 1.0,false, "normal", CapsStyle.NONE, null, 0);
			//connectLeads.graphics.beginFill(0x00FF00);
			connectLeads.graphics.moveTo(_lead_x1, _lead_y1);  
			connectLeads.graphics.lineTo(_lead_x2, _lead_y2);	
			
			connectLeads.graphics.lineStyle(2, _leadColor2, 1);
			connectLeads.graphics.moveTo(_lead_x1, _lead_y1); 
			connectLeads.graphics.lineTo(_lead_x2, _lead_y2);	
			
					
			//center the main resistor between the leads KPC 
			
			graphicsLayer.x =  (lead1.x + lead2.x) /2 ;
			graphicsLayer.y = (lead1.y + lead2.y)/2 ;
			graphicsLayer.rotation += _angle*180/Math.PI; 
			
			
			
			
		}
						
			
		/*
		public function lead1Move(event:MouseEvent) 
		{
	
			//move left lead left
			if ( (mouseY >= -5) && (mouseY <= 5) ) { 
			
				if ( mouseX <= (lead1.x + 20 ) )  {
					lead1.x -= 5;
				}
			//move left lead right
				if ( mouseX >= (lead1.x + 25 ) ) {
					lead1.x += 5;
				}
				drawLeads();
				trace (graphicsLayer.width);
			}
		}
							
			
		public function lead2Move(event:MouseEvent) 
		{

		//move right lead right
			if ( (mouseY >= -5) && (mouseY <= 5) ) 
			{ 
			
				if ( mouseX >= (lead2.x - 20 ) )  
				{
					lead2.x += 5;
					
				}
			//move right lead left
				if ( mouseX <= (lead2.x - 25 ) ) 
				{
					lead2.x -= 5;
				}
				drawLeads();
				trace (graphicsLayer.width);
			}
		}
		
		
		public function rotateIt(event:MouseEvent) 
		{
			if (mouseX < 40) {
				this.rotation += 5;
			}
			if (mouseX > 61) {
				
				this.rotation -= 5;
				
				}
		
		}
		
		//End of KPC Temp code for moving Resistor
		
		
		
		
		private var embedVerdana:Font = new Font1();
		private var printColor:TextField = new TextField();
		private var format:TextFormat = new TextFormat();
			format.font = embedVerdana.fontName;
        	format.color = 0x2F3309;
        	format.size = 14;
        	format.bold = true;
			printColor.defaultTextFormat = format;
			printColor.background = true;
			printColor.backgroundColor = 0xE5DBC6;
			printColor.selectable = false;	
			printColor.embedFonts = true;
			printColor.antiAliasType = AntiAliasType.ADVANCED;
			
		*/
		
		public function setLabel(labelStr:String){
			if(labelStr != ''){
				trace('resistorLabel is: '+labelStr);
				var label_mc:MovieClip = MovieClip(this.graphicsLayer.getChildByName('label_mc'));
				
				formatLabel.font = embedArialBlack.fontName;
				formatLabel.color = 0xFFFFFF;
				formatLabel.size = 14;
				formatLabel.bold = true;
			
				
				label_mc.labelTextField = new TextField();
				label_mc.labelTextField.defaultTextFormat = formatLabel;
				label_mc.labelTextField.selectable = false; 
				label_mc.labelTextField.embedFonts = true;
				label_mc.labelTextField.antiAliasType = AntiAliasType.ADVANCED;
				label_mc.labelTextField.x = 6;
				label_mc.labelTextField.y = 2;
				label_mc.labelTextField.text = labelStr;
				label_mc.labelTextField.width = label_mc.labelTextField.textWidth+5;
				label_mc.labelTextField.height = label_mc.labelTextField.textHeight+2;	
				//label_mc.labelTextField.embedFonts = true;
				label_mc.addChild(label_mc.labelTextField);
			
				this.addEventListener(MouseEvent.MOUSE_OVER, labelOn);
				this.addEventListener(MouseEvent.MOUSE_OUT, labelOff);
			}
		}
		
		private function labelOn(event:MouseEvent):void {
			this.graphicsLayer.getChildByName('label_mc').visible=true;
		}
		private function labelOff(event:MouseEvent):void {
			this.graphicsLayer.getChildByName('label_mc').visible=false;
		}
		        
		public function getBandZoom():Boolean {
			return bandZoom;
		}
		
		public function setBandZoom(bandZoom:Boolean):void {
			this.bandZoom = bandZoom;
		}
		

        
		
		private function setupBandZoom():void {
			this.graphicsLayer.getChildByName("band1").addEventListener(MouseEvent.MOUSE_OVER, zoomBand1);
            this.graphicsLayer.getChildByName("band1").addEventListener(MouseEvent.MOUSE_OUT, unzoomBand1);
            this.graphicsLayer.getChildByName("band2").addEventListener(MouseEvent.MOUSE_OVER, zoomBand2);
 	 		this.graphicsLayer.getChildByName("band2").addEventListener(MouseEvent.MOUSE_OUT, unzoomBand2);
            this.graphicsLayer.getChildByName("band3").addEventListener(MouseEvent.MOUSE_OVER, zoomBand3);
 	 		this.graphicsLayer.getChildByName("band3").addEventListener(MouseEvent.MOUSE_OUT, unzoomBand3);
            this.graphicsLayer.getChildByName("band4").addEventListener(MouseEvent.MOUSE_OVER, zoomBand4);
 	 		this.graphicsLayer.getChildByName("band4").addEventListener(MouseEvent.MOUSE_OUT, unzoomBand4);
			if(this.m_bandCount == 5) {
				this.graphicsLayer.getChildByName("band5").addEventListener(MouseEvent.MOUSE_OVER, zoomBand5);
 	 			this.graphicsLayer.getChildByName("band5").addEventListener(MouseEvent.MOUSE_OUT, unzoomBand5);
			}
			
 	 		format.font = embedVerdana.fontName;
        	format.color = 0x2F3309;
        	format.size = 12;
        	format.bold = true;

			//format1 = format;
			//format1.font = "Verdana";
        	//format1.color = 0x2F3309;
        	//format1.bold = true;
			//format1.size = 6;
        	
			//KPC GOT RID OF printColor1 BECAUSE IT SEEMED REDUNDANT - CHANGED ALL ZOOM BANDS TO printColor.
        	//printColor1.defaultTextFormat = format;
 			//printColor1.height = 40;
			//printColor1.background = true;
			//printColor1.backgroundColor = 0xE5DBC6;
			//printColor1.selectable = false;
			printColor.defaultTextFormat = format;
 			//printColor.height = 40;
			printColor.background = true;
			printColor.backgroundColor = 0xE5DBC6;
			printColor.selectable = false;	
			printColor.embedFonts = true;
			printColor.antiAliasType = AntiAliasType.ADVANCED;
			
			//textX = 5; //-5
			//textY = -10; //-25
			
			printColorX = -10;
			printColorY = -20;
			
			bandX = -3;
			bandY = -30;
			band_ScaleX = 1.75;
			band1_ScaleY = 3; //2.5
			band_ScaleY = 3;
		}
		
		private function zoomBand1 (event:MouseEvent):void
		{
			trace('zoomBand1');
			//sendEvent('ENTER zoomBand1');
			var band = this.graphicsLayer.getChildByName("band1");
			band.scaleX = band_ScaleX;
			band.scaleY = band1_ScaleY;
			band.x +=bandX;
			band.y +=bandY;
					
			
 			printColor.text = colors[0];
			trace('color[0] '+colors[0]);
			printColor.width = printColor.textWidth+10;
			printColor.height = printColor.textHeight+3;
			//printColor.height=40;

			band.addChild(printColor);
			//this.printColor.alpha=.5;
			this.printColor.x = printColorX;
			this.printColor.y = printColorY; 
			
		}
		
		private function unzoomBand1 (event:MouseEvent):void
		{
			var band = this.graphicsLayer.getChildByName("band1");
			band.scaleX = 1;
			band.scaleY = 1;
			band.x -=bandX;
			band.y -=bandY;
			band.removeChild(printColor);
		}
		
		private function zoomBand2 (event:MouseEvent):void
		{
			trace('zoomBand2');
			var band = this.graphicsLayer.getChildByName("band2");
			band.scaleX = band_ScaleX;
			band.scaleY = band1_ScaleY;
			band.x +=bandX;
			band.y +=bandY;
        	
			//printColor.x = (band.x + textX);
			//printColor.y = (band.y + textY);
			printColor.text = colors[1];
			printColor.width = printColor.textWidth+10;
			printColor.height = printColor.textHeight+3;
			
			band.addChild(printColor);
			this.printColor.x = printColorX;
			this.printColor.y = printColorY; 
		 

		}

		private function unzoomBand2 (event:MouseEvent):void
		{
			var band = this.graphicsLayer.getChildByName("band2");
			band.scaleX = 1;
			band.scaleY = 1;
			band.x -=bandX;
			band.y -=bandY;
			band.removeChild(printColor);
		}

   		private function zoomBand3 (event:MouseEvent):void
		{
			
			var band = this.graphicsLayer.getChildByName("band3");
			band.scaleX = band_ScaleX;
			band.scaleY = band1_ScaleY;
			band.x +=bandX;
			band.y +=bandY;
        	
			//printColor.x = (band.x + textX);
			//printColor.y = (band.y + textY);
			printColor.text = colors[2];
			printColor.width = printColor.textWidth+10;
			printColor.height = printColor.textHeight+3;
			
			band.addChild(printColor);
			this.printColor.x = printColorX;
			this.printColor.y = printColorY; 
		}

		private function unzoomBand3 (event:MouseEvent):void
		{
			var band = this.graphicsLayer.getChildByName("band3");
			band.scaleX = 1;
			band.scaleY = 1;
			band.x -=bandX;
			band.y -=bandY;
			band.removeChild(printColor);
		}
		
		private function zoomBand4 (event:MouseEvent):void
		{
			var band = this.graphicsLayer.getChildByName("band4");
			band.scaleX = band_ScaleX;
			band.scaleY = band1_ScaleY;
			band.x +=bandX;
			band.y +=bandY;
			printColor.text = colors[3];
			printColor.width = printColor.textWidth+10;
			printColor.height = printColor.textHeight+3;
			
			band.addChild(printColor);
			this.printColor.x = printColorX;
			this.printColor.y = printColorY; 
		}

		private function unzoomBand4 (event:MouseEvent):void
		{
			var band = this.graphicsLayer.getChildByName("band4");
			band.scaleX = 1;
			band.scaleY = 1;
			band.x -=bandX;
			band.y -=bandY;
			band.removeChild(printColor);
		}
		
		private function zoomBand5 (event:MouseEvent):void
		{
			var band = this.graphicsLayer.getChildByName("band5");
			band.scaleX = band_ScaleX;
			band.scaleY = band1_ScaleY;
			band.x +=bandX;
			band.y +=bandY;
			printColor.text = colors[4];
			printColor.width = printColor.textWidth+10;
			printColor.height = printColor.textHeight+3;
			
			band.addChild(printColor);
			this.printColor.x = printColorX;
			this.printColor.y = printColorY; 
		}

		private function unzoomBand5 (event:MouseEvent):void
		{
			var band = this.graphicsLayer.getChildByName("band5");
			band.scaleX = 1;
			band.scaleY = 1;
			band.x -=bandX;
			band.y -=bandY;
			band.removeChild(printColor);
		}

		
		
        


        public function setColorBands(colors:Array) {

            const toleranceBandName:String = (m_bandCount > 4) ? "band5" : "band4";
			
			this.colors = colors;
            
            if (m_bandOneLoader != null)
                Sprite(this.graphicsLayer.getChildByName("band1")).removeChild(m_bandOneLoader);
            if (m_bandTwoLoader != null)
                Sprite(this.graphicsLayer.getChildByName("band2")).removeChild(m_bandOneLoader);
            if (m_bandThreeLoader != null)
                Sprite(this.graphicsLayer.getChildByName("band3")).removeChild(m_bandOneLoader);
            if (m_bandFourLoader != null)
                Sprite(this.graphicsLayer.getChildByName("band4")).removeChild(m_bandOneLoader);
            if (m_bandToleranceLoader != null)
                Sprite(this.graphicsLayer.getChildByName(toleranceBandName)).removeChild(m_bandToleranceLoader);
        
            //load image into Band1
            m_bandOneLoader = new Loader(); 
            Sprite(this.graphicsLayer.getChildByName("band1")).addChild(m_bandOneLoader); 
            var bandOneBitmap:URLRequest = new URLRequest(m_pngBandSuffix + "/s_" + colors[0] + ".png"); 
            m_bandOneLoader.load(bandOneBitmap); 
            
            //load image into Band2
            m_bandTwoLoader = new Loader(); 
            Sprite(this.graphicsLayer.getChildByName("band2")).addChild(m_bandTwoLoader); 
            var bandTwoBitmap:URLRequest = new URLRequest(m_pngBandSuffix + "/s_" + colors[1] + ".png"); 
            m_bandTwoLoader.load(bandTwoBitmap); 
            
            //load image into Band3
            m_bandThreeLoader = new Loader(); 
            Sprite(this.graphicsLayer.getChildByName("band3")).addChild(m_bandThreeLoader); 
            var bandThreeBitmap:URLRequest = new URLRequest(m_pngBandSuffix + "/s_" + colors[2] + ".png"); 
            m_bandThreeLoader.load(bandThreeBitmap);
            
            //load image into Band4 
            if  (colors.length == 4) {
            	m_bandFourLoader = new Loader(); 
            	Sprite(this.graphicsLayer.getChildByName("band4")).addChild(m_bandFourLoader); 
            	var bandFourBitmap:URLRequest = new URLRequest(m_pngBandSuffix + "/t_" + colors[3] + ".png"); 
            	m_bandFourLoader.load(bandFourBitmap); 
            	}
            
            else {
            	m_bandFourLoader = new Loader(); 
            	Sprite(this.graphicsLayer.getChildByName("band4")).addChild(m_bandFourLoader); 
            	var bandFourBitmap:URLRequest = new URLRequest(m_pngBandSuffix + "/s_" + colors[3] + ".png"); 
            	m_bandFourLoader.load(bandFourBitmap); 
            	}
            

            //load image into Band5
            if (colors.length > 4) {
              m_bandToleranceLoader = new Loader();
              Sprite(this.graphicsLayer.getChildByName(toleranceBandName)).addChild(m_bandToleranceLoader);
              var bandToleranceBitmap:URLRequest = new URLRequest(m_pngBandSuffix + "/t_" + colors[4] + ".png");
              m_bandToleranceLoader.load(bandToleranceBitmap);
            }
        }

    //NOTES
    //enter values because resistor is smaller on screen yet program looks at true values 
    //var hotspotWidth:Number = 12;
    //var hotspotHeight:Number = 3.4;
    //var resistorBodyWidth:Number = 43;
    //resistor rollover left x = .8
    //resistor rollover left y = 7.3
    //resistor rollover right x = 
    //hard code rollover and resistorTip values based on resistor width of 67
    //use resistor_sm.fla for guidance - set size to desired size of resistor
    //use testResistorTips to tweak resistorTip x and y values
    
        
    }
}