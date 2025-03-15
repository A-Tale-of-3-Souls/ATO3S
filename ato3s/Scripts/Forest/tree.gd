extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	$SpriteStack.get_child(0).z_index = -1


func _on_area_2d_body_entered(body):
	if body is Taco:
		z_index = 1



func _on_area_2d_body_exited(body):
	if body is Taco:
		z_index = 0
