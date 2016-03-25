package entities.environment 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class Spikes extends Hazard {
		
		private var mySprite:Spritemap;
		
		public function Spikes(x:Number=0, y:Number=0, side:String="bottom") {
			super(x, y);
			mySprite = new Spritemap(Assets.STONE_SPIKES, 24, 16);
			if (side == "top") {
				mySprite.frame = 0;
			}
			else {
				mySprite.frame = 1;
			}
			setHitbox(24, 16, -1, 0);
			type = "hazard";
			name = "spike hazard";
			graphic = mySprite;
			
		}
		
		override public function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void {
			if (int(v2) == 2) {
				FP.world.remove(this);
			}
		}
		
	}

}