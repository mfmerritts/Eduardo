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
	public class FireHat extends BaseNPC {
		
		private var stroll:Boolean = false;
		private var shooting:Boolean = false;
		private var drops:Boolean;
		private var timer:int = 30;
		private var player:Entity;
		
		public function FireHat(x:Number = 0, y:Number = 0, drops:String = "False") {
			this.x = x;
			this.y = y;
			if (drops == "True") {
				this.drops = true;
			}
			else {
				this.drops = false;
			}
			mySprite = new Spritemap(Assets.FIRE_HAT, 18, 21, nextAction);
			mySprite.add("left", [9, 8, 9], 10);
			mySprite.add("right", [0, 1, 0], 10);
			mySprite.add("throw left", [7, 6, 5], 12);
			mySprite.add("throw right", [2, 3, 4], 12);
			graphic = mySprite;
			layer = 5;
			type = "basic enemy";
			setHitbox(18, 21);
		}
		
		private function nextAction():void {
			var check:int = mySprite.frame;
			if (check == 2 || check == 5 || check == 7  || check == 4) {
				timer = 68;
				FP.world.add(new EnemyFireball(x + width / 2, y + height / 4, 5, Math.atan2( -70, player.x - x)));
				shooting = false;
			}
		}
		
		override public function update():void {
			if (player == null) {
				player = FP.world.getInstance("eddy");
			}
			
			if (!alive) {
				mySprite.frame = 8;
				setYSpeed(getYSpeed() + GRAVITY);
				moveBy(getXSpeed(), getYSpeed());
				if (drops) {
					drops = false;
					FP.world.add(new PowerUp(x, y, 12));
				}
				if (!onCamera) {
					destroy();
				}
				return;
			}
			
			if (Math.abs(x - player.x) > 240 || Math.abs(y - player.y) > 180) {
				return;
			}
			else if (Math.abs(x - player.x) < 115) {
				stroll = false;
			}
			else {
				stroll = true;
			}
			
			if (onGround) {
				if (stroll && !shooting) {
					if (faceRight) {
						mySprite.play("right");
						setXSpeed(0.5);
					}
					else {
						mySprite.play("left");
						setXSpeed(-0.5);
					}
					if (!collideTypes(["wall", "platform"], x + 17 * getXSpeed(), y + 1) || collideTypes("wall", x + getXSpeed(), y)) {
						
						if (faceRight) {
							faceRight = false;
						}
						else {
							faceRight = true;
						}
					}
				}
				else {
					timer--;
					if (timer <= 0) {
						shooting = true;
						setSpeed(0);
						if (player.x < x) {
							mySprite.play("throw left");
						}
						else {
							mySprite.play("throw right");
						}
					}
					else {
						if (player.x < x) {
							faceRight = true;
							mySprite.play("left");
							if (x - player.x < 70) {
								setXSpeed(1);
							}
							else {
								setXSpeed(0);
							}
						}
						else {
							faceRight = false;
							mySprite.play("right");
							if (player.x - x < 70) {
								setXSpeed( -1);
							}
							else {
								setXSpeed(0);
							}
						}
					}
					if (!collideTypes(["wall", "platform"], x + 17 * getXSpeed(), y + 1) || collideTypes("wall", x + getXSpeed(), y)) {
						
						setXSpeed(0);
					}
				}
			}
			else {
				
			}
			
			objectMove();
			
		}
		
		
	}
	

}