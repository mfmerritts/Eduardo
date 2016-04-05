package 
{

	//Hey Marshall did this! Tehe!
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import ui.EddyWorld;
	import ui.MainMunu;
	
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
			FP.world = new MainMunu();
			FP.console.enable();
		}
		
		override public function init():void {
			
		}
		
	}
	
}