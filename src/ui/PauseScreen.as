package ui  
{
	import net.flashpunk.Entity;
	
	/**
	 * Currently, I am planning on have 3 pages for the pause menu, that may change 
	 * if it turns out that any combination of the pages can easily be consolidated.
	 * This class is unfinished, but the empty methods seem self explanatory.
	 * 
	 * @author  Chance Gallegos
	 */
	public class PauseScreen extends Entity {
		
		private const STATS:uint = 0;
		private const PROGRESS:uint = 1;
		private const OPTIONS:uint = 2;
		private var page:uint = 0;
		
		
		public function PauseScreen() {
			type = "pausemenu";
		}
		
		override public function update():void {
			if (page == STATS) {
				updateEQUIPMENT();
			}
			if (page == PROGRESS) {
				updatePROGRESS();
			}
			if (page == OPTIONS) {
				updateOPTIONS();
			}
		}
		
		public function updateEQUIPMENT():void {
			
		}
		public function updatePROGRESS():void {
			
		}
		public function updateOPTIONS():void {
			
		}
	}

}