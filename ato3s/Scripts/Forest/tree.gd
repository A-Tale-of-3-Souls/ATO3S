extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	$SpriteStack.get_child(0).z_index = -1
	
