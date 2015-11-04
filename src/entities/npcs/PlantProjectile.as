package entities.npcs 
{
	import entities.npcs.BaseNPC;
	/**
	 * 
	 * ...
	 * @author  Chance Gallegos
	 */
	public class PlantProjectile extends BaseNPC
	{
		
		private var destroyTimer:int = 30;
		
		public function PlantProjectile(x:Number, y:Number, speed:Number, direction:Number) 
		{
			this.x = x;
			this.y = y;
			setSpeed(speed);
			setDirection(direction);
			type = "hazard"; // type 'hazard' causes harm to the player.
			GRAVITY = 0;
			drag = 0;
			friction = 0;
		}
		
		override public function update():void 
		{
			objectMove();
			if (!onCamera) 
			{
				destroyTimer -= 1;
				if (destroyTimer <= 0)
				{
					destroy();
				}
			}
			}
			if (collide("wall", x, y))
			{
				destroy();
			}
		}
		
	}

}