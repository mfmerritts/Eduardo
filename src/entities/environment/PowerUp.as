package entities.environment 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Chance
	 */
	public class PowerUp extends Item {
		
		private var power:int;
		
		public function PowerUp(x:Number = 0, y:Number = 0, power:int = 0) {
			super(x, y);
			this.power = power;
			setHitbox(20, 20, -2, -2);
			layer = 6;
			if (power == 12) {
				graphic = new Image(Assets.MATCHBOX);
			}
			else if (power == 2) {
				graphic = new Image(Assets.GLIDE_WINGS);
			}
			else if (power == 3) {
				graphic = new Image(Assets.DOUBLE_JUMP);
			}
			else if (power == 7) {
				graphic = new Image(Assets.POWDER_CAN);
			}
			else if (power == 8) {
				graphic = new Image(Assets.HAMMER);
			}
		}
		
		override public function collect():void {
			PlayerData.power = power;
			PlayerData.powerHits = 2;
			FP.world.remove(this);
		}
		
	}

}