package org.concord.sparks {

    import flash.events.ErrorEvent;
    import flash.external.ExternalInterface;
    
    import org.concord.sparks.Activity;
    
    // Interface with external JavaScript
    public class JavaScript {
  
        private static var _instance:JavaScript;
        private static var _fromWithin:Boolean = false;

        private var activity:Activity;

        public static function instance() {
          if (! _instance) {
            _fromWithin = true;
            _instance = new JavaScript();
            _fromWithin = false;
          }
          return _instance;
        }

        public function JavaScript() {
            if (! _fromWithin) {
              throw new Error("Constructor JavaScript() is not supposed to be called from outside.");
            }
            this.activity = activity;
            setupCallbacks();
        }

        public function setActivity(activity:Activity) {
            this.activity = activity;
        }
        
        public function call(func:String, ... values) {
            var args = values;
            args.unshift(func);
            if (ExternalInterface.available) {
                ExternalInterface.call.apply(null, args);
            }
            else {
                trace('ExternalInterface unavailable: tried to call ' + func + '(' + args + ')');
            }
        }
        
        public function sendEvent(name:String, ... values) {
            var time = String(new Date().valueOf());
            if (ExternalInterface.available) {
                ExternalInterface.call('receiveEvent', name, values.join('|'), time);
            }
            else {
                trace('ExternalInterface unavailable: tried to call receiveEvent(' + name + ', '  + values.join('|') + ', ' + time + ')');
            }
        }
        
        private function setupCallbacks():void {
            if (ExternalInterface.available) {
                ExternalInterface.addCallback("sendMessageToFlash",
                    getMessageFromJavaScript);
            }
        }
        
        private function parseParameter(parm) {
            var tokens:Array = parm.split(':');
            switch (tokens[1]) {
                case "int":
                    return parseInt(tokens[0]);
                default: //string
                    return tokens[0];
            }
        }

        private function getMessageFromJavaScript(... Arguments):String {
            try {
                return activity.processMessageFromJavaScript(Arguments);
            }
            catch (e:ErrorEvent) {
                return 'flash_error|' + e.toString();
            }
            catch (e:Error) {
                return 'flash_error|' + e.name + '\n' + e.message + '\n' + e.getStackTrace();
            }
            return 'flash_error|this point should be unreachable';
        }
    }
}
