package ui  
{
	import entities.environment.DoorWay;
	import entities.environment.Platform;
	import entities.npcs.ShooterPlant;
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
	public class EddyWorld extends World
	{
		
		public var player:PlayerEntity;
		public var map:Entity;
		
		public var mapGrid:Grid;
		public var mapImage:Tilemap;
		public var mapData:Class;
		public var gameState:int;
		
		public const STATE_RUNNING:int = 0; //majority of gameplay
		public const STATE_PAUSED:int = 1;  //pause menue
		public const STATE_DIALOG:int = 2;  //text and cutscene
		public const STATE_DEAD:int = 3;	//game over -return to title or continue from last save
		
		private var pauseMenu:ui.PauseScreen;
		
		/**
		 * The set up allows a single world to handle all the levels. Individual levels are diffiend on the xml files.
		 * .oel is just the file extension ogmo looks for when editing, if you open them, they are xml files.
		 * 
		 * @param	loadMapData - contains the XML data for the level that is loaded. These are defined in the static class Assets.
		 * @param	x - the x position to place Eduardo when the level starts.
		 * @param	y - the y position to place eduardo when the level starts.
		 */
		
		public function EddyWorld(loadMapData:Class, x:Number, y:Number) 
		{
			mapData = loadMapData;
			
			var mapXML:XML = FP.getXML(mapData);
			var node:XML;
			
			// Create our map grid and tile it out.
			mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 24, 24, 0, 0);
			mapGrid.loadFromString(String(mapXML.grid), "", "\n");
			
			mapImage = new Tilemap(Assets.BASETILE, uint(mapXML.@width), uint(mapXML.@height), 24, 24);
			mapImage.loadFromString(String(mapXML.tiles), ",", "\n");
			
			// this actually adds the level to the world and assigns it a render layer.
			map = new Entity(0, 0, mapImage, mapGrid);
			map.type = "wall";
			map.layer = 10; 
			// flashpunk uses layers to decide what order ot draw the sprites. I don't understand how this works,
			// I just know that the higher the layer, the more stuff is drawn in front of it.
			
			player = new PlayerEntity(x, y);
			
			// there's probably a better way to by reading the string in XML and the matching it up to the appropriate constructor,
			// but it's beyond my knowledge, so I've been doing it this bruteforce way.
			for each (node in mapXML.entities.door) {
				add(new DoorWay(this, int(node.@x), int(node.@y), int(node.@targetX), int(node.@targetY), int(node.@index)));
			}
			for each (node in mapXML.entities.platform) {
				add(new Platform(int(node.@x), int(node.@y), int(node.@width)));
			}
			for each (node in mapXML.entities.spittyplant) {
				add(new ShooterPlant(int(node.@x), int(node.@y)));
			}
		}
		
		override public function begin():void
		{
			
			add(new DoorWay(this, 1128, 312, 50, 50, 0));
			
			add(map);
			
			add(player);
			
		}
		
		// called when levels need to be changed. The loader world doesn't do much now, but if needed, it can
		// display a loading screen. For now it just creates a new EddyWorld with the level and assigns to FP.world.
		public function gotoLevel(loadMapData:Class, x:Number, y:Number):void 
		{
			//FP is a static helper class used to keep track of important objects to the flashpunk game engine, such as the world and the current camera.
			FP.world = new LoaderWorld(loadMapData, x, y); //flashpunk has a built in event that is called when FP.world is changed to another world.
		}
		
		override public function update():void
		{
			
			if (typeCount("pausemenu") < 1)
			{
				super.update(); 
			}
		}
	}

}