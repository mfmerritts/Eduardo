package  
{
	/**
	 * This is the static class the imports and stores levels, graphics, and sounds for the game
	 * I will state the number of frames and dimensions of a single frame/tile in comments and will change this file
	 * anytime I add or edit a graphic.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class Assets {
		//sprites
		[Embed(source = "../assets/gfx/stock_arrows_24x24x4.png")] public static const ARROWS:Class;
		[Embed(source = "../assets/gfx/bat_24x15x4.png")] public static const BAT:Class;
		[Embed(source = "../assets/gfx/blue_button_16x8x2.png")] public static const BUBBLE_SWITCH_BLUE:Class;
		[Embed(source = "../assets/gfx/green_button_16x8x2.png")] public static const BUBBLE_SWITCH_GREEN:Class;
		[Embed(source = "../assets/gfx/red_button_16x8x2.png")] public static const BUBBLE_SWITCH_RED:Class;
		[Embed(source = "../assets/gfx/yellow_button_16x8x2.png")] public static const BUBBLE_SWITCH_YELLOW:Class;
		[Embed(source = "../assets/gfx/buzzbot_30x18x4.png")] public static const BUZZBOT:Class;
		[Embed(source = "../assets/gfx/buzzbot_chaser_30x18x4.png")] public static const BUZZBOT_CHASER:Class;
		[Embed(source = "../assets/gfx/buzzbot_shooter_30x18x4.png")] public static const BUZZBOT_SHOOTER:Class;
		[Embed(source = "../assets/gfx/clock_bot_37x33x11.png")] public static const CLOCK_BOT:Class;
		[Embed(source = "../assets/gfx/wing_boots_24x24.png")] public static const DOUBLE_JUMP:Class;
		[Embed(source = "../assets/gfx/eddy_29x35x28.png")] public static const EDDY:Class;
		[Embed(source = "../assets/gfx/eddy_overmap_16x16x2.png")] public static const EDDY_OVERMAP:Class;
		[Embed(source = "../assets/gfx/crumbling_energy_24x24x5.png")] public static const ENERGY_BLOCK:Class;
		[Embed(source = "../assets/gfx/fire_particle_image_20x16x5.png")] public static const FIRE:Class;
		[Embed(source = "../assets/gfx/red_hat_18x21x10.png")] public static const FIRE_HAT:Class;
		[Embed(source = "../assets/gfx/glide_wings_24x24.png")] public static const GLIDE_WINGS:Class;
		[Embed(source = "../assets/gfx/hammer_24x24.png")] public static const HAMMER:Class;
		[Embed(source = "../assets/gfx/hammer_swing_20x17x6.png")] public static const HAMMER_SWING:Class;
		[Embed(source = "../assets/gfx/jumper_bot_20x32x8_strip8.png")] public static const JUMPBOT:Class;
		[Embed(source = "../assets/gfx/level_icons_8x8x8.png")] public static const LEVEL_NODE:Class;
		[Embed(source = "../assets/gfx/lasher_plant_32x48x13.png")] public static const LASHER_PLANT:Class;
		[Embed(source = "../assets/gfx/lasher_vine_48x48x10.png")] public static const LASHER_VINE:Class;
		[Embed(source = "../assets/gfx/cave_lizard_24x9x13.png")] public static const LIZARD:Class;
		[Embed(source = "../assets/gfx/matchbox_24x24.png")] public static const MATCHBOX:Class;
		[Embed(source = "../assets/gfx/projectiles_8x8x8.png")] public static const PROJECTILES:Class;
		[Embed(source = "../assets/gfx/red_chest_24x24x2.png")] public static const RED_CHEST:Class;
		[Embed(source = "../assets/gfx/crumbling_sandstone_24x24x5.png")] public static const SANDSTONE_BLOCK:Class;
		[Embed(source = "../assets/gfx/shooter_plant_40x40x16.png")] public static const SHOOTER_PLANT:Class;
		[Embed(source = "../assets/gfx/blue_timer_switch_24x16x9.png")] public static const TIMER_SWITCH_BLUE:Class;
		[Embed(source = "../assets/gfx/green_timer_switch_24x16x9.png")] public static const TIMER_SWITCH_GREEN:Class;
		[Embed(source = "../assets/gfx/red_timer_switch_24x16x9.png")] public static const TIMER_SWITCH_RED:Class;
		[Embed(source = "../assets/gfx/yellow_timer_switch_24x16x9.png")] public static const TIMER_SWITCH_YELLOW:Class;
		[Embed(source = "../assets/gfx/thorn_plant_27x18.png")] public static const THORN_PLANT:Class;
		[Embed(source = "../assets/gfx/blue_toggle_block_24x24x2.png")] public static const TOGGLE_BLOCK_BLUE:Class;
		[Embed(source = "../assets/gfx/green_toggle_block_24x24x2.png")] public static const TOGGLE_BLOCK_GREEN:Class;
		[Embed(source = "../assets/gfx/red_toggle_block_24x24x2.png")] public static const TOGGLE_BLOCK_RED:Class;
		[Embed(source = "../assets/gfx/yellow_toggle_block_24x24x2.png")] public static const TOGGLE_BLOCK_YELLOW:Class;
		[Embed(source = "../assets/gfx/blue_toggle_block_thin_24x8.png")] public static const TOGGLE_PLATFORM_BLUE:Class;
		[Embed(source = "../assets/gfx/green_toggle_block_thin_24x8x2.png")] public static const TOGGLE_PLATFORM_GREEN:Class;
		[Embed(source = "../assets/gfx/red_toggle_block_thin_24x8x2.png")] public static const TOGGLE_PLATFORM_RED:Class;
		[Embed(source = "../assets/gfx/yellow_toggle_block_thin_24x8x2.png")] public static const TOGGLE_PLATFORM_YELLOW:Class;
		[Embed(source = "../assets/gfx/vibrant_crystal_24x24x8_strip8.png")] public static const VIBRANT_CRYSTAL:Class;
		
		//tiles
		[Embed(source = "../assets/gfx/base_tiles_24x24.png")] public static const BASETILE:Class;
		[Embed(source = "../assets/gfx/decorative_tiles_24x24.png")] public static const DECORATION:Class;
		[Embed(source = "../assets/gfx/tiles_by_TearOfTheStar_8x8.png")] public static const OVERMAP_TILE:Class;
		
		//levels
		[Embed(source = "../assets/levels/bridge_warehouse.oel", mimeType = "application/octet-stream")] public static const BRIDGE_WAREHOUSE:Class;
		[Embed(source = "../assets/levels/butter_beach_1.oel", mimeType = "application/octet-stream")] public static const BUTTER_BEACH:Class;
		[Embed(source = "../assets/levels/cave.oel", mimeType = "application/octet-stream")] public static const CAVE:Class;
		[Embed(source = "../assets/levels/cave_2.oel", mimeType = "application/octet-stream")] public static const CAVE_2:Class;
		[Embed(source = "../assets/levels/city_bridge.oel", mimeType = "application/octet-stream")] public static const CITY_BRIDGE:Class;
		[Embed(source = "../assets/levels/pretty_plains_1.oel", mimeType = "application/octet-stream")] public static const PRETTY_PLAINS_1:Class;
		[Embed(source="../assets/levels/pretty_plains_2.oel", mimeType="application/octet-stream")] public static const PRETTY_PLAINS_2:Class;
		[Embed(source = "../assets/levels/over_map.oel", mimeType = "application/octet-stream")] public static const OVERMAP:Class;
		
		//labels and icons
		[Embed(source = "../assets/gfx/icons_24x24x13.png")] public static const POWERUP_ICONS:Class;
		[Embed(source = "../assets/gfx/titlebanner_97x35.png")] public static const TITLE:Class;
		
		
		
		
		
	}

}