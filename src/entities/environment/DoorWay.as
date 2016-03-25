package entities.environment 
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import ui.EddyWorld;
	import ui.LoaderWorld;
	
	/**
	 * ...
	 * @author  Chance Gallegos
	 */
	public class DoorWay extends Entity 
	{
		protected var targetX:Number;
		protected var targetY:Number;
		protected var targetLevel:Class;
		protected var stage:int;
		
		/**
		 * 
		 * @param	level	- The level this door is in.
		 * @param	stage	- The level this door leads to.
		 * @param	x		- x coordinate
		 * @param	y		- y coordinate
		 * @param	targetX	- x where this leads
		 * @param	targetY - y where this leads
		 */
		public function DoorWay(_stage:int, x:Number=0, y:Number=0, targetX:int =0, targetY:int = 0) {
			this.x = x;
			this.y = y;
			this.targetX = targetX;
			this.targetY = targetY;
			stage = _stage;
			if (stage == 0) {
				targetLevel = Assets.CAVE;
			}
			else if (stage == 1) {
				targetLevel = Assets.CAVE_2;
			}
			else if (stage == 2) {
				targetLevel = Assets.PRETTY_PLAINS_1;
			}
			else if (stage == 3) {
				targetLevel = Assets.PRETTY_PLAINS_2;
			}
			else if (stage == 4) {
				targetLevel = Assets.CITY_BRIDGE;
			}
			else if (stage == 5) {
				targetLevel = Assets.BRIDGE_WAREHOUSE;
			}
			else if (stage == 6) {
				targetLevel = Assets.BUTTER_BEACH;
			}
			else if (stage == 7) {
				targetLevel = Assets.BUTTER_BEACH_2;
			}
			else if (stage == 8) {
				targetLevel = Assets.CITY_OUTSKIRTS;
			}
			else if (stage == 9) {
				targetLevel = Assets.OUTSKIRTS_WAREHOUSE;
			}
			else if (stage == 10) {
				targetLevel = Assets.SUGAR_MEADOWS;
			}
			else if (stage == 11) {
				targetLevel = Assets.ABOVE_STONEHENGE;
			}
			else if (stage == 12) {
				targetLevel = Assets.CURSED_MOUNTAIN;
			}
			else if (stage == 13) {
				targetLevel = Assets.CURSED_CAVE;
			}
			setHitbox(24, 24);
			
		}
		
		override public function update():void {
			if (collide("player", x, y)) {
				if (Input.pressed(Key.X)) { 
					
					if (stage == 12) {
						FP.screen.color = 0x87CEFA;
					}
					if (stage == 13) {
						FP.screen.color = 0x060615;
					}
					FP.world = new LoaderWorld(targetLevel, targetX, targetY);
				}
			}
		}
	}
	
	/* note that the DoorWay does not have a graphic, I want different types of graphics to represent doors
	 * they'll all look like doors of course, but there is enough variance that I was planning on doing it this way
	 * if you come up with a better solution, feel free to implement it.
	*/

}