package entities.npcs 
{
	import entities.environment.PowerUp;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class JumpRobot extends BaseNPC {
		
		private var drops:int;
		private var timer:int = 30;
		private var player:Entity;
		private var jumping:Boolean;
		
		public function JumpRobot(x:Number=0, y:Number=0, drops:int=0) {
			super(x, y);
			type = "mech enemy";
			health = 2;
			mySprite = new Spritemap(Assets.JUMPBOT, 20, 32, jump);
			mySprite.add("jump", [0, 1, 2, 3, 4, 5, 6, 7], 15, false);
			this.drops = drops;
			graphic = mySprite;
			setHitbox(20, 32);
			mySprite.play("jump");
			health = 2;
		}
		
		/**
		 * Called When the animation finishes and causes the robot to jump.
		 */
		private function jump():void {
			jumping = true;
			setYSpeed( -4);
			y -= 2;
			timer = 20;
			if (x > player.x) {
				setXSpeed( -2);
				mySprite.scaleX = 1;
				mySprite.originX = 0;
			}
			else {
				setXSpeed(2);
				mySprite.scaleX = -1;
				mySprite.originX = 20;
			}
			mySprite.frame = 7;
		}
		
		override public function update():void {
			if (player == null) {
				player = FP.world.getInstance("eddy");
			}
			
			if (!alive) {
				mySprite.frame = 5;
				setYSpeed(getYSpeed() + GRAVITY);
				moveBy(getXSpeed(), getYSpeed());
				if (drops > 0) {
					FP.world.add(new PowerUp(x, y + 4, drops));
					drops = 0;
				}
				if (!onCamera) {
					destroy();
				}
				return;
			}
			
			if (Math.abs(x - player.x) > 210 || Math.abs(y - player.y) > 180) {
				return;
			}
			
			if (onGround) {
				timer--;
				if (timer <= 0) {
					mySprite.play("jump");
				}
			}
			else if (jumping) {
				timer--;
				if (timer > 0) {
					setYSpeed( -4);
				}
				else {
					timer = 18;
					jumping = false;
				}
			}
			
			
			objectMove();
		}
		
	}

}