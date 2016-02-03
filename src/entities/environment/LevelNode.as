package entities.environment 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	import ui.WorldMap;
	import ui.LoaderWorld;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class LevelNode extends Entity {
		
		private var cameFrom:String;
		private var levelName:String;
		
		private var nodeSprite:Spritemap;
		
		public function LevelNode(x:Number=0, y:Number=0, levelName:String = "none") {
			super(x, y);
			this.levelName = levelName;
			type = "node";
			setHitbox(8, 8);
			
			nodeSprite = new Spritemap(Assets.LEVEL_NODE, 8, 8);
			nodeSprite.add("not cleared", [0, 1, 2, 3], 7);
			nodeSprite.add("cleared", [4, 5, 6, 7], 7);
			nodeSprite.play("not cleared");
			
			layer = 4;
			
			graphic = nodeSprite;
		}
		
		public function isValidPath(key:int):Boolean {
			
			if (key == Key.UP) {
				for (var i:int = y - 8; i > 0; i -= 4) {
					if (collide("node", x, i)) {
						return true;
					}
					else if (collide("block", x, i)) {
						return false;
					}
				}
			}
			else if (key == Key.LEFT) {
				for (var h:int = x - 8; h > 0; h -= 4) {
					if (collide("node", h, y)) {
						return true;
					}
					else if (collide("block", h, y)) {
						return false;
					}
				}
			}
			else if (key == Key.RIGHT) {
				for (var k:int = x + 8; k < WorldMap.width; k += 4) {
					if (collide("node", k, y)) {
						return true;
					}
					else if (collide("block", k, y)) {
						return false;
					}
				}
			}
			else if (key == Key.DOWN) {
				for (var j:int = y + 8; j < WorldMap.height; j += 4) {
					if (collide("node", x, j)) {
						return true;
					}
					else if (collide("block", x, j)) {
						return false;
					}
				}
			}
			
			return false;
		}
		
		public function setReturnPath(cameFrom:String):void {
			this.cameFrom = cameFrom;
		}
		
		public function enterLevel():void {
			if (levelName == "Mystic Cave") {
				FP.world = new LoaderWorld(Assets.CAVE, 32, 220);
				FP.screen.color = 0x060611;
			}
			else if (levelName == "Pretty Plains") {
				FP.world = new LoaderWorld(Assets.PRETTY_PLAINS_1, 32, 152);
				FP.screen.color = 0x87CEFA;
			}
			else if (levelName == "Coastown Bridge") {
				FP.world = new LoaderWorld(Assets.CITY_BRIDGE, 32, 202);
				FP.screen.color = 0x87CEFA;
			}
			else if (levelName == "Butter Beach") {
				FP.world = new LoaderWorld(Assets.BUTTER_BEACH, 32, 480);
				FP.screen.color = 0x87CEFA;
			}
		}
		
	}

}