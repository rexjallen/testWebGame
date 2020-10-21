extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var jumpStrength = 125
export var maxSpeed = 500
export var acceleration = 200
export var deceleration = 100

var movement_norm = Vector2()
var velocity = Vector2()
var jumping = false


#get gravity
var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var movement_input = 0 #hodler for left and right input

	#handle jumping
	if(Input.is_action_just_pressed("jump")) and (self.test_move(self.transform,Vector2(0,1))):
		velocity.y = -jumpStrength #initial speed, no ramp up (yet)
	elif not (self.test_move(self.transform,Vector2(0,1))):
		velocity.y = velocity.y + gravity_magnitude*delta

	#move left/right
	if Input.is_action_pressed("ui_left"):
		movement_input = -1
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		movement_input = 1
		$AnimatedSprite.flip_h = false
	else:
		movement_input = 0

	if(movement_input):
		$AnimatedSprite.play("walk")
		if(abs(velocity.x) < maxSpeed):
			velocity.x += movement_input*acceleration*delta
			if(abs(velocity.x) >= maxSpeed):
				velocity.x = maxSpeed*movement_input
	elif abs(velocity.x) > deceleration*delta:
		velocity.x -= sign(velocity.x)*deceleration*delta
#		print("stopping")
	else:
		$AnimatedSprite.stop()
		velocity.x = 0
#		print("stopped")

	#get left/right input
#	if Input.is_action_pressed(("ui_left")):
#		movement_norm.x = -1
#		#animate
#		$AnimatedSprite.play("walk") 
#	elif Input.is_action_pressed("ui_right"):
#		movement_norm.x = 1
#		#animate
#		$AnimatedSprite.play("walk") 
#	else:
#		movement_norm.x = 0
#	#accelrate left or right
#	if (abs(movement_norm.x) > 0) and abs(movement.x) < maxSpeed : 
#		movement.x += movement_norm.x*acceleration*delta
#	elif(abs(movement_norm.x) > 0) :
#		movement.x = movement.normalized().x*maxSpeed
#	else:
#		#slow Down
#		if abs(movement.x) > abs((-movement.normalized().x)*deceleration*delta):
#			movement.x += (-movement.normalized().x)*deceleration*delta
#		else:
#			movement.x = 0
#			$AnimatedSprite.stop()
	
	self.move_and_slide(velocity)

