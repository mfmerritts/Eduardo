package entities.playercontrolled 
{
	import entities.environment.Item;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import ui.LoaderWorld;
	import ui.PowerUpDisplay;
	import ui.WorldMap;
	import entities.npcs.BaseNPC;
	
	import ui.EddyWorld;
	/**
	 * ...
	 * @author  Chance Gallegos
	 */
	public class PlayerEntity extends Entity
	{
		
		public var spriteEddy:Spritemap; // the width and hieght need to be difined for nonsquare sprites, otherwise, flash punk assumes sprites are square.
		private var powerUpsDisplay:PowerUpDisplay;
		
		public const GRAVITY:Number = 0.35;
		public var friction:Number = 0.02;
		public var ySpeed:Number = 0;
		public var xSpeed:Number = 0;
		private var specialJump:int = 1;
		private var specialJumpPow:int = 0;
		private var jumpPow:int = 0;
		private var cooldown:int = 0;
		public var drag:Number = 0.02;
		public var maxSpeed:Number = 3.0;
		
		private var attacking:Boolean = false;
		public var faceRight:Boolean = true;
		private var onGround:Boolean = false;
		private var isCrawling:Boolean = false;
		public var hasGrappleHook:Boolean = true;
		
		
		public function PlayerEntity(initX:Number=0, initY:Number = 0) {
			this.x = initX;
			this.y = initY;
			layer = 3;
			
			spriteEddy  = new Spritemap(Assets.EDDY, 29, 35, clearAnimFlags);
			// flashpunk uses sprite strips and automatical knows when to wrap over to the next row.
			// the frames are determined based on the width  and height given to the spritemap construction.
			spriteEddy.add("Right", [0, 1, 2, 3], 15);
			spriteEddy.add("Left", [4, 5, 6, 7], 15);
			spriteEddy.add("StandR", [0], 15);
			spriteEddy.add("StandL", [4], 15);
			spriteEddy.add("JumpR", [8], 15);
			spriteEddy.add("JumpL", [10], 15);
			spriteEddy.add("FallR", [9], 15);
			spriteEddy.add("FallL", [11], 15);
			spriteEddy.add("AttackR", [12, 13, 14], 15, false);
			spriteEddy.add("AttackL", [15, 16, 17], 15, false);
			spriteEddy.add("CrouchR", [20], 10);
			spriteEddy.add("CrouchL", [24], 10);
			spriteEddy.add("CrawlR", [21, 22, 21, 23], 10);
			spriteEddy.add("CrawlL", [25, 26, 25, 27], 10);
			spriteEddy.add("GlideR", [18], 10);
			spriteEddy.add("GlideL", [19], 10);
			graphic = spriteEddy;
			
			// type and name are properties used by flashpunk to find and interact with specific objects.
			type = "player";
			name = "eddy"
			setHitbox(22, 35, -3, 0);
			
		}
		
		// becuase this object is controled directly by the player, it has slight different rules regarind phsyics
		// in particular speed and direction are absent as they are unused by this class.
		override public function update():void {
			
			if (powerUpsDisplay == null) {
				powerUpsDisplay = new PowerUpDisplay(x, y);
				FP.world.add(powerUpsDisplay);
			}
			
			if (cooldown > 0) {
				cooldown--; 
			}
			
			movement();
			collisions();
			
			if (x >= EddyWorld.width - 173) { 
				FP.camera.x = EddyWorld.width - 320;
			}
			else if (x <= 147) {
				FP.camera.x = 0;
			}
			else {
				FP.camera.x = x - 160 + 13;
			}
			
			if (y > EddyWorld.height - 138) {
				FP.camera.y = EddyWorld.height - 240;
			}
			else if (y <= 102) {
				FP.camera.y = 0;
			}
			else {
				FP.camera.y = y - 120 + 18;
			}
			
			powerUpsDisplay.x = FP.camera.x + 6;
			powerUpsDisplay.y = FP.camera.y + 6;
		}
		
		/**
		 * Handles movement physics during normal gameplay.
		 */
		private function movement():void {
			
			wallsAndPlatforms();
			
			controls();
			
			ySpeed -= ySpeed * drag - ySpeed * ySpeed * ySpeed * 0.00015;
			xSpeed -= xSpeed * friction;
			
			
			if (ySpeed < 0) {
				moveBy(0, ySpeed, "wall");
			}
			else {
				setHitbox(22, 5, -3, -30);
				if (!collide("platform", x, y)) {
					moveBy(0, ySpeed, ["wall", "platform"], true);
				}
				else {
					moveBy(0, ySpeed, ["wall"], true);
				}
				if (!isCrawling) {
					setHitbox(22, 35, -3, 0);
				}
				else {
					setHitbox(22, 20, -3, -15);
				}
			}
			
			moveBy(xSpeed, 0, "wall");
			
		}
		
		private function wallsAndPlatforms():void {
			setHitbox(22, 5, -3, -30);
			
			onGround = false;
			
			if (ySpeed >= 0) {// checks to see of the player is standing.
				
				if (collideTypes("wall" , x, y + 1)) {// checks to see of the player is standing.
					ySpeed = 0;
					onGround = true;
					friction = 0.25;
					specialJump = 1;
				}
				
				if (collide("platform" , x, y + 1) && !collide("platform", x, y - 1)) {
					ySpeed = 0;
					onGround = true;
					friction = 0.25;
					specialJump = 1;
					
				}
				
			}
			
			if (!onGround) { // checks to see if the player is falling.
				ySpeed += GRAVITY;
				onGround = false;
				friction = 0.03;
				drag = 0.02;
				if (ySpeed < 0) {
					if (faceRight) {
						spriteEddy.play("JumpR");
					}
					else {
						spriteEddy.play("JumpL");
					}
				}
				else {
					if (faceRight) {
						spriteEddy.play("FallR");
					}
					else {
						spriteEddy.play("FallL");
					}
				}
			}
			
			if (!isCrawling) {
				setHitbox(22, 35, -3, 0);
			}
			else {
				setHitbox(22, 20, -3, -15);
			}
			
			if (collideTypes("wall", x, y - 1)) {// checks to see if the player hit a wall while jumping.
				if (ySpeed < 0) {
					ySpeed = 0;
					}
			}
			
			if (collideTypes("wall", x + xSpeed / Math.abs(xSpeed), y )) { // checks to see if the player hit a wall while running.
				xSpeed = 0;
			}
		}
		
		/**
		 * Handles collisions for enemies, collectibles, and other. 
		 */
		private function collisions():void {
			if (PlayerData.hearts <= 0) {
				FP.world.removeAll();
				FP.world = new WorldMap();
			}
			else if (y > EddyWorld.height) {
				FP.world.removeAll();
				FP.world = new WorldMap();
			}
			else if (x < -24 || x > EddyWorld.width + 24) {
				FP.world.removeAll();
				FP.world = new WorldMap();
			}
			
			if (!collideTypes(["basic enemy", "plant enemy", "hazard", "item", "mech enemy", "bullet"], x, y)) {
				return;
			}
			
			var other:Entity = collideTypes(["basic enemy", "plant enemy", "hazard", "item", "mech enemy", "bullet"], x, y);
			if (other.type == "hazard" || other.type == "plant enemy" || other.type == "bullet") {
				PlayerData.powerHits--;
				if (PlayerData.powerHits <= 0) {
					PlayerData.power = 0;
				}
				if (other.x + other.width > x + 13) {
					xSpeed = -3;
					ySpeed = -3;
				}
				else {
					xSpeed = 3;
					ySpeed = -3;
				}
				if (other.y <= y) {
					ySpeed = 0;
				}
			}
			else if (other.type == "basic enemy" || other.type == "mech enemy") {
				if (y + 35 < other.y + 3 + int(other.height/4)) {
					BaseNPC(other).onCollision(1);
					ySpeed = -4;
					if (Input.check(Key.UP) || Input.check(Key.Z)) {
						
						jumpPow = 16;
					}
				}
				else {
					PlayerData.powerHits--;
					if (PlayerData.powerHits <= 0) {
						PlayerData.power = 0;
					}
					if (other.x + other.width > x + 13) {
						xSpeed = -2;
						ySpeed = -1;
					}
					else {
						xSpeed = 2;
						ySpeed = -1;
					}
				}
			}
			else if (other.type == "item") {
				Item(other).collect();
			}
		}
		
		/**
		 * Handles controls
		 */
		private function controls():void {
			var keyDown:Boolean = false;
			if (Input.check(Key.LEFT)) { 
				friction = 0.07 //using a smaller friction while a key is held down helped smoth out controls.
				if (xSpeed > -maxSpeed) {
					xSpeed -= 0.5;
				}
				
				if (onGround) {
					if (!isCrawling) {
						spriteEddy.play("Left");
					}
					else {
						spriteEddy.play("CrawlL");
					}
				}
				keyDown = true;
				faceRight = false;
			}
			if (Input.check(Key.RIGHT)) { 
				friction = 0.07
				if (xSpeed < maxSpeed) {
					xSpeed += 0.5;
				}
				
				if (onGround) {
					if (!isCrawling) {
						spriteEddy.play("Right");
					}
					else {
						spriteEddy.play("CrawlR");
					}
				}
				keyDown = true;
				faceRight = true;
			}
			if (Input.pressed(Key.UP) || Input.pressed(Key.Z)) { 
				if (onGround) {
					ySpeed = -4;
					jumpPow = 16;
					
					onGround = false;
				}
			}
			else if (Input.check(Key.UP) || Input.check(Key.Z)) {
				if (jumpPow > 0) {
					jumpPow -= 1;
					ySpeed = -4;
				}
				
			}
			else {
				jumpPow = 0;
			}
			
			if (Input.check(Key.DOWN)) { 
				if (onGround) {
					isCrawling = true;
					maxSpeed = 1.2;
					setHitbox(22, 20, -3, -15);
					if (xSpeed < 0.1 && xSpeed > -0.1) {
						if (faceRight) {
							spriteEddy.play("CrouchR");
						}
						else {
							spriteEddy.play("CrouchL");
						}
					}
				}
				keyDown = true;
			}
			
			
			if ((!keyDown)) {
				if (onGround && !attacking) {
					if (isCrawling) {
						if (!collide("wall", x, y - 13)) {
							isCrawling = false;
							maxSpeed = 3.5;
							setHitbox(22, 35, -3, 0);
						}
						else {
							if (faceRight) {
								spriteEddy.play("CrouchR");
							}
							else {
								spriteEddy.play("CrouchL");
							}
						}
					}
					else {
						if (faceRight) {
						spriteEddy.play("StandR");
						}
						else {
							spriteEddy.play("StandL");
						}
					}
				}
			}
			
			if (Input.pressed(Key.X) && cooldown <= 0) {
				if (PlayerData.power == 3) {
					if (specialJump == 1) {
						specialJump = 0;
						specialJumpPow = 16;
						ySpeed = -3;
					}
				}
				else if (!isCrawling) {
					if (PlayerData.power == 12) {
						attacking = true;
						cooldown = 30;
						if (faceRight) {
							if (xSpeed < 0.3 && ySpeed == 0) {
								spriteEddy.play("AttackR");
							}
							FP.world.add(new PlayerFireball(x + 26, y + 8, 3 + xSpeed));
						}
						else {
							if (xSpeed > -0.3 && ySpeed == 0) {
								spriteEddy.play("AttackL");
							}
							FP.world.add(new PlayerFireball(x, y + 8, -3 + xSpeed));
						}
					}
					else if (PlayerData.power == 8) {
						var swing:String;
						attacking = true;
						cooldown = 45;
						if (faceRight) {
							if (xSpeed < 0.3 && ySpeed == 0) {
								spriteEddy.play("AttackR");
							}
							if (onGround) {
								swing = "ground right";
							}
							else {
								swing = "air right";
							}
							FP.world.add(new Hammer(x, y, this, swing));
						}
						else {
							if (xSpeed > -0.3 && ySpeed == 0) {
								spriteEddy.play("AttackL");
							}
							if (onGround) {
								swing = "ground left";
							}
							else {
								swing = "air left";
							}
							FP.world.add(new Hammer(x, y, this, swing));
						}
					}
					if (PlayerData.power == 7) {
						attacking = true;
						cooldown = 30;
						if (faceRight) {
							if (xSpeed < 0.3 && ySpeed == 0) {
								spriteEddy.play("AttackR");
							}
							FP.world.add(new PlayerPowderBall(x + 26, y + 8, 3 + xSpeed));
						}
						else {
							if (xSpeed > -0.3 && ySpeed == 0) {
								spriteEddy.play("AttackL");
							}
							FP.world.add(new PlayerPowderBall(x, y + 8, -3 + xSpeed));
						}
					}
				}
				
			}
			
			if (Input.check(Key.X)) {
				if (PlayerData.power == 3 && specialJumpPow > 0) {
					specialJumpPow--;
					ySpeed = -3;
				}
				if (PlayerData.power == 2 && ySpeed > 0) {
					if (specialJump == 1) {
						specialJump = 0;
						specialJumpPow = 90;
					}
					if (specialJumpPow > 0) {
						drag = 0.3;
						specialJumpPow--;
					}
					else {
						drag = 0.02;
					}
					if (faceRight) {
						spriteEddy.play("GlideR");
					}
					else {
						spriteEddy.play("GlideL");
					}
				}
			}
			
		}
		
		override public function removed():void {
			super.removed();
			graphic = null;
			mask = null;
			
		}
		
		private function clearAnimFlags():void {
			if (attacking) {
				attacking = false;
			}
		}
	}
}