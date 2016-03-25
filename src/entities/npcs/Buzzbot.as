package entities.npcs 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import entities.environment.PowerUp;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class Buzzbot extends BaseNPC {
		
		private var behavior:String;
		private var preferredSpeed:Number;
		private var drops:int;
		private var side:int = -1;
		private var size:int = 30;
		private var movementTimer:int;
		private var shootTimer:int;
		private var player:Entity;
		
		public function Buzzbot(x:Number = 0, y:Number = 0, behavior:String = "Circle", speed:Number = 1, size:Number = 30, drops:int = 0) {
			super(x, y);
			this.behavior = behavior;
			this.preferredSpeed = Math.abs(speed);
			this.drops = drops;
			if (size >= 20 && size <= 120) {
				this.size = size;
			}
			if (behavior == "Chase") {
				mySprite = new Spritemap(Assets.BUZZBOT_CHASER, 30, 18);
			}
			else if (behavior == "Shoot") {
				mySprite = new Spritemap(Assets.BUZZBOT_SHOOTER, 30, 18);
			}
			else {
				mySprite = new Spritemap(Assets.BUZZBOT, 30, 18);
				shootTimer = 60;
				movementTimer = size;
				setYSpeed(-preferredSpeed);
			}
			GRAVITY = 0;
			drag = 0;
			friction = 0;
			mySprite.add("left", [0, 1], 15);
			mySprite.add("right", [2, 3], 15);
			type = "basic enemy";
			setHitbox(26, 18, -2, 0);
			graphic = mySprite;
		}
		
		override public function update():void {
			if (!alive) {
				GRAVITY = 0.25;
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
			
			if (player == null) {
				player = FP.world.getInstance("eddy");
			}
			
			if (Math.abs(x - player.x) > 260 || Math.abs(y - player.y) > 190) {
				return;
			}
			if (behavior != "Chase") {
				if (getXSpeed() > 0) {
					mySprite.play("right");
				}
				else {
					mySprite.play("left");
				}
			}
			
			if (preferredSpeed != getSpeed()) {
					setSpeed(preferredSpeed);
				}
			if (behavior == "Circle") {
				setDirection(getDirection() + Math.PI / size);
				objectMove();
				
			}
			else if (behavior == "Eight") {
				setDirection(getDirection() + side * Math.PI / size);
				if (getDirection() >= 0 && getDirection() <= Math.PI / (size)) {
					side = -side;
					objectMove();
				}
			}
			else if (behavior == "Left") {
				setDirection(Math.PI);
				objectMove();
			}
			else if (behavior == "Shoot") {
				if (player.x > x) {
					mySprite.play("right");
				}
				else {
					mySprite.play("left");
				}
				movementTimer--;
				shootTimer--;
				if (movementTimer <= 0) {
					movementTimer = size;
					if (getYSpeed() < 0) {
						setYSpeed(preferredSpeed);
					}
					else {
						setYSpeed( -preferredSpeed);
					}
				}
				if (shootTimer <= 0) {
					if (player.x > x) {
						FP.world.add(new Bullet(x +15, y + 9, 2.5, 0));
					}
					else {
						FP.world.add(new Bullet(x +15, y + 9, 2.5, Math.PI));
					}
					shootTimer = 90;
				}
				moveBy(0, getYSpeed(), "wall");
			}
			else if (behavior == "Chase") {
				if (player.x > x) {
					mySprite.play("right");
				}
				else {
					mySprite.play("left");
				}
				moveTowards(player.x + 12, player.y + 12, preferredSpeed, "wall");
			}
			
		}
		
	}

}