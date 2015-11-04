package entities.npcs 
{
	/**
	 * ...
	 * @author Chance
	 */
	public class Bat extends BaseNPC {
		
		private var pattern:String;
		private var side:int = 1;
		
		public function Bat(x:Number=0, y:Number=0, pattern:String="Circle") {
			this.x = x;
			this.y = y;
			setSpeed(2);
		}
		
		override public function update():void {
			
			if (pattern == "Circle") {
				setDirection(getDirection()+Math.PI/90);
			}
			
			if (pattern == "Eight") {
				setDirection(getDirection() + Math.PI / 90);
				if (getDirection() >= 0 && getDirection() <= Math.PI / 90) {
					side = -side;
				}
			}
			
			objectMove();
		}
		
	}

}