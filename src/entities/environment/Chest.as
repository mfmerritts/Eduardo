package entities.environment 
{
	import entities.environment.blocks.Platform;
	import entities.playercontrolled.PlayerEntity;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Chance
	 */
	public class Chest extends Platform {
		
		private var contents:int;
		private var opened:int = 0;
		private var mySprite:Spritemap;
		
		public function Chest(x:Number=0, y:Number=0, contents:int = 0) {
			this.x = x;
			this.y = y;
			width = 22;
			setHitbox(width, 8, -1, -1);
			mySprite = new Spritemap(Assets.RED_CHEST, 24, 24);
			mySprite.frame = opened;
			graphic = mySprite;
			this.contents = contents;
			layer = 7;
			
		}
		
		override public function update():void {
			super.update();
			mySprite.frame = opened;
			if (opened == 1) {
				return;
			}
			
			
			if (collide("player", x, y)) {
				var player:Entity = collide("player", x, y);
				var dir:int;
				if (PlayerEntity(player).faceRight) {
					dir = 1;
					
				}
				else {
					dir = -1;
				}
				 if (Input.pressed(Key.X)) {
					opened = 1;
					if (contents == 0) {
						
					}
					else if (contents <= 12) {
						FP.world.add(new PowerUp(player.x + dir * 30, y, contents));
					}
				}
			}
		}
		
	}

}