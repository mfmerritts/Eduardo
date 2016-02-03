package entities.environment.blocks 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class CrumblingBlock extends Platform {
		
		private var mySprite:Spritemap;
		
		public function CrumblingBlock(x:Number=0, y:Number=0, type:Class = Assets.SANDSTONE_BLOCK) {
			super(x, y);
			mySprite = new Spritemap(type, 24, 24, destroy);
			mySprite.add("crumble", [4, 3, 2, 1, 0], 15);
		}
		
		override public function update():void {
			super.update();
			if (collide("player", x, y - 1) && type = "wall") {
				mySprite.play("crumble");
			}
		}
		
		private function destroy():void {
			FP.world.remove(this);
		}
		
	}

}