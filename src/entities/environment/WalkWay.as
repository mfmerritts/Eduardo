package entities.environment 
{
	import net.flashpunk.FP;
	import ui.LoaderWorld;
	/**
	 * ...
	 * @author Chance
	 */
	public class WalkWay extends DoorWay {
		
		/**
		 * WalkWay functions like the doorway, but on collision rather then in response to an input.
		 * @param	stage
		 * @param	x
		 * @param	y
		 * @param	targetX
		 * @param	targetY
		 * @param	width
		 * @param	height
		 */
		public function WalkWay(stage:int, x:Number=0, y:Number=0, targetX:int=0, targetY:int=0, width:int=24, height:int=24) {
			super(stage, x, y, targetX, targetY);
			setHitbox(width, height);
		}
		
		override public function update():void {
			if (collide("player", x, y)) {
				
				FP.world = new LoaderWorld(targetLevel, targetX, targetY);
			}
		}
		
	}

}