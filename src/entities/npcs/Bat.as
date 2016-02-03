package entities.npcs 
{
	import net.flashpunk.graphics.Spritemap;
	import ui.EddyWorld;
	/**
	 * ...
	 * @author Chance
	 */
	public class Bat extends BaseNPC {
		
		private var pattern:String;
		private var side:int = 1;
		private var preferredSpeed:Number;
		private var size:Number = 60;
		
		/**
		 * Constructor
		 * @param	x				- initial x coordinate
		 * @param	y				- initial y coordinate
		 * @param	pattern			- the patter that it should move in
		 * @param	preferredSpeed	- it's preffered speed to move
		 * @param	size			- the size of it's movement patter (also affected by speed)
		 */
		public function Bat(x:Number=0, y:Number=0, pattern:String="Circle", preferredSpeed:Number = 2, size:Number = 0) {
			this.x = x;
			this.y = y;
			if (size >= 30 && size <= 90) {
				this.size = size;
			}
			GRAVITY = 0;
			drag = 0;
			friction = 0;
			if (preferredSpeed >= 0) {
				this.preferredSpeed = preferredSpeed;
			}
			this.pattern = pattern;
			setSpeed(preferredSpeed);
			setHitbox(24, 15);
			mySprite = new Spritemap(Assets.BAT, 24, 15);
			mySprite.add("fly", [0, 1, 2, 1], 15, true);
			mySprite.add("stand", [3]);
			graphic = mySprite;
			if (pattern != "Wait") {
				mySprite.play("fly");
			}
			type = "basic enemy";
			layer = 4;
		}
		
		override public function update():void {
			if (!alive) {
				GRAVITY = 0.25;
				setYSpeed(getYSpeed() + GRAVITY);
				moveBy(getXSpeed(), getYSpeed());
				if (!onCamera) {
					destroy();
				}
				return;
			}
			if (preferredSpeed != getSpeed()) {
					setSpeed(preferredSpeed);
				}
			if (pattern == "Circle") {
				setDirection(getDirection() + Math.PI / size);
				
			}
			else if (pattern == "Eight") {
				setDirection(getDirection() + side * Math.PI / size);
				if (getDirection() >= 0 && getDirection() <= Math.PI / (size)) {
					side = -side;
				}
			}
			
			objectMove();
		}
		
	}

}