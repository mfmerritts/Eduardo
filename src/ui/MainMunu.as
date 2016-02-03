package ui  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Data;
	
	/**
	 * This is the main menu screen that shows up giving the main options to the player.
	 * Currently play, credits and erase data, custom controls to come in the future.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class MainMunu extends World {
		
		private var selection:int = 1;
		private var selectorIcon:Entity;
		
		public function MainMunu() {
			super();
			var icon:Spritemap;
			icon = new Spritemap(Assets.ARROWS, 24, 24);
			icon.frame = 0;
			selectorIcon = new Entity(0, 0, icon);
			add(selectorIcon);
			
			add(new Entity(110, 73, new Text("Play Game", 5, 10)));
			add(new Entity(110, 108, new Text("Credits", 5, 10)));
			add(new Entity(110, 143, new Text("Erase Data", 5, 10)));
			add(new Entity(111, 10, new Image(Assets.TITLE)));
			
			Data.load("savedata");
			
			PlayerData.maxHearts = Data.readInt("maxHearts", 6);
			PlayerData.hearts = PlayerData.maxHearts;
			
			PlayerData.mapX = Data.readInt("mapX", 68);
			PlayerData.mapY = Data.readInt("mapY", 244);
			
		}
		
		override public function update():void {
			super.update();
			
			if (Input.pressed(Key.UP) || Input.pressed(Key.RIGHT)) {
				selection--;
				if (selection < 1) {
					selection = 4;
				}
			}
			if (Input.pressed(Key.DOWN) || Input.pressed(Key.LEFT)) {
				selection++;
				if (selection > 4) {
					selection = 1;
				}
			}
			
			//if (selection < 4) {
				selectorIcon.x = 80;
				selectorIcon.y = 45 + 35 * selection;
			//}
			/*
			if (selection == 4) {
				selectorIcon.x = 80;
				selectorIcon.y = 190;
			}
			*/
			
			if (Input.pressed(Key.ENTER) || Input.pressed(Key.Z)) {
				if (selection == 1) {
					FP.world = new WorldMap();
				}
			}
			
		}
		
	}

}