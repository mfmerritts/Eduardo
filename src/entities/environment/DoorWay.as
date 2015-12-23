package entities.environment 
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import ui.EddyWorld;
	
	/**
	 * ...
	 * @author  Chance Gallegos
	 */
	public class DoorWay extends Entity 
	{
		private var targetX:Number;
		private var targetY:Number;
		private var targetLevel:Class;
		private var level:ui.EddyWorld;
		
		/**
		 * 
		 * @param	level	- The level this door is in.
		 * @param	stage	- The level this door leads to.
		 * @param	x		- x coordinate
		 * @param	y		- y coordinate
		 * @param	targetX	- x where this leads
		 * @param	targetY - y where this leads
		 */
		public function DoorWay(level:ui.EddyWorld, stage:Class, x:Number=0, y:Number=0, targetX:Number=0, targetY:Number=0) {
			this.x = x;
			this.y = y;
			targetX = targetX;
			targetY = targetY;
			this.level = level;
			setHitbox(24, 24);
			targetLevel = stage;
		}
		
		override public function update():void {
			 if (collide("player", x, y)) {
				 if (Input.pressed(Key.UP)) { 
					 
					 level.gotoLevel(targetLevel, targetX, targetY);
				 }
			 }
		}
	}
	
	/* note that the DoorWay does not have a graphic, I want different types of graphics to represent doors
	 * they'll all look like doors of course, but there is enough variance that I was planning on doing it this way
	 * if you come up with a better solution, feel free to implement it.
	*/

}