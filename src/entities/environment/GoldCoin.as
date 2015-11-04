package entities.environment 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * A collectible item,
	 * ...
	 * @author  Chance Gallegos
	 */
	public class GoldCoin extends Item 
	{
		
		public var sprite:Spritemap = new Spritemap(Assets.GOLDCOIN, 20, 20);
		
		public function GoldCoin(x:Number=0, y:Number=0) 
		{
			sprite.add("flash", [0, 1, 2, 3, 4, 5, 6], 15, true);
			setHitbox(20, 20);
			sprite.play("flash");
		}
		
		override public function update():void
		{
			if (collide("player", x, y))
			{
				destroy();
			}
		}
		
	}

}