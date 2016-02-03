package entities.npcs 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import entities.playercontrolled.PlayerEntity;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class LasherVine extends BaseNPC {
		
		private var player:Entity;
		
		public function LasherVine(x:Number=0, y:Number=0, direction:String="left") {
			super(x, y);
			mySprite = new Spritemap(Assets.LASHER_VINE, 48, 48, destroy);
			mySprite.add("left", [5, 6, 7, 8, 9], 10);
			mySprite.add("right", [0, 1, 2, 3, 4], 10);
			graphic = mySprite;
			mySprite.play(direction);
			player = FP.world.getInstance("eddy");
			layer = 5;
		}
		
		override public function update():void {
			var hit:Boolean = false;
			if (mySprite.frame == 0) {
				if (player.collideRect(player.x, player.y, x, y + 1, 3, 46)) {
					PlayerEntity(player).xSpeed = 3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else if (mySprite.frame == 1) {
				if (player.collideRect(player.x, player.y, x + 10, y + 2, 3, 24) || player.collideRect(player.x, player.y, x + 3, y + 24, 6, 24)) {
					PlayerEntity(player).xSpeed = 3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else if (mySprite.frame == 2) {
				if (player.collideRect(player.x, player.y, x + 26, y + 11, 5, 15) || player.collideRect(player.x, player.y, x + 5, y + 26, 21, 22)) {
					PlayerEntity(player).xSpeed = 3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else if (mySprite.frame == 3) {
				if (player.collideRect(player.x, player.y, x + 8, y + 36, 40, 3)) {
					PlayerEntity(player).xSpeed = 3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else if (mySprite.frame == 5) {
				if (player.collideRect(player.x, player.y, x + 45, y + 1, 3, 46)) {
					PlayerEntity(player).xSpeed = -3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else if (mySprite.frame == 6) {
				if (player.collideRect(player.x, player.y, x + 35, y + 2, 3, 24) || player.collideRect(player.x, player.y, x + 39, y + 24, 6, 24)) {
					PlayerEntity(player).xSpeed = -3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else if (mySprite.frame == 7) {
				if (player.collideRect(player.x, player.y, x + 17, y + 11, 5, 15) || player.collideRect(player.x, player.y, x + 22, y + 26, 21, 22)) {
					PlayerEntity(player).xSpeed = -3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else if (mySprite.frame == 8) {
				if (player.collideRect(player.x, player.y, x, y + 36, 40, 3)) {
					PlayerEntity(player).xSpeed = -3;
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			else {
				if (player.collideRect(player.x, player.y, x, y + 45, 48, 3)) {
					if (player.x > x) {
						PlayerEntity(player).xSpeed = 3;
					}
					else {
						PlayerEntity(player).xSpeed = -3;
					}
					PlayerEntity(player).ySpeed = -3;
					hit = true;
				}
			}
			if (hit) {
				PlayerData.powerHits--;
			}
		}
		
	}

}