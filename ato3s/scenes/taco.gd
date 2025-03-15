extends CharacterBody2D

class_name Taco
#var velocity = Vector2.ZERO #GODOT ERROR SAYS: Member "velocity" redefined (original in nativa class CharacterBody2D)
var SPEED = 139
var ACCELERAT = 20

func _physics_process(delta): # runs each frame
	var input = get_user_input()
	update_velocity(input, delta)
	move_and_slide()
	rotate_stack(input)
	

func get_user_input():
	var input = Vector2.ZERO # initialize input on each frame
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return input

func update_velocity(input, delta):
	velocity = lerp(velocity, input * SPEED, ACCELERAT * delta)

func rotate_stack(input):
	if input != Vector2.ZERO: # if user is moving
		$steps_on_snow.emitting = true
		$SpriteStack._set_rotation(velocity.angle()) # rotate stack based on velocity angle
		#collision shape ruota quando muovi giocatore
		
