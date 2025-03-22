extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# camera variables
var cam_velocity = Vector2.ZERO
var cam_accelerat = 1
var rotation_speed = 5 # Velocità di rotazione della telecamera

# Called every frame
func _process(delta):
	$Taco/Path2D/PathFollow2D.progress_ratio += 0.005
	
	var rotation_input = 0.0
	
	var rotation_movement = Vector2.ZERO
	rotation_movement.x = Input.get_action_strength("cam_right") - Input.get_action_strength("cam_left")
	rotation_movement.y = Input.get_action_strength("cam_up") - Input.get_action_strength("cam_down")
	#if rotation_movement != Vector2.ZERO:
		#GameManager.camera_rotating = true
		# Ruota la telecamera con i tasti freccia
	if Input.is_action_pressed("cam_right"):
		rotation_input += 1
		#cam_velocity = lerp(cam_velocity, 
							#rotation_movement * rotation_speed, 
							#cam_accelerat * delta
						#)
		rotate_camera(rotation_input, delta)
		
	if Input.is_action_pressed("cam_left"):
		rotation_input -= 1
		#cam_velocity = lerp(cam_velocity, 
							#rotation_movement * rotation_speed, 
							#cam_accelerat * delta
						#)
		rotate_camera(rotation_input, delta)
		#else:
			#ameManager.camera_rotating = false

		
	
	
	
			
func rotate_camera(rotation_input, delta):
	$Taco/steps_on_snow.emitting = false
	# Cam rotation effect
	# 1. Rotate the whole map
	rotation += rotation_input * rotation_speed * delta
	GameManager.taco.collision.rotation = GameManager.taco.velocity.angle()
	
	for child in get_children(): # for every child of forest
		if child.get_children(): # if it has children
			var stack = child.get_child(0)
			var area = child.get_child(2)
			var collision_child = child.get_child(1)
			stack.rotation += (-rotation_input*rotation_speed*delta) # rotate stack of sprites
			# 3. Rotate each taco sprite for 3d effect
			if collision_child is CollisionShape2D:
				#if GameManager.player_moving:
				#GameManager.taco.collision.rotation = GameManager.taco.velocity.angle()
				collision_child.rotation += (-rotation_input*rotation_speed*delta)
			#if area is Area2D:
				#area.rotation += (-rotation_input*rotation_speed*delta)
			for nephew in stack.get_children(): 
				nephew.rotation += (rotation_input*rotation_speed*delta)
			# 4. Rotate Tree Stack of sprites (all at the same time)
		else: # particles or eother stuff we don't wanna move
			child.rotation += (-rotation_input*rotation_speed*delta)
