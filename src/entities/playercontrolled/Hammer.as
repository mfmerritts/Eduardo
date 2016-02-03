package entities.playercontrolled 
{
	import entities.npcs.BaseNPC;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class Hammer extends BaseNPC {
		
		private var player:Entity;
		
		public function Hammer(x:Number = 0, y:Number = 0, player:Entity = null, swing:String = "ground right" ) {
			super(x, y);
			this.player = player;
			mySprite = new Spritemap(Assets.HAMMER_SWING, 20, 17, destroy);
			mySprite.add("ground right", [0, 1, 2, 2], 15);
			mySprite.add("ground left", [5, 4, 3, 3], 15);
			mySprite.add("air right", [1], 8); 
			mySprite.add("air left", [4], 8);
			mySprite.play(swing);
			type = "hammer";
			graphic = mySprite;
		}
		
		
		
		override public function update():void {
			if (mySprite.frame == 1) {
				x = player.x + 25;
				y = player.y + 9;
				setHitbox(10, 10, -12, -4);
			}
			else if (mySprite.frame == 4) {
				x = player.x - 17;
				y = player.y + 9;
				setHitbox(10, 10, 0, -4);
			}
			else if (mySprite.frame == 2) {
				x = player.x + 23;
				y = player.y + 24;
				setHitbox(10, 10, -4, -9);
			}
			else if (mySprite.frame == 3) {
				x = player.x - 15;
				y = player.y + 24;
				setHitbox(10, 10, -8, -9);
			}
			else if (mySprite.frame == 0) {
				x = player.x + 23;
				y = player.y - 2;
				setHitbox(10, 10, -9, 0);
			}
			else {
				x = player.x - 15;
				y = player.y - 2;
				setHitbox(10, 10, 3, 0);
			}
			
			if (collideTypes(["basic enemy", "plant enemy", "mech enemy"], x, y)) {
				var enemy:Entity = collideTypes(["basic enemy", "plant enemy", "mech enemy"], x, y);
				BaseNPC(enemy).onCollision(2, 2);
			}
		}
		
	}

}