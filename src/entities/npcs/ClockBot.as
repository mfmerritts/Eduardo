package entities.npcs 
{
	import entities.environment.PowerUp;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class ClockBot extends BaseNPC {
		
		private var player:Entity;
		private var turning:Boolean = false;
		private var drops:int;
		
		public function ClockBot(x:Number=0, y:Number=0, drops:int=0) {
			super(x, y);
			mySprite = new Spritemap(Assets.CLOCK_BOT, 37, 33);
			
			mySprite.add("walk left", [5, 6, 7], 15);
			mySprite.add("walk right", [8, 9, 10], 15);
			mySprite.add("turn left", [8, 4, 5], 15);
			mySprite.add("turn right", [5, 4, 8], 15);
			this.drops = drops;
			this.graphic = mySprite;
			mySprite.play("left");
			setHitbox(33, 33, -2, 0);
			
			type = "mech enemy";
			
		}
		
		override public function update():void {
			if (!alive) {
				GRAVITY = 0.25;
				setYSpeed(getYSpeed() + GRAVITY);
				moveBy(getXSpeed(), getYSpeed());
				if (drops != 0) {
					FP.world.add(new PowerUp(x + 4, y + 3, drops));
					drops = 0;
				}
				if (y > EddyWorld.height) {
					destroy();
				}
				return;
			}
			
			falling();
			
			if (turning) {
				if (faceRight) {
					if (12 == mySprite.frame) {
						setXSpeed(2);
						turning = false;
						mySprite.play("walk right");
					}
				}
				else {
					if (8 == mySprite.frame) {
						setXSpeed( -2);
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