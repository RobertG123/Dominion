package {
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
		
	public class player extends Entity {
		
		private var speed:Number = 100; //Maximum Movement Speed
		private var facing:Number = 0;	//Direction Stopped Moving
		private var shootTimer:int = 13;
		private var playShootSFX:Boolean = false;
		
		public static var maxAmmo:int = 50;
		public static var currantAmmo:int = maxAmmo;
		public static var playerX:Number;
		public static var playerY:Number;
		public static var alive:Boolean = true;
		public static var health:Number = 100; // Player Health
		public static var totalKills:Number = 0;

		//Load Player Graphic
		[Embed(source = "assets/player_sprite.png")] private const PLAYER:Class;
		public var sprPlayer:Spritemap = new Spritemap(PLAYER, 10, 16);
		
		public function player (xPos:int, yPos:int) {
			
			//Define Inputs
			Input.define("movement", Key.A, Key.LEFT, Key.D, Key.RIGHT, Key.W, Key.UP, Key.S, Key.DOWN);
			Input.define("left", Key.A, Key.LEFT);
			Input.define("right", Key.D, Key.RIGHT);
			Input.define("up", Key.W, Key.UP);
			Input.define("down", Key.S, Key.DOWN);
			Input.define("jump", Key.SPACE);
			
			//Create Animations
			sprPlayer.add("stand_right", [0], 20, true);
			sprPlayer.add("walk_right", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 20, true);
			
			sprPlayer.add("stand_left", [11], 20, true);
			sprPlayer.add("walk_left", [12, 13, 14, 15, 16, 17, 18, 19, 20], 20, true);
			
			sprPlayer.add("stand_up", [22], 20, true);
			sprPlayer.add("walk_up", [23, 24, 25, 26, 27, 28], 20, true);
			
			sprPlayer.add("stand_down", [33], 20, true);
			sprPlayer.add("walk_down", [34, 35, 36, 37, 38, 39], 20, true);
			graphic = sprPlayer;
			
			sprPlayer.scale = 3;
			//Meta info
			setHitbox(28, 48);
			type = "player";
			
			this.x = xPos;
			this.y = yPos;
		
		}
		
		override public function update():void {
			playerX = this.x;
			playerY = this.y;
			
			movement();
			shoot();
			takeDamage();
			if (shootTimer < 12) {
				shootTimer++;
			}
			
			super.update();
		}
		
		public function movement():void {
			//Movements
			if (Input.check("left")) {
					moveBy( -speed * FP.elapsed, 0);
					sprPlayer.play("walk_left");
					facing = 0;
			}
			if (Input.check("right")) {
					moveBy(speed * FP.elapsed, 0);
					sprPlayer.play("walk_right");
					facing = 1;
			}
			
			if (Input.check("up")) {
				
					moveBy(0, -speed * FP.elapsed);
					facing = 2;
					
					if (Input.check("left")) {
						sprPlayer.play("walk_left");
					} else if (Input.check("right")) {
						sprPlayer.play("walk_right");
					} else {
						sprPlayer.play("walk_up");
					}
			}
			
			if (Input.check("down")) {
					moveBy(0, speed * FP.elapsed);
					facing = 3;
					
					if (Input.check("left")) {
						sprPlayer.play("walk_left");
					} else if (Input.check("right")) {
						sprPlayer.play("walk_right");
					} else {
						sprPlayer.play("walk_down");
					}
			}
			//Standing Direction
			if (Input.released("movement")) {
				if (facing == 0) {
					sprPlayer.play("stand_left");
				} else if (facing == 1) {
					sprPlayer.play("stand_right");
				} else if (facing == 2) {
					sprPlayer.play("stand_up");
				} else {
					sprPlayer.play("stand_down");
				} 
			}
		}

		public function shoot():void {
			if (Input.mouseDown && shootTimer > 4 && currantAmmo > 0) {
				playShootSFX = true;
				FP.world.add(new playerBullet(this.x + 10, this.y + 15, world.mouseX, world.mouseY));
				shootTimer = 0;
				currantAmmo--;
			} 
			
			if (Input.pressed(Key.R)) {
				currantAmmo = maxAmmo;
				
			}

		}
		
		public function takeDamage():void {
			if (collide("enemy", x, y) && health > -1) {
				health -= 1;
			}
			if (health < 0) {
				FP.world.remove(this);
				FP.world.active = false;
				
				alive = false;
			}
		}
	}
}