extends CharacterBody2D

#var velocity = Vector2.ZERO #GODOT ERROR SAYS: Member "velocity" redefined (original in nativa class CharacterBody2D)
var SPEED = 139
var ACCELERAT = 9

func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	velocity = lerp(velocity, input * SPEED, ACCELERAT * delta)
	move_and_slide()
	
	if input != Vector2.ZERO:
		$SpriteStack._set_rotation(velocity.angle())
