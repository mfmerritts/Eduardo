package ui  
{
	import net.flashpunk.World;
	import net.flashpunk.FP; 
	import ui.EddyWorld;
	
	/**
	 * This world is used to transition levels. Currently, it doesn't really do anything and is not actually needed,
	 * but I set it up this way so that this class can be used for loading screens in order to have options regarding
	 * cutscenes or loading screens.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class LoaderWorld extends World 
	{
		
		private var level:World;
		
		public function LoaderWorld(mapData:Class, x:Number, y:Number) 
		{
			level = new ui.EddyWorld(mapData, x, y);
			
		}
		
		override public function begin():void
		{
			
			FP.world = level;
			
		}
		
	}

}