package entities.playercontrolled 
{
	import entities.environment.LevelNode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import ui.WorldMap;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class PlayerMap extends Entity {
		
		private var mySprite:Spritemap;
		private var countDown:int = 0;
		private static var cameFrom:String;
		private var moving:Boolean;
		
		public function PlayerMap(x:Number=0, y:Number=0) {
			this.x = x;
			this.y = y;
			mySprite = new Spritemap(Assets.EDDY_OVERMAP, 16, 16);
			mySprite.add("Anim", [0, 1], 7);
			visible = true;
			mySprite.play("Anim");
			setHitbox(16, 16);
			layer = 1;
			graphic = mySprite;
		}
		
		override public function update():void {
			
			if (x >= WorldMap.width - 168) { 
				FP.camera.x = WorldMap.width - 320;
			}
			else if (x <= 152) {
				FP.camera.x = 0;
			}
			else {
				FP.camera.x = x - 160 + 8;
			}
			
			if (y > WorldMap.height - 128) {
				FP.camera.y = WorldMap.height - 240;
			}
			else if (y <= 112) {
				FP.camera.y = 0;
			}
			else {
				FP.camera.y = y - 120 + 8;
			}
			
			
			if (moving) {
				if (cameFrom == "north") {
					y += 4;
				}
				else if (cameFrom == "south") {
					y -= 4;
				}
				else if (cameFrom == "west") {
					x += 4;
				}
				else if (cameFrom == "east") {
					x -= 4;
				}
				
				if (collide("node", x, y)) {
					if (countDown <= 0 ) {
						var node:Entity = collide("node", x, y);
						if (Math.abs(x + 4 - node.x) <= 3 && Math.abs(y + 4 - node.y) <= 3) {
							x = node.x - 4;
							y = node.y - 4;
							PlayerData.mapX = x;
							PlayerData.mapY = y;
							moving = false;
							LevelNode(node).setReturnPath(cameFrom);
						}
					}
				}
				
				countDown--;
			}
			else {
				var levelNode:LevelNode = LevelNode(collide("node", x, y));
				if (Input.pressed(Key.UP)) {
					if (levelNode.isValidPath(Key.UP)) {
						countDown = 4;
						moving = true;
						cameFrom = "south";
					}
				}
				else if (Input.pressed(Key.DOWN)) {
					if (levelNode.isValidPath(Key.DOWN)) {
						countDown = 4;
						moving = true;
						cameFrom = "north";
					}
				}
				else if (Input.pressed(Key.LEFT)) {
					if (levelNode.isValidPath(Key.LEFT)) {
						countDown = 4;
						moving = true;
						cameFrom = "east";
					}
				}
				else if (Input.pressed(Key.RIGHT)) {
					if (levelNode.isValidPath(Key.RIGHT)) {
						countDown = 4;
						moving = true;
						cameFrom = "west";
					}
				}
				else if (Input.pressed(Key.ENTER) || Input.pressed(Key.X)) {
					levelNode.enterLevel();
				}
			}
		}
		
		
		
	}

}