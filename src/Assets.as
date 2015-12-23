package  
{
	/**
	 * This is the static class the imports and stores levels, graphics, and sounds for the game
	 * I will state the number of frames and dimensions of a single frame/tile in comments and will change this file
	 * anytime I add or edit a graphic.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class Assets 
	{
		//sprites
		[Embed(source = "../assets/gfx/bat_24x15x4.png")] public static const BAT:Class;
		[Embed(source = "../assets/gfx/eddy_29x35x28.png")] public static const EDDY:Class;
		[Embed(source = "../assets/gfx/lizard_24x9x4.png")] public static const LIZARD:Class;
		[Embed(source = "../assets/gfx/shooter_plant_40x40x16.png")] public static const SHOOTER_PLANT:Class;
		
		//tiles
		[Embed(source = "../assets/gfx/base_tiles_24x24.png")] public static const BASETILE:Class;
		[Embed(source = "../assets/gfx/decorative_tiles_24x24.png")] public static const DECORATION:Class;
		
		//levels
		[Embed(source = "../assets/levels/cave.oel", mimeType = "application/octet-stream")] public static const CAVE:Class;
		
		//Static level properties
		public static var width:int = 320;
		public static var height:int = 240;
		
		
	}

}