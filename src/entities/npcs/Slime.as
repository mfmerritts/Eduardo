package entities.npcs 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class Slime extends BaseNPC {
		
		private var timer:int = 30;
		private var player:Entity;
		private var jumping:Boolean;
		
		public function Slime(x:Number=0, y:Number=0) {
			super(x, y);
			mySprite = new Spritemap(Assets.SLIME, 32, 24, jump);
			setHitbox(28, 24, -2, 0);
			mySprite.add("jump", [0, 1, 0, 1, 0, 1, 0, 1, 0, 2], 10, false);
			type = "slime";
			graphic = mySprite;
			mySprite.play("jump");
		}
		
		private function jump():void {
			jumping = true;
			setYSpeed( -4);
			y -= 2;
			timer = 2;
			if (x > player.x) {
				setXSpeed( -3.2);
				mySprite.scaleX = 1;
				mySprite.originX = 0;
			}
			else {
				setXSpeed(3.2);
				mySprite.scaleX = -1;
				mySprite.originX = 20;
			}
			mySprite.frame = 2;
		}
		
		override public function update():void {
			if (player == null) {
				player = FP.world.getInstance("eddy");
			}
			
			if (!alive) {
				mySprite.frame = 5;
				setYSpeed(getYSpeed() + GRAVITY);
				moveBy(getXSpeed(), getYSpeed());
				if (!onCamera) {
					destroy();
				}
				return;
			}
			
			if (type == "wall") {
				objectMove();
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
					timer = 3;
					jumping = false;
				}
			}
			
			objectMove();
		}
		
		override public function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void {
			health--;
			if (int(v2) == 3) {
				type = "wall";
				mySprite.frame = 3;
				setXSpeed(0);
			}
			else if (health <= 0) {
				alive = false;
				collidable = false;
				mySprite.scaledHeight = -height;
				type = "none";
			}
		}
		
	}

}