extends CharacterBody2D


const SPEED = 100.0
const ACCELERATION = 20

func _physics_process(delta):


	var input = Vector2.ZERO

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up") 
	velocity = lerp(velocity,input * SPEED, ACCELERATION * delta)
	move_and_slide()
	if input != Vector2.ZERO:
		$SpriteStack.set_rotation(input.angle()- deg_to_rad(90))
