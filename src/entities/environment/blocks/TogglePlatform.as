package entities.environment.blocks 
{
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class TogglePlatform extends ToggleBlock {
		
		public function TogglePlatform(x:Number=0, y:Number=0, color:String="red") {
			super(x, y, color);
			
			if (color == "red") {
				image = new Spritemap(Assets.TOGGLE_PLATFORM_RED, 24, 8);
			}
			else if (color == "blue") {
				image = new Spritemap(Assets.TOGGLE_PLATFORM_BLUE, 24, 8);
			}
			else if (color == "green") {
				image = new Spritemap(Assets.TOGGLE_PLATFORM_GREEN, 24, 8);
			}
			else {
				image = new Spritemap(Assets.TOGGLE_PLATFORM_YELLOW, 24, 8);
			}
			
			image.frame = 1;
			this.graphic = image;
			setHitbox(24, 8);
		}
		
		override public function update():void {
			super.update();
			
			if (collide("player", x + 1, y + 1) || collide("player", x - 1, y + 1)) {
				type = "platform";
			}
			else if (!collide("player", x, y)) {
				type = "wall";
			}
		}
		
	}

}