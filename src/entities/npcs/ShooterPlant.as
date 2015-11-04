package entities.npcs 
{
	import entities.npcs.BaseNPC;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Entity;
	
	
	/**
	 * A test enemy that I had added when I realized i would need help.
	 * Right now all it does is look at the player.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class ShooterPlant extends BaseNPC 
	{
		
		private var sprite:Spritemap = new Spritemap(Assets.SHOOTER_PLANT, 40, 40);
		
		public function ShooterPlant(x:Number=0, y:Number=0) 
		{
			// One nice thing about flashpunk spritemaps is that animation frames can be used in any order and even repeated.
			sprite.add("idleTL", [0, 1, 0, 2], 5, true);
			sprite.add("attackTL", [0, 2, 3, 2], 10, true);
			sprite.add("idleBL", [4, 5, 4, 6], 5, true);
			sprite.add("attackBL", [4, 6, 7, 6], 10, true);
			sprite.add("idleTR", [8, 9, 8, 10], 5, true);
			sprite.add("attackTR", [8, 10, 11, 10], 10, true);
			sprite.add("idleBR", [12, 13, 12, 14], 5, true);
			sprite.add("attackBR", [12, 14, 15, 14], 10, true);
			this.x = x;
			this.y = y;
			setSpeed(0);
			setDirection(0);
			type = "plantenemy"; // I'm not sure yet, but I'm thinking about using different enemy types so that enemies interact differently with different attacks.
			graphic = sprite;
			playIdle();
		}
		
		// playIdle is the function causes the monster to look at the player.
		private function playIdle():void
		{
			if ((getDirection() >= 0) && (getDirection() < (Math.PI/2)))
			{
				sprite.play("idleBR");
			}
			if ((getDirection() >= (Math.PI/2)) && (getDirection() < (Math.PI)))
			{
				sprite.play("idleBL");
			}
			if ((getDirection() >= (Math.PI)) && (getDirection() < (Math.PI * 3/2)))
			{
				sprite.play("idleTL");
			}
			if ((getDirection() >= (Math.PI * 3/2)) && (getDirection() < (Math.PI * 2)))
			{
				sprite.play("idleTR");
			}
		}
		
		override public function update():void 
		{
			var player:Entity = world.getInstance("eddy");
			
			setDirection(Math.atan2(player.y - y, player.x - x));
			playIdle();
		}
		
	}

}