package entities.npcs 
{
	import entities.npcs.BaseNPC;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * 
	 * ...
	 * @author  Chance Gallegos
	 */
	public class PlantProjectile extends BaseNPC
	{
		
		private var destroyTimer:int = 30;
		
		public function PlantProjectile(x:Number, y:Number, speed:Number, direction:Number) {
			this.x = x;
			this.y = y;
			mySprite = new Spritemap(Assets.PROJECTILES, 8, 8);
			mySprite.frame = 0;
			setSpeed(speed);
			setDirection(direction);
			graphic = mySprite;
			type = "hazard"; // type 'hazard' causes harm to the player.
			GRAVITY = 0;
			drag = 0;
			friction = 0;
			layer = 6;
			setHitbox(8, 8);
		}
		
		override public function update():void 
		{
			moveBy(getXSpeed(), getYSpeed());
			if (!onCamera) {
				destroyTimer -= 1;
				if (destroyTimer <= 0){
					destroy();
				}
			}
			
			if (collide("wall", x, y)){
				destroy();
			}
		}
		
	}
}