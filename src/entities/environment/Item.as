package entities.environment 
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * this is the base class for collectible items, anything that can be picked up
	 * should extend this class.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class Item extends BaseNPC 
	{
		
		public var GRAVITY:Number = 0;
		
		public function Item(x:Number=0, y:Number=0) 
		{
			super(x, y, graphic, mask);
			type = "item";
			GRAVITY = 0;
		}
		
	}

}