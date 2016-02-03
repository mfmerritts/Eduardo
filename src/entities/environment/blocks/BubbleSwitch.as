package entities.environment.blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class BubbleSwitch extends Entity {
		
		private var pressed:Boolean = false;
		protected var image:Spritemap;
		
		public function BubbleSwitch(x:Number=0, y:Number=0, color:String="red") {
			type = "switch";
			this.x = x;
			this.y = y;
			name = color;
			
			if (color == "red") {
				image = new Spritemap(Assets.BUBBLE_SWITCH_RED, 16, 8);
			}
			else if (color == "blue") {
				image = new Spritemap(Assets.BUBBLE_SWITCH_BLUE, 16, 8);
			}
			else if (color == "green") {
				image = new Spritemap(Assets.BUBBLE_SWITCH_GREEN, 16, 8);
			}
			else {
				image = new Spritemap(Assets.BUBBLE_SWITCH_YELLOW, 16, 8);
			}
			
			image.frame = 0;
			this.graphic = image;
			setHitbox(16, 8);
			
			layer = 6;
		}
		
		public function getSwitched():Boolean {
			return pressed;
		}
		
		override public function update():void {
			if (collide("player", x, y)) {
				pressed = true;
				image.frame = 1;
			}
		}
		
	}
	
}