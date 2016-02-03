package ui 
{
	
	import entities.environment.LevelNode;
	import entities.playercontrolled.PlayerMap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Chance
	 */
	public class WorldMap extends World {
		
		public static var width:int;
		public static var height:int;
		
		private var terrainLayer:Entity;
		private var featuresLayer:Entity;
		private var roadLayer:Entity;
		
		private var player:PlayerMap;
		
		private var terrainImage:Tilemap;
		
		public function WorldMap() {
			super();
			
			var mapXML:XML = FP.getXML(Assets.OVERMAP);
			var node:XML;
			
			WorldMap.width = uint(mapXML.@width);
			WorldMap.height = uint(mapXML.@height);
			
			terrainImage = new Tilemap(Assets.OVERMAP_TILE, WorldMap.width, WorldMap.height, 8, 8);
			terrainImage.loadFromString(String(mapXML.terrain), ",", "\n");
			
			terrainLayer = new Entity(0, 0, terrainImage);
			terrainLayer.layer = 10;
			
			var image:Tilemap = new Tilemap(Assets.OVERMAP_TILE, WorldMap.width, WorldMap.height, 8, 8);
			image.loadFromString(String(mapXML.features), ",", "\n");
			
			featuresLayer = new Entity(0, 0, image);
			featuresLayer.layer = 9;
			
			image = new Tilemap(Assets.OVERMAP_TILE, WorldMap.width, WorldMap.height, 8, 8);
			image.loadFromString(String(mapXML.paths), ",", "\n");
			
			roadLayer = new Entity(0, 0, image);
			roadLayer.layer = 8;
			
			add(terrainLayer);
			add(featuresLayer);
			add(roadLayer);
			
			for each (node in mapXML.levelnodes.levelNode) {
				add(new LevelNode(int(node.@x), int(node.@y), String(node.@levelName)));
			}
			for each (node in mapXML.levelnodes.blocker) {
				var block:Entity = new Entity(int(node.@x), int(node.@y));
				block.type = "block";
				block.setHitbox(6, 6, -1, -1);
				add(block);
			}
			
			player = new PlayerMap(PlayerData.mapX, PlayerData.mapY);
			add(player);
		}
		
	}

}