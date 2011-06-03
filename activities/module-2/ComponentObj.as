﻿package
{
    import flash.display.Loader;
    import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.net.URLRequest;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    
	import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
	
	import Lead;
    import org.concord.sparks.JavaScript;
    import Globe;
	
	public class ComponentObj extends MovieClip{	
	
		// NOTE!!!
		// For a component to work, it must have all graphics contained in a MovieClip given an instance name, "graphics_mc"
		// (this has to do with the adjusting of z-order of the leads and the other graphics
			
		private var _breadboard:MovieClip;
		private var _lead1:Lead_mc;
		private var _lead2:Lead_mc;
		private var _componentName:String;
		private var _leadLayer:MovieClip;
		
		//////////public variables for breadboard probeQuery_handler
        public var blackProbeOnLead2:Boolean = false;
        public var redProbeOnLead2:Boolean = false;
        public var blackProbeOnLead1:Boolean = false;
        public var redProbeOnLead1:Boolean = false;
        
        private var sndClickIt:clickit3;
        private var sndClickItChannel:SoundChannel;
        private var transform1:SoundTransform=new SoundTransform();
        
        private var componentTipLead1X:Number;
        private var componentTipLead1Y:Number;
        private var componentTipLead2X:Number;
        private var componentTipLead2Y:Number;
        
        private var currentHoleOne:MovieClip = null;
        private var currentHoleTwo:MovieClip = null;
        
        private var componentLead1Location:String;
        private var componentLead2Location:String;
        
        private var localProbeBlackLead1Location:String = null;
        private var localProbeBlackLead2Location:String = null;
        private var localProbeRedLead1Location:String = null;
        private var localProbeRedLead2Location:String = null;
    
        //KPC variables to adjust color for probe engaged and rollovers
        private var rolloverColor:ColorTransform = new ColorTransform();
        private var engagedColor:ColorTransform = new ColorTransform();
        private var originalColor:ColorTransform = new ColorTransform();



	
		public function ComponentObj() {
			trace('ENTER ComponentObj');

			super();
			
			_leadLayer = new MovieClip();
			_lead1 = new Lead_mc();
			_lead2 = new Lead_mc();
			this.addChild(_leadLayer);
			this._leadLayer.addChild(_lead1);
			this._leadLayer.addChild(_lead2);
			
			//default position (fits resistors)
			_lead1.x = 0;
			_lead1.y = 0;
			_lead2.x = 175;
			_lead2.y = 0;
			_lead2.scaleX = -1;

			_lead1.setComponentObj(this);
			_lead1.setComponentName(this.name);
			
			_lead2.setComponentObj(this);
			_lead2.setComponentName(this.name);
			//_breadboard = breadboard;
			//_breadboard.getComponentLayer().addChild(this);
			
			this.addEventListener(Event.ADDED_TO_STAGE, added_to_stage_handler);
            this.addEventListener(Event.REMOVED_FROM_STAGE, removed_from_stage_handler);
            this.addEventListener(Event.ENTER_FRAME, componentLocationInitialValues)
        
            if (stage != null) {
                stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            }

		}
		
		
		public function positionLeads(lead:Lead, x:Number, y:Number, angle:Number):void {
			lead.x = x;
			lead.y = y;
			angle = angle*180/Math.PI; // rad -> deg
			lead.rotation = angle;
		}
		
		public function putLeadsOnBottom():void {
			var leads:DisplayObjectContainer = _leadLayer;
			var sortableContainer:DisplayObjectContainer = this;
			var sorted:Boolean = false;
			
			while(sorted == false) {
				sorted = true;
				if(sortableContainer.numChildren >= 2) {
					for(var i:int =1; i< sortableContainer.numChildren; i++){
    					var mc1:DisplayObject = sortableContainer.getChildAt(i-1);
    					var mc2:DisplayObject = sortableContainer.getChildAt(i);
            			if (mc2 == leads){
    						sortableContainer.swapChildrenAt(i-1,i);
							sorted = false;
   						}
   					}
				}
			}
		}
		
		public function getEnds():Array {
            return [_lead1, _lead2];
        }
        
       	public function disconnect(lead:Lead):void {
			JavaScript.instance().sendEvent('disconnect', 'component', this.name, lead.getLocation());
            trace('lead.getLocation'+lead.getLocation());
        }
		public function connect(lead:Lead):void {
			JavaScript.instance().sendEvent('connect', 'component', this.name, lead.getLocation());
		}
		
		private function mouseUpHandler(mevt:MouseEvent):void
        {
            onComponentMove_handler(mevt);
        }
        
        private function mouseMoveHandler(mevt:MouseEvent):void {
        }
        
        private function added_to_stage_handler(evt:Event):void
        {
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        }
        
        private function removed_from_stage_handler(evt:Event):void
        {
            stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        }
        
        private function componentLocationInitialValues(event:Event):void
        {
			//trace('ENTER ComponentObj#ComponentLocationInitailValues');
            componentTipLead1X = this.x + (_lead1.getLeadMovieClip().parent.x);
            componentTipLead1Y = this.y + _lead1.getLeadMovieClip().parent.y;
            componentTipLead2X = this.x + (_lead2.getLeadMovieClip().parent.x);
            componentTipLead2Y = this.y + _lead2.getLeadMovieClip().parent.y;

            componentOnBoard();
            //  replace 'color string' with the actual values of the components in ohms.
            //componentName = ExternalInterface.call('breadModel', 'insert', 'component', componentLead1Location + ',' + componentLead2Location, bandOneColor + ',' + bandTwoColor + ',' + bandThreeColor + ',' + bandFourColor);
            removeEventListener(Event.ENTER_FRAME, componentLocationInitialValues);
        }
        
        
        
      	public function componentOnBoard():void {  // assigns leads their hole position
            trace('ENTER ComponentObj#componentOnBoard');
            
           /* if (currentHoleOne !== null) {
                currentHoleOne.gotoAndStop(1);
                currentHoleOne = null;
            }
            
            if (currentHoleTwo !== null ) {
                currentHoleTwo.gotoAndStop(1);
                currentHoleTwo = null;
            }*/
            
            //for every row ...
            if (parent.parent != null && MovieClip(parent.parent).rows != null) {
            	//trace('for every row');
                var boardRow:String;
                var h:MovieClip;
            	// check holes on main board
                for (var rowNum:int = 1; rowNum <= 10; rowNum++) {
                	//trace('rows '+rowNum);
                    //start at Lead1 of grid
                    //accessing the list of row by index
                    var row:Array = MovieClip(parent.parent).rows[rowNum]; 
                    
                    //for every hole in the row...
                    for (var holeNum:int = 1; holeNum <= 30; holeNum++) {
                    	//trace('holes '+holeNum);
                        h = row[holeNum];
                        //trace("h.x = " + h.x + " " + "h.y = " + h.y);
                        boardRow = String.fromCharCode("a".charCodeAt(0) + rowNum - 1);
                        
                        if (componentTipLead1X > h.x &&  componentTipLead1X < h.x + 12  &&  componentTipLead1Y > h.y &&  componentTipLead1Y < h.y + 12) {
                            currentHoleOne = h;
                            h.gotoAndStop(2);
                            componentLead1Location = boardRow + holeNum;
                            trace (this.name + " " + componentLead1Location + " Lead1 On" );
							_lead1.setLocation(componentLead1Location); //jonah		
                        }
                        if (  (componentTipLead2X > h.x) &&  (componentTipLead2X < h.x + 12)  &&  (componentTipLead2Y > h.y) &&  (componentTipLead2Y < h.y + 12) ) {
                            currentHoleTwo = h;
                            h.gotoAndStop(2);
                            componentLead2Location = boardRow+holeNum;
                            trace (this.name + " " + componentLead2Location + " Lead2 On" );
							_lead2.setLocation(componentLead2Location); //jonah
                        }
                        if (componentLead1Location != "empty") {
                        }
                        
                        if (componentLead2Location != "empty") {
                        }
                    }
                }
				// check pos rows
				for (var posRowNum:int = 1; posRowNum <=2; posRowNum++){
					row = MovieClip(parent.parent).posRows[posRowNum];
					for (holeNum = 1; holeNum<=25; holeNum++) {
						h = row[holeNum];
						boardRow = String(posRowNum);
						if(componentTipLead1X > h.x && componentTipLead1X < h.x + 12 && componentTipLead1Y > h.y && componentTipLead1Y <h.y + 12) {
							currentHoleOne = h;
							h.gotoAndStop(2);
							
							if(boardRow == '1') { boardRow = 'left_positive';} 
							else if (boardRow == '2') { boardRow = 'right_positive';}
							
							componentLead1Location = boardRow + holeNum;
							trace(this.name + " " + componentLead1Location + " Lead1 On" );
							_lead1.setLocation(componentLead1Location); //jonah
						}
						if (  (componentTipLead2X > h.x) &&  (componentTipLead2X < h.x + 12)  &&  (componentTipLead2Y > h.y) &&  (componentTipLead2Y < h.y + 12) ) {
                            currentHoleTwo = h;
                            h.gotoAndStop(2);
							
							if(boardRow == '1') { boardRow = 'left_positive';} 
							else if (boardRow == '2') { boardRow = 'right_positive';}
							
                            componentLead2Location = boardRow+holeNum;
                            trace (this.name + " " + componentLead2Location + " Lead2 On" );
							_lead2.setLocation(componentLead2Location); //jonah
                        }
                        if (componentLead1Location != "empty") {
                        }
                        
                        if (componentLead2Location != "empty") {
						}
					}
				}
				// check neg rows
				for (var negRowNum:int = 1; negRowNum <=2; negRowNum++){
					row = MovieClip(parent.parent).negRows[negRowNum];
					for (holeNum = 1; holeNum<=25; holeNum++) {
						h = row[holeNum];
						boardRow = String(negRowNum);
						if(componentTipLead1X > h.x && componentTipLead1X < h.x + 12 && componentTipLead1Y > h.y && componentTipLead1Y <h.y + 12) {
							currentHoleOne = h;
							h.gotoAndStop(2);
							
							if(boardRow == '1') { boardRow = 'left_negative';} 
							else if (boardRow == '2') { boardRow = 'right_negative';}
							
							componentLead1Location = boardRow + holeNum;
							trace(this.name + " " + componentLead1Location + " Lead1 On" );
							_lead1.setLocation(componentLead1Location); //jonah
						}
						if (  (componentTipLead2X > h.x) &&  (componentTipLead2X < h.x + 12)  &&  (componentTipLead2Y > h.y) &&  (componentTipLead2Y < h.y + 12) ) {
                            currentHoleTwo = h;
                            h.gotoAndStop(2);
							
							if(boardRow == '1') { boardRow = 'left_negative';} 
							else if (boardRow == '2') { boardRow = 'right_negative';}
							
                            componentLead2Location = boardRow+holeNum;
                            trace (this.name + " " + componentLead2Location + " Lead2 On" );
							_lead2.setLocation(componentLead2Location); //jonah
                        }
                        if (componentLead1Location != "empty") {
                        }
                        
                        if (componentLead2Location != "empty") {
						}
					}
				}
            }
        }
        
        private function onComponentMove_handler(event:MouseEvent):void
        {
            var newComponentTipLead1X:Number = this.x + (_lead1.getLeadMovieClip().x);
            var newComponentTipLead1Y:Number = this.y + _lead1.getLeadMovieClip().y;
            var newComponentTipLead2X:Number = this.x + (_lead2.getLeadMovieClip().x);
            var newComponentTipLead2Y:Number = this.y +_lead2.getLeadMovieClip().y;  
            
            if ((newComponentTipLead1X != componentTipLead1X) || (newComponentTipLead1Y != componentTipLead1Y) )
            {
                componentTipLead1X = newComponentTipLead1X;
                componentTipLead1Y = newComponentTipLead1Y;
                componentTipLead2X = newComponentTipLead2X;
                componentTipLead2Y = newComponentTipLead2Y;
                this.componentOnBoard();
            }
            
            else if ((newComponentTipLead2X != componentTipLead2X) || (newComponentTipLead2Y != componentTipLead2Y) )
            {
                componentTipLead1X = newComponentTipLead1X;
                componentTipLead1Y = newComponentTipLead1Y;
                componentTipLead2X = newComponentTipLead2X;
                componentTipLead2Y = newComponentTipLead2Y;
                this.componentOnBoard();
            }
        }
        
		
	}
}