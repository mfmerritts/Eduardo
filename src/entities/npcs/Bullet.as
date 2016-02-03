package entities.npcs 
{
	/**
	 * ...
	 * @author Chance
	 */
	public class Bullet extends PlantProjectile 
	{
		
		public function Bullet(x:Number, y:Number, speed:Number, direction:Number) {
			super(x, y, speed, direction);
			
			if (getXSpeed() > 0) {
				mySprite.frame = 6;
			}
			else {
				mySprite.frame = 5;
			}
			
		}
		
	}

}