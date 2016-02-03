package entities.npcs 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import ui.EddyWorld;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class Lizard extends BaseNPC {
		
		private var preferredSpeed:int = 2.5;
		private var turning:Boolean = false;
		
		public function Lizard(x:Number=0, y:Number=0) {
			super(x, y);
			
			mySprite = new Spritemap(Assets.LIZARD, 24, 9);
			mySprite.add("walk left", [4, 5, 6, 7], 15);
			mySprite.add("walk right", [0, 1, 2, 3], 15);
			mySprite.add("turn right", [8, 9, 10, 11, 12], 15, false);
			mySprite.add("turn left", [12, 11, 10, 9, 8], 15, false);
			
			this.graphic = mySprite;
			mySprite.play("walk right");
			setHitbox(24, 12, 0, 3);
			
			type = "basic enemy";
		}
		
		override public function update():void {
			if (!alive) {
				GRAVITY = 0.25;
				setYSpeed(getYSpeed() + GRAVITY);
				moveBy(getXSpeed(), getYSpeed());
				if (y > EddyWorld.height) {
					destroy();
				}
				return;
			}
			
			falling();
			
			if (turning) {
				if (faceRight) {
					if (12 == mySprite.frame) {
						setXSpeed(preferredSpeed);
						turning = false;
						mySprite.play("walk right");
					}
				}
				else {
					if (8 == mySprite.frame) {
						setXSpeed( -preferredSpeed);
						turning = false;
						mySprite.play("walk left");
					}
				}
				return;
			}
			
			if (!collideTypes(["wall", "platform"], x + 10 * getXSpeed(), y + 1) || collideTypes("wall", x + getXSpeed(), y)) {
				setXSpeed(0);
				if (faceRight && !turning) {
					turning = true;
					faceRight = false;
					mySprite.play("turn left");
				}
				else if (!faceRight && !turning) {
					turning = true;
					faceRight = true;
					mySprite.play("turn right");
				}
			}
			
			moveBy(getXSpeed(), getYSpeed(), "wall");
		}
		
	}

}