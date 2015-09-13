package {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;

	public class gameUI extends Entity {
		
		private var _time:Number = 0;
		
		private var timeTXT:Text;
		private var healthTXT:Text;
		private var ammoTXT:Text;
		private var killsTXT:Text;
		private var mutedTXT:Text;
		private var metaTXT:Text;
		
		public function gameUI() {
			FP.world.addGraphic(timeTXT = new Text("", 5, 5));
			timeTXT.size = 20;
			FP.world.addGraphic(healthTXT = new Text("", 5, 25));
			healthTXT.size = 20;
			FP.world.addGraphic(ammoTXT = new Text("", 5, 45));
			ammoTXT.size = 20;
			FP.world.addGraphic(killsTXT = new Text("", 5, 85));
			killsTXT.size = 20;
			
			FP.world.addGraphic(metaTXT = new Text("Update 7", 970, 756));
			metaTXT.size = 10;
			layer = -1;
		}
		
		override public function update():void {
			_time += FP.elapsed;
			
			timeTXT.text = "Time: " + _time.toFixed(2);
			healthTXT.text = "Health: " + player.health.toString();
			ammoTXT.text = "Ammo: " + player.currantAmmo.toString();
			killsTXT.text = "Kills: " + player.totalKills.toString();
			
			if (player.currantAmmo < 10) {
				ammoTXT.color = 0xFF0000;
			} else {
				ammoTXT.color = 0xFFFFFF;
			}
			
			if (player.health < 20) {
				healthTXT.color = 0xFF0000;
			} else {
				healthTXT.color = 0xFFFFFF;
			}

			super.update();
		}
		
	}

}