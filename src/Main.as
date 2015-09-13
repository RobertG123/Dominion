package {
	import net.flashpunk.*;
	
	public class Main extends Engine {
		
		public static var muted:Boolean = false;
		
		public function Main() {
			super(1024, 768, 60, false);
			FP.console.log("Engine Initialised");
		}
		override public function init():void {
			FP.world = new world();
			FP.screen.color = 0x999999;
			//FP.console.enable(); //Debug Console
		}
	}
}