package entities.npcs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	import ui.EddyWorld;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class Lasher extends BaseNPC {
		
		private var attack:Boolean = false;
		private var recharge:Boolean = false;
		private var burn:Boolean = false;
		private var timer:int = 30;
		private var emitter:Emitter;
		
		public function Lasher(x:Number = 0, y:Number = 0) {
			this.x = x;
			this.y = y;
			mySprite = new Spritemap(Assets.LASHER_PLANT, 32, 48);
			mySprite.add("sway", [0, 11, 0, 12], 5);
			mySprite.add("unfurl left", [1, 3, 4, 5, 6, 0], 8);
			mySprite.add("unfurl right", [2, 7, 8, 9, 10, 0], 8);
			mySprite.play("sway");
			setSpeed(0);
			setDirection(0);
			setHitbox(28, 48, -2, 0);
			layer = 5;
			type = "plant enemy";
			health = 2;
			emitter = new Emitter(Assets.FIRE, 16, 20);
			emitter.newType("burn", [0, 1, 2, 3, 4]);
			emitter.setAlpha("burn", 1, 0.5);
			emitter.setMotion("burn", 80, 5, 0.25, 20, -5, 0);
			emitter.relative = false;
			graphic = new Graphiclist(mySprite, emitter);
		}
		
		override public function update():void {
			if (!alive) {
				if (burn) {
					if (timer >= 8 && timer % 3 == 0) {
						emitter.emit("burn", x + Math.random() * width - 4, y + Math.random() * height - 4);
					}
					timer--;
					if (timer <= 0) {
						destroy();
					}
					
				}
				else {
					setYSpeed(getYSpeed() + GRAVITY);
					moveBy(getXSpeed(), getYSpeed());
					if (!onCamera) {
						destroy();
					}
				}
				return;
				
			}
			
			if (invFrames > 0) {
				invFrames--;
			}
			
			var player:Entity = world.getInstance("eddy");
			
			if (Math.abs(x - player.x) > 200 || Math.abs(y - player.y) > 150) {
				return;
			}
			
			
			if (!attack && !recharge) {
				attack = (player.x - x > -60 && player.x - x < 70);
				if (attack) {
					timer = 30;
					if (player.x > x) {
						mySprite.frame = 2;
						FP.world.add(new LasherVine(x + 28, y, "right"));
					}
					else {
						mySprite.frame = 1;
						FP.world.add(new LasherVine(x - 44, y));
					}
				}
			}
			else if (attack) {
				timer--;
				if (timer <= 0) {
					recharge = true;
					attack = false;
				}
			}
			else if (recharge) {
				if (mySprite.frame == 2) {
					mySprite.play("unfurl right");
				}
				else if (mySprite.frame == 1) {
					mySprite.play("unfurl left");
				}
				
				if (mySprite.frame == 0) {
					recharge = false;
					mySprite.play("sway");
				}
			}
		}
		
		override public function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void {
			if (invFrames <= 0) {
				health--;
				invFrames = 25;
			}
			if (health <= 0) {
				alive = false;
				collidable = false;
				timer = 40;
				type = "none";
				if (int(v2) == 1) {
					burn = true;
				}
			}
		}
		
	}

}