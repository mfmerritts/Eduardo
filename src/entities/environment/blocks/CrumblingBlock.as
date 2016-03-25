package entities.environment.blocks 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Chance
	 */
	public class CrumblingBlock extends Platform {
		
		private var mySprite:Spritemap;
		
		public function CrumblingBlock(x:Number=0, y:Number=0, type:String = "sandstone") {
			super(x, y);
			mySprite = new Spritemap(Assets.SANDSTONE_BLOCK, 24, 24, destroy);
			mySprite.add("crumble", [4, 3, 2, 1, 0, 0, 0], 5);
			graphic = mySprite;
			mySprite.frame = 4;
			type = "wall";
			setHitbox(24, 24);
		}
		
		override public function update():void {
			super.update();
			type = "wall";
			if (collide("player", x, y - 1) && type == "wall") {
				mySprite.play("crumble");
			}
			if (mySprite.frame == 0) {
				type = "none";
			}
		}
		
		private function destroy():void {
			FP.world.remove(this);
		}
		
	}

}