package entities.playercontrolled 
{
	import entities.npcs.BaseNPC;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class PlayerFireball extends BaseNPC {
		
		private var flare:Boolean = false;
		
		public function PlayerFireball(x:Number, y:Number, speed:Number) {
			this.x = x;
			this.y = y;
			setXSpeed(speed);
			setYSpeed( -1);
			GRAVITY = 0.1;
			drag = 0.05;
			mySprite = new Spritemap(Assets.PROJECTILES, 8, 8);
			mySprite.add("fire", [1, 2], 10);
			setHitbox(8, 8, 0, 0);
			graphic = mySprite;
			mySprite.play("fire");
			type = "fire";
		}
		
		override public function update():void {
			if (onGround || collide("wall", x + getXSpeed(), y)) {
				if (!flare) {
					flare = true;
					mySprite = new Spritemap(Assets.FIRE, 16, 20, destroy);
					graphic = mySprite;
					mySprite.add("flare", [0, 1, 2, 3, 4], 20, false);
					mySprite.play("flare");
					setHitbox(16, 20);
					y -= 8;
				}
			}
			
			if (collideTypes(["basic enemy", "plant enemy"], x, y)) {
				if (!flare) {
					flare = true;
					mySprite = new Spritemap(Assets.FIRE, 16, 20, destroy);
					graphic = mySprite;
					mySprite.add("flare", [0, 1, 2, 3, 4], 20, false);
					mySprite.play("flare");
					setHitbox(16, 20);
					y -= 8;
				}
				var other:BaseNPC = BaseNPC(collideTypes(["basic enemy", "plant enemy"], x, y));
				other.onCollision(1, 1);
			}
			
			objectMove();
		}
		
		override public function destroy():void {
			FP.world.remove(this);
		}
	}

}