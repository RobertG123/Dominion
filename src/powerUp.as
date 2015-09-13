package {
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;

	public class powerUp extends Entity{
		
		public function powerUp(posX:int, posY:int) {
			
			type = "powerUp";
			setHitbox(20, 20);
			
			this.x = posX * 50;
			this.y = posY * 50;
					
		}
		
		override public function render():void {
			Draw.rect(this.x, this.y, 20, 20, 0xFF1111);
			addGraphic(new Text("H+"));
			super.render();
		}
		
		override public function update():void {
			heal();
		}
		
		public function heal():void {
			if (collide("player", x, y)) {
				player.health = 100;
				FP.world.remove(this);
			}
		}
	}

}