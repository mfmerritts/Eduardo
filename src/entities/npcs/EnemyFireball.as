package entities.npcs 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class EnemyFireball extends BaseNPC {
		
		private var timer:int = 15;
		
		public function EnemyFireball(x:Number = 0, y:Number = 0, speed:Number = 0, direction:Number = 0) {
			super(x, y);
			type = "bullet";
			setSpeed(speed);
			setDirection(direction);
			GRAVITY = 0.1;
			drag = 0.05;
			mySprite = new Spritemap(Assets.PROJECTILES, 8, 8);
			mySprite.add("flicker", [1, 2], 15);
			mySprite.play("flicker");
			graphic = mySprite;
			setHitbox(8, 8);
		}
		
		override public function update():void {
			objectMove();
			if (onGround) {
				timer--;
			}
			if (timer <= 0) {
				destroy();
			}
		}
		
	}

}