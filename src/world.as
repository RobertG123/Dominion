package {
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	
	public class world extends World {
		
		public var thePlayer:player;
		
		//Spawn Parameters
		
		public var timer:Number = 3;
		public var spawnTotal:int = 3;
		public var randChance:int;
		
		public var maxSpawnX:int =20;
		public var maxSpawnY:int =14;
		public var randSpawnX:Number;
		public var randSpawnY:Number;
		
		
		public function world() {
			FP.console.log("World Loaded");
		}
		
		override public function begin():void {
			
			thePlayer = player(add(new player(FP.halfWidth - 5, FP.halfHeight - 8)));
			add (new gameUI());
		}
		
		override public function update():void {
			timer +=  FP.elapsed;
			
			//Spawn Power Ups
			
			if (timer > 5) {
				if (enemy_ti.totalEnemies < 51) {
					randChance = FP.rand(20);
					if (randChance == 1) {
						randSpawnX = FP.rand(maxSpawnX);
						randSpawnY = FP.rand(maxSpawnY);
						add(new powerUp(randSpawnX, randSpawnY));
					}
				}
			}
			
			//Spawn Enemies
			if (timer > 5) {
				if (enemy_ti.totalEnemies < 51) {
					for (var i:int = 0; i < spawnTotal; i++) {
						randSpawnX = FP.rand(maxSpawnX);
						randSpawnY = FP.rand(maxSpawnY);
						add (new enemy_ti(randSpawnX, randSpawnY));
					}
					timer = 0;
					enemy_ti.totalEnemies += spawnTotal;
					spawnTotal++;
				}
			}
			
			super.update();
		}
		
		
	}
}