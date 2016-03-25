package entities.environment.blocks 
{
	import entities.Collidable;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class Demolishable extends Entity implements Collidable {
		
		private var iFrames:int = 0;
		private var mySprite:Spritemap;
		
		public function Demolishable(_type:String, x:Number = 0, y:Number = 0) {
			this.x = x;
			this.y = y;
			
			if (_type == "rocks") {
				name = "rock";
				type = "wall";
				mySprite = new Spritemap(Assets.ROCK_WALL, 24, 24);
			}
			graphic = mySprite;
			setHitbox(24, 24);
		}
		
		override public function update():void {
			if (collide("hammer", x, y)) {
				if (iFrames <= 0) {
					onCollision(2, 2, 0);
					iFrames = 30;
				}
			}
			if (iFrames >= 0) {
				iFrames--;
			}
		}
		
		public function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void {
			if (name == "rock") {
				if (int(v2) == 2) {
					if (mySprite.frame < 2) {
						mySprite.frame += 1;
					}
					else {
						FP.world.remove(this);
					}
				}
			}
		}
		
	}
}