package entities.environment.blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class ToggleBlock extends Entity {
		
		protected var toggleSwitch:BubbleSwitch;
		protected var image:Spritemap;
		protected var color:String;
		
		public function ToggleBlock(x:Number=0, y:Number=0, color:String="red") {
			super(x, y);
			this.color = color;
			type = "wall";
			collidable = false;
			layer = 8;
			
			if (color == "red") {
				image = new Spritemap(Assets.TOGGLE_BLOCK_RED, 24, 24);
			}
			else if (color == "blue") {
				image = new Spritemap(Assets.TOGGLE_BLOCK_BLUE, 24, 24);
			}
			else if (color == "green") {
				image = new Spritemap(Assets.TOGGLE_BLOCK_GREEN, 24, 24);
			}
			else {
				image = new Spritemap(Assets.TOGGLE_BLOCK_YELLOW, 24, 24);
			}
			
			image.frame = 1;
			this.graphic = image;
			setHitbox(24, 24);
			
		}
		
		override public function update():void {
			if (toggleSwitch == null) {
				toggleSwitch = BubbleSwitch(FP.world.getInstance(color));
				return;
			}
			
			if (toggleSwitch.getSwitched()) {
				collidable = true;
				image.frame = 0;
			}
			else {
				collidable = false;
				image.frame = 1;
			}
		}
		
	}

}