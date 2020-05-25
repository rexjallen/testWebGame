extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#set up Prallax Mirroring because I"m too lazy to do it by hand
	$ParallaxBackground/ParallaxLayer.set_mirroring($ParallaxBackground/ParallaxLayer/Sprite.texture.get_size()*$ParallaxBackground/ParallaxLayer/Sprite.get_global_transform().get_scale())
	$ParallaxBackground/ParallaxLayer2.set_mirroring($ParallaxBackground/ParallaxLayer2/Sprite.texture.get_size()*$ParallaxBackground/ParallaxLayer2/Sprite.get_global_transform().get_scale())
	$ParallaxBackground/ParallaxLayer3.set_mirroring($ParallaxBackground/ParallaxLayer3/Sprite.texture.get_size()*$ParallaxBackground/ParallaxLayer3/Sprite.get_global_transform().get_scale())
	$ParallaxBackground/ParallaxLayer4.set_mirroring($ParallaxBackground/ParallaxLayer4/Sprite.texture.get_size()*$ParallaxBackground/ParallaxLayer4/Sprite.get_global_transform().get_scale())
	$ParallaxBackground/ParallaxLayer5.set_mirroring($ParallaxBackground/ParallaxLayer5/Sprite.texture.get_size()*$ParallaxBackground/ParallaxLayer5/Sprite.get_global_transform().get_scale())
	$ParallaxBackground/ParallaxLayer6.set_mirroring($ParallaxBackground/ParallaxLayer6/Sprite.texture.get_size()*$ParallaxBackground/ParallaxLayer6/Sprite.get_global_transform().get_scale())

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
