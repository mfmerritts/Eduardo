package entities.environment 
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
		public function Platform(x:Number, y:Number, width:int) {
			this.x = x;
			this.y = y;
			setHitbox(width, 8);
			type = "wall";
			
		} // end constructor		
		
		override public function update():void {
			// Checks collision from below Y so it changes type when jumping up through. || is an or check,
			// to see if player is + 1 or - 1 from X axis, so you can jump diagonally up through platform from either left or right.
			if (collide("player", x + 1, y + 1) || collide("player", x - 1, y + 1)) {
				type = "platform"; // Just make every other NPC/Enemy collide with Platform. They won't fall through when type changes.
			}
			else if (!collide("player", x, y)) {
				type = "wall";
			}
			
			super.update();
			
		} // end update function
	}

}