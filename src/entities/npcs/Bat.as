package entities.npcs 
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class Bat extends BaseNPC {
		
		private var pattern:String;
		private var side:int = 1;
		private var batSprite:Spritemap;
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
			this.preferredSpeed = preferredSpeed;
			this.pattern = pattern;
			setSpeed(preferredSpeed);
			setHitbox(24, 15);
			batSprite = new Spritemap(Assets.BAT, 24, 15);
			batSprite.add("fly", [0, 1, 2, 1], 15, true);
			batSprite.add("stand", [3]);
			graphic = batSprite;
			if (pattern != "Wait") {
				batSprite.play("fly");
			}
			type = "enemy";
			layer = 4;
		}
		
		override public function update():void {
			
			if (pattern == "Circle") {
				setDirection(getDirection() + Math.PI / size);
				if (preferredSpeed != getSpeed()) {
					setSpeed(preferredSpeed);
				}
			}
			
			if (pattern == "Eight") {
				setDirection(getDirection() + Math.PI / size);
				if (getDirection() >= 0 && getDirection() <= Math.PI / 90) {
					side = -side;
				}
			}
			
			objectMove();
		}
		
	}

}