package {
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.World;
	
	public class enemy_ti extends Entity {
		
		private var speed:Number = 30 * FP.elapsed; //Maximum Movement Speed
		private var facing:Number = 0;	//Direction Stopped Moving
		
		private var health:Number = 20; //Maximum Health
		public static var totalEnemies:Number = 0;
		
		//Load Enemy Graphic
		[Embed(source = "assets/enemy_ti_sprite.png")] private const ENEMY_TI:Class;
		public var sprEnemy_ti:Spritemap = new Spritemap(ENEMY_TI, 10, 16);
		
		public function enemy_ti(posX:int, posY:int) {
			//Create Animations
			sprEnemy_ti.add("walk_right", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 20, true);
			sprEnemy_ti.add("walk_left", [12, 13, 14, 15, 16, 17, 18, 19, 20], 20, true);
			sprEnemy_ti.add("walk_up", [23, 24, 25, 26, 27, 28], 20, true);
			sprEnemy_ti.add("walk_down", [34, 35, 36, 37, 38, 39], 20, true);
			graphic = sprEnemy_ti;
			
			sprEnemy_ti.scale = 3;
			
			layer = -3;
			//layer = Math.ceil(y * -3);
			
			//Meta info
			setHitbox(28, 48);
			type = "enemy";

			this.x = posX * 50;
			this.y = posY * 50;
		}
		
		override public function added():void {
			var safeSpawnZone:Number = FP.distance(this.x, this.y, player.playerX, player.playerY);
			if (safeSpawnZone < 150) {
				if (this.x < player.playerX) {
					this.x -= 100;
				} else {
					this.x += 100;
				}
				if (this.y < player.playerY) {
					this.y -= 100;
				} else {
					this.y += 100;
				}
			}
			while (this.collide("enemy", x, y)) {
				x++;
				y++;
			}
		}
		
		override public function update():void {
			moveTowards(player.playerX, player.playerY, speed, "enemy");
			
			playAnimation();
			
			if (collide("bullet", x, y)) {
				health -= FP.rand(7) + 1;
			}
			if (health < 10) {
				sprEnemy_ti.alpha = 0.5;
			}
			if (health < 1) {
				killed();
			}
			
			super.update();
		}
		
		public function playAnimation():void {
				if (this.x < player.playerX) {
					sprEnemy_ti.play("walk_right");
				} else {
					sprEnemy_ti.play("walk_left");
				}
			
		}
		
		public function killed():void {
			FP.world.recycle(this);
			totalEnemies--;
			player.totalKills++;
		}
		
	}
}