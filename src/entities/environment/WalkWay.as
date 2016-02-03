package entities.environment 
{
	import net.flashpunk.FP;
	import ui.LoaderWorld;
	/**
	 * ...
	 * @author Chance
	 */
	public class WalkWay extends DoorWay {
		
		public function WalkWay(stage:int, x:Number=0, y:Number=0, targetX:int=0, targetY:int=0) {
			super(stage, x, y, targetX, targetY);
			
		}
		
		override public function update():void {
			if (collide("player", x, y)) {
				
				FP.world = new LoaderWorld(targetLevel, targetX, targetY);
			}
		}
		
	}

}