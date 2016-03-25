package entities.environment.blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * The idea is to have some platforms that the player can jump up to from below.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class Platform extends Entity {
		
		/**
		 * @param	x - x location, used by OEL
		 * @param	y - ^^
		 * @param	width - the width of the platform
		 */
		public function Platform(x:Number=0, y:Number=0, width:int=0) {
			this.x = x;
			this.y = y;
			setHitbox(width, 8);
			type = "platform";
			
		} // end constructor		
		
		override public function update():void {
			/*
			if (collide("player", x + 1, y + 1) || collide("player", x - 1, y + 1)) {
				type = "platform"; 
			}
			else if (!collide("player", x, y)) {
				type = "wall";
			}
			//*/
			
			super.update();
			
		} // end update function
	}

}