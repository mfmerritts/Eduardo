package entities.environment 
{
	import entities.Collidable;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * this is the base class for collectible items, anything that can be picked up
	 * should extend this class. 
	 * ...
	 * @author  Chance Gallegos
	 */
	public class Item extends Entity implements Collidable
	{
		
		protected var GRAVITY:Number = 0;
		
		public function Item(x:Number=0, y:Number=0) {
			super(x, y);
			type = "item";
			GRAVITY = 0;
		}
		
		/**
		 * Override this: Called when the item is collected.
		 */
		public function collect():void {
			
		}
		
		public function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void {
			collect();
		}
		
	}

}