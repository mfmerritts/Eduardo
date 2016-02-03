package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class PowerUpDisplay extends Entity {
		
		private var mySprite:Spritemap;
		
		public function PowerUpDisplay(x:Number=0, y:Number=0) {
			super(x, y);
			mySprite = new Spritemap(Assets.POWERUP_ICONS, 24, 24);
			graphic = mySprite;
			layer = 0;
			name = "power ups hud";
		}
		
		override public function update():void {
			mySprite.frame = PlayerData.power;
			
		}
		
	}

}