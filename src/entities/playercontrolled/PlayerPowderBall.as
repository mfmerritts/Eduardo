package entities.playercontrolled 
{
	import entities.npcs.BaseNPC;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class PlayerPowderBall extends BaseNPC 
	{
		
		private var poof:Boolean = false;
		
		public function PlayerPowderBall(x:Number, y:Number, speed:Number) {
			this.x = x;
			this.y = y;
			setXSpeed(speed);
			setYSpeed( -1);
			GRAVITY = 0.1;
			drag = 0.03;
			mySprite = new Spritemap(Assets.PROJECTILES, 8, 8);
			mySprite.add("powder", [3], 0);
			setHitbox(8, 8, 0, 0);
			graphic = mySprite;
			mySprite.play("powder");
			type = "powder";
		}
		
		override public function update():void {
			if (onGround || collide("wall", x + getXSpeed(), y)) {
				if (!poof) {
					poof = true;
					mySprite = new Spritemap(Assets.LOCK, 8, 8, destroy);
					graphic = mySprite;
					mySprite.add("flare", [1, 2, 3, 3], 20, false);
					mySprite.play("flare");
					setHitbox(16, 16);
					y -= 8;
				}
				
			}
			
			if (collideTypes(["basic enemy", "plant enemy"], x, y)) {
				if (!poof) {
					poof = true;
					mySprite = new Spritemap(Assets.LOCK, 8, 8, destroy);
					graphic = mySprite;
					mySprite.add("flare", [1, 2, 3, 3], 20, false);
					mySprite.play("flare");
					setHitbox(16, 16);
					y -= 6;
				}
				
				var other:BaseNPC = BaseNPC(collideTypes(["basic enemy", "plant enemy", "slime"], x, y));
				other.onCollision(1, 3);
			}
			
			if (poof) {
				mySprite.scaledWidth = 4 * (1 + mySprite.frame);
				mySprite.scaledWidth = 4 * (1 + mySprite.frame);
			}
			
			objectMove();
		}
		
	}

}