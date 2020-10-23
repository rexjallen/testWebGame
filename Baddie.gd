extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")
	pass # Replace with function body.

func _hit_char(var player):
	if((player as KinematicBody2D).has_method("takeDamage")):
		(player as KinematicBody2D).call("takeDamage",10)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
