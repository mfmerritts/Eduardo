package entities.playercontrolled 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author  Chance Gallegos
	 */
	public class PlayerEntity extends Entity
	{
		
		public var spriteEddy:Spritemap = new Spritemap(Assets.EDDY, 29, 35); // the width and hieght need to be difined for nonsquare sprites, otherwise, flash punk assumes sprites are square.
		public var faceRight:Boolean = true;
		public const GRAVITY:Number = 0.3;
		public var friction:Number = 0.02;
		public var ySpeed:Number = 0;
		public var xSpeed:Number = 0;
		private var jumpPow:int = 0;
		public var drag:Number = 0.02;
		public var maxSpeed:Number = 4;
		private var onGround:Boolean = false;
		public var hasGrappleHook:Boolean = true;

		
		public function PlayerEntity(initX:Number=0, initY:Number = 0) 
		{
			this.x = initX;
			this.y = initY;
			layer = 5;
			
			// flashpunk uses sprite strips and automatical knows when to wrap over to the next row.
			// the frames are determined based on the width  and height given to the spritemap construction.
			spriteEddy.add("Right", [0, 1, 2, 3], 15, true);
			spriteEddy.add("Left", [4, 5, 6, 7], 15, true);
			spriteEddy.add("StandR", [0], 15, false);
			spriteEddy.add("StandL", [4], 15, false);
			spriteEddy.add("JumpR", [8], 15, false);
			spriteEddy.add("JumpL", [9], 15, false);
			graphic = spriteEddy;
			
			// type and name are properties used by flashpunk to find and interact with specific objects.
			type = "player";
			name = "eddy"
			setHitbox(23, 35, -3, 0);
		}
		
		// becuase this object is controled directly by the player, it has slight different rules regarind phsyics
		// in particular speed and direction are absent as they are unused by this class.
		override public function update():void
		{
			if (!collideTypes("wall", x, y + 1)) // checks to see if the player is falling.
			{
				ySpeed += GRAVITY;
				onGround = false;
				friction = 0.02;
				if (faceRight)
					{
						spriteEddy.play("JumpR");
					}
					if (!faceRight)
					{
						spriteEddy.play("JumpL");
					}
			}
			
			if (collideTypes("wall", x, y + 1)) // checks to see of the player is standing.
			{
				if (ySpeed >= 0)
				{
					ySpeed = 0;
					onGround = true;
					friction = 0.25;
				}
			}
			
			if (collideTypes("wall", x, y - 1)) // checks to see if the player hit a wall while jumping.
			{
				if (ySpeed < 0)
					{ySpeed = 0;}
			}
			
			if (collideTypes("wall", x + xSpeed / Math.abs(xSpeed), y )) // checks to see if the player hit a wall while running.
			{
				xSpeed = 0;
			}
			
			controls();
			
			ySpeed -= ySpeed * drag;
			xSpeed -= xSpeed * friction;
			moveBy(xSpeed, ySpeed, "wall"); // flashpunks built in function move by knows not to overlap the entity with the given object types.
			
			FP.camera.x = x - 160;
			FP.camera.y = y - 120;
		}
		
		// seems self explanatory.
		private function controls():void 
		{
			var keyDown:Boolean = false;
			if (Input.check(Key.LEFT)) 
			{ 
				friction = 0.07 //using a smaller friction while a key is held down helped smoth out controls.
				if (xSpeed > -maxSpeed)
				{
					xSpeed -= 0.5;
				}
				if (xSpeed < -maxSpeed)
				{
					xSpeed = -maxSpeed;
				}
				if (onGround)
				{
					spriteEddy.play("Left");
				}
				keyDown = true;
				faceRight = false;
			}
			if (Input.check(Key.RIGHT)) 
			{ 
				friction = 0.07
				if (xSpeed < maxSpeed)
				{
					xSpeed += 0.5;
				}
				if (xSpeed > maxSpeed)
				{
					xSpeed = maxSpeed;
				}
				if (onGround)
				{
					spriteEddy.play("Right");
				}
				keyDown = true;
				faceRight = true;
			}
			if (Input.pressed(Key.UP)) 
			{ 
				if (onGround)
				{
					ySpeed = -4;
					jumpPow = 15;
					
					onGround = false;
				}
			}
			if (Input.check(Key.UP))
			{
				if (jumpPow > 0)
				{
					jumpPow -= 1;
					ySpeed = -4;
				}
				
			}
			if (Input.check(Key.DOWN)) 
			{ 
				
				keyDown = true;
			}
			
			if ((!keyDown))
			{
				
				if (onGround)
					{
						if (faceRight)
					{
						spriteEddy.play("StandR");
					}
					if (!faceRight)
					{
						spriteEddy.play("StandL");
					}
				}
			}
		}
	}

}