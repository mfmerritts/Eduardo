package entities.npcs 
{
	import entities.environment.PowerUp;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import ui.EddyWorld;
	
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
			mySprite = new Spritemap(Assets.CLOCK_BOT, 37, 33, turnArround);
			health = 2;
			mySprite.add("walk left", [5, 6, 7], 15);
			mySprite.add("walk right", [8, 9, 10], 15);
			mySprite.add("turn left", [8, 4, 4, 5], 15);
			mySprite.add("turn right", [5, 4, 4, 8], 15);
			this.drops = drops;
			this.graphic = mySprite;
			mySprite.play("left");
			setHitbox(33, 33, -2, 0);
			setXSpeed( -1.5);
			type = "mech enemy";
			
		}
		
		private function turnArround():void {
			if (turning) {
				turning = false;
				if (faceRight) {
					mySprite.play("walk right");
					setXSpeed(1.5);
				}
				else {
					mySprite.play("walk left");
					setXSpeed( -1.5);
				}
			}
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
			
			if (getYSpeed() > 0 && !collide("platform", x, y)) {
				moveBy(0, getYSpeed(), ["wall", "platform"], true);
			}
			else {
				moveBy(0, getYSpeed(), "wall");
			}
			
			moveBy(getXSpeed(), 0, "wall");
		}
		
	}

}