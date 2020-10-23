extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var jumpStrength = 300
export var maxSpeed = 200
const defaultAcc = 400
const flappingAcc = 200
export var acceleration = defaultAcc
export var deceleration = 500

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
	_process_movement(delta)

func _process_movement(delta):
	var movement_input = Vector2.ZERO #hodler for left and right input
	var isOnFloor = _is_on_floor()
	
	#get horizontal acceleration
	if isOnFloor:
		acceleration = defaultAcc #TODO: get value form floor (or friction?)
	else:
		acceleration = flappingAcc

	#handle jumping
	if(Input.is_action_just_pressed("jump")) and (isOnFloor):
		velocity.y = -jumpStrength #initial speed, no ramp up (yet)
	elif not (isOnFloor):
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

	if(movement_input) :
		$AnimatedSprite.play("walk") #whats the cost for calling this every time?
		if(
			((-1 == movement_input) && (velocity.x > -maxSpeed)) 
			|| ((1 == movement_input) && (velocity.x < maxSpeed))
			):
			velocity.x += movement_input*acceleration*delta
			if(abs(velocity.x) >= maxSpeed):
				velocity.x = maxSpeed*movement_input
	elif !isOnFloor:
		pass
	elif abs(velocity.x) > deceleration*delta:
		velocity.x -= sign(velocity.x)*deceleration*delta
	else:
		_stop_walking()

	if(velocity.length() > 0):
		self.move_and_slide(velocity,Vector2( 0, 0 ), false, 4, 0.785398,false)
		#check collisions
		for i in self.get_slide_count():
			var collision = self.get_slide_collision(i)
			#print((collision.collider as Node2D).get_class() )
			if (collision.collider.has_method("_hit_char")):
				collision.collider.call("_hit_char",self)
#			if ((collision.collider as Node2D).get_class() == "RigidBody2D"):
#				pass
			#if abs(collision.get_normal().x) == 1:
			#	_stop_walking()

func takeDamage(var dmg):
	print("I'm taking damage")

func _stop_walking():
	$AnimatedSprite.stop()
	velocity.x = 0
	
func _is_on_floor():
	return self.test_move(self.transform,Vector2(0,1))
