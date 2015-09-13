package {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;

	public class playerBullet extends Entity{
	
		public var speed:Number = 1000;
		public var targetPosX:Number;
		public var targetPosY:Number;
		public var targetAngle:int
		
		public function playerBullet(posX:int, posY:int, targetX:int, targetY:int) {
			type = "bullet";
			setHitbox(3, 3);
			this.x = posX;
			this.y = posY;
			
			targetPosX = targetX;
			targetPosY = targetY;
			targetAngle = FP.angle(x, y, targetPosX, targetPosY) + Math.floor(Math.random() * (7 - 0 + 1)) + 0;
		}
		
		override public function render():void {
			Draw.rect(this.x, this.y, 3, 3);
		}
		
		override public function update():void {
			movement();
			collision();
			
			super.update();
		}
		
		public function movement():void {
			x += speed * Math.cos(targetAngle * FP.RAD) * FP.elapsed;
			y += speed * Math.sin(targetAngle * FP.RAD) * FP.elapsed;
		}
		
		public function collision():void {
			if (collide("enemy", x, y)) {
				FP.world.remove(this);
			}
			if (!onCamera) {
				FP.world.remove(this);
			}
		}
		
	}

}