package entities 
{
	
	/**
	 * ...
	 * @author Chance
	 */
	public interface Collidable {
		
		/**
		 * Convenience method.
		 * @param	v1	- first optional parameter
		 * @param	v2	- second optional parameter
		 * @param	v3	- third optional parameter
		 */
		function onCollision(v1:Number = 0, v2:Number = 0, v3:Number = 0):void;
	}
	
}