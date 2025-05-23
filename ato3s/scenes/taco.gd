extends CharacterBody2D

class_name Taco
#var velocity = Vector2.ZERO #GODOT ERROR SAYS: Member "velocity" redefined (original in nativa class CharacterBody2D)
var SPEED = 139
var ACCELERAT = 20
var input = Vector2.ZERO

@onready var sprite_stack = $SpriteStack
@onready var collision = $CollisionShape2D
@onready var steps_on_snow = $steps_on_snow
@onready var area = $Area2D

func _ready():
	z_index = 1
	GameManager.taco = self
	set_motion_mode(1)
	set_max_slides(0)
	set_safe_margin(0)
	pass

func _physics_process(delta): # runs each frame
	var input = get_user_input()
	update_velocity(input, delta)
	move_and_slide()
	rotate_stack(input)
	if input != Vector2.ZERO: # if user is moving
		GameManager.player_moving = true
		steps_on_snow.emitting = true
	else:
		GameManager.player_moving = false
		steps_on_snow.emitting = false
	if area.has_overlapping_areas():
		#print("true")
		for ar in area.get_overlapping_areas():
			#print(area.get_overlapping_areas())
			return
			#ar.get_parent().modulate = Color(1,1,1,0.5)
		

func get_user_input():
	input = Vector2.ZERO # initialize input on each frame
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	input = input.normalized()
	return input

func update_velocity(input, delta):
	velocity = lerp(velocity, input * SPEED, ACCELERAT * delta)
	#GameManager.player_input = velocity

func rotate_stack(input):
	if input != Vector2.ZERO: # if user is moving
		sprite_stack._set_rotation(velocity.angle()) # rotate stack based on velocity angle
		#$SpriteStack.rotation = velocity.angle()
		#if GameManager.camera_rotating == false: 

		#collision.position = sprite_stack.get_child(0).position
		#collision.global_rotation = sprite_stack.get_child(0).global_rotation
		#$"../../Fix_Collision_shape".rotation = 
		#collision shape ruota quando muovi giocatore
		
