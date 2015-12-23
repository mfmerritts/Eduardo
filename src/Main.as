package 
{
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import ui.EddyWorld;
	
	/**
	 * flashpunks main engine initates the main game loop and initial world
	 * ...
	 * @author  Chance Gallegos
	 */
	public class Main extends Engine
	{
		
		public function Main():void {
			super(320, 240, 60, false);
			FP.screen.color = 0x060606;
			FP.screen.scale = 2;
			FP.world = new ui.EddyWorld(Assets.CAVE, 50, 50);
		}
		
		override public function init():void {
			
		}
		
	}
	
}