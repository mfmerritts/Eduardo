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
		 * @param	_level - the current level, this is necessary becuase this calls functions my game world that do not exist in the base flashpunk world.
		 * @param	_x - the x position to place the doorway.
		 * @param	_y - the y position to place the doorway.
		 * @param	_targetX - the x position where the player character will start in the level this door leads to.
		 * @param	_targetY - the y position where the player character will start in the level this door leads to.
		 * @param	_index - used to determine the level that this door leads to.
		 */
		public function DoorWay(_level:ui.EddyWorld, _x:Number=0, _y:Number=0, _targetX:Number=0, _targetY:Number=0, _index:int=0) 
		{
			x = _x;
			y = _y;
			targetX = _targetX;
			targetY = _targetY;
			this.level = _level;
			setHitbox(24, 24);
			if (_index == 1)
			{
				targetLevel = Assets.PARKLEVEL;
			}
			else
			{
				targetLevel = Assets.TESTLEVEL;
			}
		}
		
		override public function update():void 
		{
			 if (collide("player", x, y))
			 {
				 if (Input.pressed(Key.UP))
				 { 
					 
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