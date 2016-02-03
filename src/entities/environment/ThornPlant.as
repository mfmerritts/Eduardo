package entities.environment 
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Chance
	 */
	public class ThornPlant extends Hazard {
		
		public function ThornPlant(x:Number=0, y:Number=0) {
			this.x = x;
			this.y = y;
			setHitbox(27, 18);
			graphic = new Image(Assets.THORN_PLANT);
		}
		
		override public function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void {
			if (int(v2) == 1 || int(v2) == 2) {
				
			}
		}
	}

}