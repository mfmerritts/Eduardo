package entities.environment 
{
	import entities.Collidable;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class Hazard extends Entity implements Collidable {
		
		public function Hazard(x:Number=0, y:Number=0) {
			super(x, y);
			
			
			
		}
		
		public function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void {
			
		}
		
	}

}