package entities.environment 
{
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * A collectible item,
	 * ...
	 * @author  Chance Gallegos
	 */
	public class Coin extends Item 
	{
		
		public var mySprite:Spritemap;
		private var value:int;
		private var index:int;
		
		
		public function Coin(x:Number=0, y:Number=0, color:String = "copper", _index:int = -1) {
			this.x = x;
			this.y = y;
			if (color == "copper") {
				value = 1;
				mySprite = new Spritemap(Assets.COPPER_COIN, 10, 10);
				setHitbox(10, 10);
				mySprite.add("Flash", [0, 1, 2, 3, 2, 1, 0], 10);
			}
			else if (color == "silver") {
				value = 5;
				mySprite = new Spritemap(Assets.SILVER_COIN, 14, 14);
				setHitbox(14, 14);
				mySprite.add("Flash", [0, 1, 2, 3, 2, 1, 0], 10);
			}
			else if (color == "gold") {
				value = 25;
				mySprite = new Spritemap(Assets.GOLD_COIN, 24, 24);
				setHitbox(24, 24);
				mySprite.add("Flash", [0, 1, 2, 1, 0], 10);
			}
			index = _index;
			graphic = mySprite;
			mySprite.play("Flash");
		}
		
		override public function update():void {
			if (collide("player", x, y)) {
				collect();
			}
		}
		
		override public function collect():void {
			PlayerData.money += value;
			if (index >= 0 && index < 5) {
				PlayerData.coinCollected[index] = true;
			}
			FP.world.remove(this);
		}
		
	}

}