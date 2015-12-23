package entities.npcs 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	
	/**
	 * This class extends that flashpunk entity to implement they physics and establish core behaviors
	 * feel free to modify as necessary.
	 * ...
	 * @author  Chance Gallegos
	 */
	public class BaseNPC extends Entity 
	{
		
		protected var faceRight:Boolean = true; //indicates whether the object is facing right or left.
		protected var GRAVITY:Number = 0.2; //is treated like a constant, but some subclasses may have different values so it's variable, if this is not inline with best programming practices feel free to modify.
		protected var friction:Number = 0.02; //act's as the horizontal drag force.
		private var ySpeed:Number = 0;
		private var xSpeed:Number = 0;
		private var speed:Number = 0;
		private var direction:Number = 0;
		protected var drag:Number = 0.02; //act's as the vertical drag force.
		protected var maxSpeed:Number = 4;
		protected var onGround:Boolean = false;
		
		public function BaseNPC(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
			
		}
		
		public function destroy():void {
			FP.world.remove(this);
		}
		
		/**
		 * Called in order to move the entity.
		 */
		public function objectMove():void {
			if (!collideTypes(["wall", "platform"], x, y + 1)) {
				setYSpeed(ySpeed + GRAVITY);
				onGround = false;
				friction = 0.02;
			}
			
			if (collideTypes(["wall", "platform"], x, y + 1)) {
				setYSpeed(0);
				onGround = true;
				friction = 0.2;
			}
			
			if (collideTypes("wall", x, y - 1))
			{
				if (ySpeed < 0)
					{setYSpeed(0);}
			}
			
			moveBy(xSpeed, ySpeed, "wall");
			
			setYSpeed(ySpeed - ySpeed * drag);
			setXSpeed(xSpeed - xSpeed * friction);
		}
		
		//these functions are used to update interlinked properties whenever any individual property is modified.
		/**
		 * 
		 * @param	xS	- x componenent of velocity.
		 */
		public function setXSpeed(xS:Number = 0):void {
			xSpeed = xS;
			speed = Math.sqrt(Math.pow(xSpeed, 2) + Math.pow(ySpeed, 2));
			direction = Math.atan2(ySpeed, xSpeed);
		}
		
		/**
		 * 
		 * @param	yS	- y component of velocity.
		 */
		public function setYSpeed(yS:Number = 0):void {
			ySpeed = yS;
			speed = Math.sqrt(Math.pow(xSpeed, 2) + Math.pow(ySpeed, 2));
			direction = Math.atan2(ySpeed, xSpeed);
		}
		
		/**
		 * 
		 * @param	dr	- direction in radians.
		 */
		public function setDirection(dr:Number = 0):void {
			while (dr < 0) {
				dr += 2 * Math.PI;
			}
			while (dr >= (2 * Math.PI)) {
				dr -= 2 * Math.PI;
			}
			direction = dr;
			ySpeed = speed * Math.sin(direction);
			xSpeed = speed * Math.cos(direction);
		}
		
		/**
		 * 
		 * @param	sp	- the speed of the NPC
		 */
		public function setSpeed(sp:Number = 0):void {
			speed = sp;
			ySpeed = speed * Math.sin(direction);
			xSpeed = speed * Math.cos(direction);
			speed = Math.abs(speed);
		}
		
		public function getXSpeed():Number {
			return xSpeed;
		}
		
		public function getYSpeed():Number {
			return ySpeed;
		}
		
		/**
		 * 
		 * @return direction	- in radians.
		 */
		public function getDirection():Number {
			return direction;
		}
		
		/**
		 * 
		 * @return Speed
		 */
		public function getSpeed():Number {
			return speed;
		}
	}

}