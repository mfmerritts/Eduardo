package entities.environment 
{
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import ui.WorldMap;
	/**
	 * ...
	 * @author Chance
	 */
	public class Crystal extends Item {
		
		private var mySprite:Spritemap;
		
		public function Crystal(x:Number=0, y:Number=0) {
			super(x, y);
			mySprite = new Spritemap(Assets.VIBRANT_CRYSTAL, 24, 24);
			mySprite.add("Glow", [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1], 20);
			mySprite.play("Glow");
			graphic = mySprite;
			setHitbox(20, 22, -2, -1)
		}
		
		override public function update():void {
			
		}
		
		override public function collect():void {
			PlayerData.mysticCave = true;
			FP.world = new WorldMap();
		}
	}

}