package entities.npcs 
{
	import entities.npcs.BaseNPC;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import ui.EddyWorld;
	
	
	/**
	 * A test enemy that I had added when I realized i would need help.
	 * Right now all it does is look at the player.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class ShooterPlant extends BaseNPC 
	{
		
		private var shooting:Boolean = false;
		private var burn:Boolean = false;
		private var timer:int = 90;
		private var emitter:Emitter;
		
		/**
		 * Shooter plant, similar to spitting piranha plants from Mario.
		 * @param	x
		 * @param	y
		 */
		public function ShooterPlant(x:Number=0, y:Number=0) {
			mySprite = new Spritemap(Assets.SHOOTER_PLANT, 40, 40);
			mySprite.add("idleTL", [0, 1, 0, 2], 5, true);
			mySprite.add("attackTL", [0, 3, 2], 10, false);
			mySprite.add("idleBL", [4, 5, 4, 6], 5, true);
			mySprite.add("attackBL", [4, 7, 6], 10, false);
			mySprite.add("idleTR", [8, 9, 8, 10], 5, true);
			mySprite.add("attackTR", [8,  11, 10], 10, false);
			mySprite.add("idleBR", [12, 13, 12, 14], 5, true);
			mySprite.add("attackBR", [12, 15, 14], 10, false);
			this.x = x;
			this.y = y;
			setSpeed(0);
			setDirection(0);
			setHitbox(40, 40);
			layer = 5;
			type = "plant enemy"; // I'm not sure yet, but I'm thinking about using different enemy types so that enemies interact differently with different attacks.
			graphic = mySprite;
			playIdle();
			health = 2;
			
			emitter = new Emitter(Assets.FIRE, 16, 20);
			emitter.newType("burn", [0, 1, 2, 3, 4]);
			emitter.relative = false;
			emitter.setAlpha("burn", 1, 0.5);
			emitter.setMotion("burn", 80, 5, 0.25, 20, -5, 0);
			graphic = new Graphiclist(mySprite, emitter);
		}
		
		// playIdle is the function causes the monster to look at the player.
		private function playIdle():void {
			if ((getDirection() >= 0) && (getDirection() < (Math.PI/2))) {
				mySprite.play("idleBR");
			}
			if ((getDirection() >= (Math.PI/2)) && (getDirection() < (Math.PI))) {
				mySprite.play("idleBL");
			}
			if ((getDirection() >= (Math.PI)) && (getDirection() < (Math.PI * 3/2))) {
				mySprite.play("idleTL");
			}
			if ((getDirection() >= (Math.PI * 3/2)) && (getDirection() < (Math.PI * 2))) {
				mySprite.play("idleTR");
			}
		}
		
		private function playShoot():void {
			if ((getDirection() >= 0) && (getDirection() < (Math.PI/2))) {
				mySprite.play("attackBR");
			}
			if ((getDirection() >= (Math.PI/2)) && (getDirection() < (Math.PI))) {
				mySprite.play("attackBL");
			}
			if ((getDirection() >= (Math.PI)) && (getDirection() < (Math.PI * 3/2))) {
				mySprite.play("attackTL");
			}
			if ((getDirection() >= (Math.PI * 3/2)) && (getDirection() < (Math.PI * 2))) {
				mySprite.play("attackTR");
			}
			if (mySprite.frame % 4 == 2) {
				shooting = false;
			}
			
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
			
			if (Math.abs(x - player.x) > 220 || Math.abs(y - player.y) > 170) {
				return;
			}
			
			setDirection(Math.atan2(player.y - y, player.x - x));
			
			if (timer >= 0) {
				timer--;
			}
			else {
				shooting = true;
				FP.world.add(new PlantProjectile(x + 20, y + 10, 2.5, getDirection()));
				timer = 120;
			}
			
			
			if (shooting) {
				playShoot();
			}
			else {
				playIdle();
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