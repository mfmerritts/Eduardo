package ui  
{
	import entities.environment.*;
	import entities.environment.blocks.*;
	import entities.npcs.*;
	import flash.display.Loader;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import entities.playercontrolled.PlayerEntity;
	/**
	 * ...
	 * @author  Chance Gallegos
	 */
	public class EddyWorld extends World {
		
		//Static level properties
		public static var width:int = 320;
		public static var height:int = 240;
		
		private var player:PlayerEntity;
		private var map:Entity;
		private var decoration:Entity;
		
		private var mapGrid:Grid;
		private var mapImage:Tilemap;
		private var mapData:Class;
		private var gameState:int;
		
		public const STATE_RUNNING:int = 0; //majority of gameplay
		public const STATE_PAUSED:int = 1;  //pause menue
		public const STATE_DIALOG:int = 2;  //text and cutscene
		public const STATE_DEAD:int = 3;	//game over -return to title or continue from last save
		
		private var started:Boolean = false;
		private var xx:int;
		private var yy:int;
		
		private var pauseMenu:ui.PauseScreen;
		
		/**
		 * The set up allows a single world to handle all the levels. Individual levels are diffiend on the xml files.
		 * .oel is just the file extension ogmo looks for when editing, if you open them, they are xml files.
		 * 
		 * @param	loadMapData - contains the XML data for the level that is loaded. These are defined in the static class Assets.
		 * @param	x - the x position to place Eduardo when the level starts.
		 * @param	y - the y position to place eduardo when the level starts.
		 */
		
		public function EddyWorld(loadMapData:Class, x:Number, y:Number) {
			mapData = loadMapData;
			this.xx = x;
			this.yy = y;
			
		}
		
		override public function begin():void {
			
			if (started) {
				return;
			}
			started = true;
			
			var mapXML:XML = FP.getXML(mapData);
			var node:XML;
			
			EddyWorld.width = uint(mapXML.@width);
			EddyWorld.height = uint(mapXML.@height);
			
			mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 24, 24, 0, 0);
			mapGrid.loadFromString(String(mapXML.walls), "", "\n");
			
			mapImage = new Tilemap(Assets.BASETILE, uint(mapXML.@width), uint(mapXML.@height), 24, 24);
			mapImage.loadFromString(String(mapXML.walls_render), ",", "\n");
			
			// this actually adds the level to the world and assigns it a render layer.
			map = new Entity(0, 0, mapImage, mapGrid);
			map.type = "wall";
			map.layer = 10; 
			// flashpunk uses layers to decide what order ot draw the sprites. 
			var decorationImage:Tilemap = new Tilemap(Assets.DECORATION, uint(mapXML.@width), uint(mapXML.@height), 24, 24);
			decorationImage.loadFromString(String(mapXML.decoration), ",", "\n");
			
			decoration = new Entity(0, 0, decorationImage);
			decoration.layer = 9; 
			
			player = new PlayerEntity(xx, yy);
			
			add(map);
			add(decoration);
			add(player);
			
			// there's probably a better way to by reading the string in XML and the matching it up to the appropriate constructor,
			// but it's beyond my knowledge, so I've been doing it this bruteforce way.
			for each (node in mapXML.entities.toggleblockred) {
				add(new ToggleBlock(int(node.@x), int(node.@y), "red"));
			}
			for each (node in mapXML.entities.toggleblockblue) {
				add(new ToggleBlock(int(node.@x), int(node.@y), "blue"));
			}
			for each (node in mapXML.entities.toggleblockgreen) {
				add(new ToggleBlock(int(node.@x), int(node.@y), "green"));
			}
			for each (node in mapXML.entities.toggleblockyellow) {
				add(new ToggleBlock(int(node.@x), int(node.@y), "yellow"));
			}
			for each (node in mapXML.entities.toggleplatformred) {
				add(new TogglePlatform(int(node.@x), int(node.@y), "red"));
			}
			for each (node in mapXML.entities.toggleplatformblue) {
				add(new TogglePlatform(int(node.@x), int(node.@y), "blue"));
			}
			for each (node in mapXML.entities.toggleplatformgreen) {
				add(new TogglePlatform(int(node.@x), int(node.@y), "green"));
			}
			for each (node in mapXML.entities.toggleplatformyellow) {
				add(new TogglePlatform(int(node.@x), int(node.@y), "yellow"));
			}
			for each (node in mapXML.entities.buttonred) {
				add(new BubbleSwitch(int(node.@x), int(node.@y), "red"));
			}
			for each (node in mapXML.entities.buttonblue) {
				add(new BubbleSwitch(int(node.@x), int(node.@y), "blue"));
			}
			for each (node in mapXML.entities.buttongreen) {
				add(new BubbleSwitch(int(node.@x), int(node.@y), "green"));
			}
			for each (node in mapXML.entities.buttonyellow) {
				add(new BubbleSwitch(int(node.@x), int(node.@y), "yellow"));
			}
			for each (node in mapXML.entities.timerred) {
				add(new TimerSwitch(int(node.@x), int(node.@y), "red"));
			}
			for each (node in mapXML.entities.timerblue) {
				add(new TimerSwitch(int(node.@x), int(node.@y), "blue"));
			}
			for each (node in mapXML.entities.timergreen) {
				add(new TimerSwitch(int(node.@x), int(node.@y), "green"));
			}
			for each (node in mapXML.entities.timeryellow) {
				add(new TimerSwitch(int(node.@x), int(node.@y), "yellow"));
			}
			for each (node in mapXML.entities.chest) {
				add(new Chest(int(node.@x), int(node.@y), int(node.@item)));
			}
			for each (node in mapXML.entities.vibrantcrystal) {
				add(new Crystal(int(node.@x), int(node.@y)));
			}
			for each (node in mapXML.entities.shooterplant) {
				add(new ShooterPlant(int(node.@x), int(node.@y)));
			}
			for each (node in mapXML.entities.firehat) {
				add(new FireHat(int(node.@x), int(node.@y), String(node.@drops)));
			}
			for each (node in mapXML.entities.lasher) {
				add(new Lasher(int(node.@x), int(node.@y)));
			}
			for each (node in mapXML.entities.thornplant) {
				add(new ThornPlant(int(node.@x), int(node.@y)));
			}
			for each (node in mapXML.entities.doorway) {
				add(new DoorWay(int(node.@stage), int(node.@x), int(node.@y), int(node.@targetX), int(node.@targetY)));
			}
			for each (node in mapXML.entities.walkway) {
				add(new WalkWay(int(node.@stage), int(node.@x), int(node.@y), int(node.@targetX), int(node.@targetY), int(node.@width), int(node.@height)));
			}
			for each (node in mapXML.entities.platform) {
				add(new Platform(int(node.@x), int(node.@y), int(node.@width)));
			}
			for each (node in mapXML.entities.bat) {
				add(new Bat(int(node.@x), int(node.@y), String(node.@pattern), Number(node.@preferredSpeed), Number(node.@size)));
			}
			for each (node in mapXML.entities.buzzbot) {
				add(new Buzzbot(int(node.@x), int(node.@y), String(node.@behavior), Number(node.@speed), Number(node.@size), int(node.@drops)));
			}
			for each (node in mapXML.entities.jumprobot) {
				add(new JumpRobot(int(node.@x), int(node.@y), int(node.@drops)));
			}
			for each (node in mapXML.entities.lizard) {
				add(new Lizard(int(node.@x), int(node.@y)));
			}
			for each (node in mapXML.entities.hazards) {
				add(new Hazard(int(node.@x), int(node.@y), String(node.@side)));
			}
			
		}
		
		override public function update():void  {
			
			if (typeCount("pausemenu") < 1) {
				super.update(); 
			}
		}
	}

}