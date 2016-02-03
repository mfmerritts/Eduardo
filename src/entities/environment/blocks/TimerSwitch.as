package entities.environment.blocks 
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class TimerSwitch extends BubbleSwitch {
		
		private static var turnedOn:Vector.<Boolean>;
		private var index:int;
		
		public function TimerSwitch(x:Number=0, y:Number=0, color:String="red") {
			type = "switch";
			this.x = x;
			this.y = y;
			name = color;
			
			if (turnedOn == null) {
				turnedOn = new Vector.<Boolean>;
				turnedOn.push(false, false, false, false);
			}
			
			if (color == "red") {
				image = new Spritemap(Assets.TIMER_SWITCH_RED, 24, 16, timerEnd);
				index = 0;
			}
			else if (color == "blue") {
				image = new Spritemap(Assets.TIMER_SWITCH_BLUE, 24, 16, timerEnd);
				index = 1;
			}
			else if (color == "green") {
				image = new Spritemap(Assets.TIMER_SWITCH_GREEN, 24, 16, timerEnd);
				index = 2;
			}
			else {
				image = new Spritemap(Assets.TIMER_SWITCH_YELLOW, 24, 16, timerEnd);
				index = 3;
			}
			TimerSwitch.turnedOn[index] = false;
			
			image.add("time", [0, 0, 1, 2, 3, 4, 5, 6, 7, 8], 2, false);
			
			image.frame = 8;
			this.graphic = image;
			setHitbox(24, 16);
			
			layer = 6;
		}
		
		override public function getSwitched():Boolean {
			return TimerSwitch.turnedOn[index];
		}
		
		override public function update():void {
			super.update();
			if (collide("player", x, y)) {
				image.play("time", true);
			}
			if (image.frame != 8) {
				TimerSwitch.turnedOn[index] = true;
			}
		}
		
		private function timerEnd():void {
			image.frame = 8;
			TimerSwitch.turnedOn[index] = false;
		}
		
	}

}