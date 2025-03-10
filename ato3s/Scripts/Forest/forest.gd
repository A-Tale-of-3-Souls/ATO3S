extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var cam_velocity = Vector2.ZERO
var cam_accelerat = 3
var rotation_speed = 5 # Velocità di rotazione della telecamera

# Called every frame
func _process(delta):
	$Taco/Path2D/PathFollow2D.progress_ratio += 0.005
	
	var rotation_input = 0.0
	
	var rotation_movement = Vector2.ZERO
	rotation_movement.x = Input.get_action_strength("cam_right") - Input.get_action_strength("cam_left")
	rotation_movement.y = Input.get_action_strength("cam_up") - Input.get_action_strength("cam_down")
	# Ruota la telecamera con i tasti freccia
	if Input.is_action_pressed("cam_right"):
		rotation_input += 1
		cam_velocity = lerp(cam_velocity, 
							rotation_movement * rotation_speed, 
							cam_accelerat * delta
						)
		
	if Input.is_action_pressed("cam_left"):
		rotation_input -= 1
		cam_velocity = lerp(cam_velocity, 
							rotation_movement * rotation_speed, 
							cam_accelerat * delta
						)
	
	
	# Cam rotation effect
	# 1. Rotate the whole map
	rotation += rotation_input * rotation_speed * delta
	# 2. Rotate Taco Stack of sprites (all at the same time) could be done in a loop
	get_child(0).get_child(0).rotation += (-rotation_input*rotation_speed*delta)
	# 3. Rotate each taco sprite for 3d effect
	for child in get_child(0).get_child(0).get_children():
		child.rotation += (rotation_input*rotation_speed*delta)
	# 4. Rotate Tree Stack of sprites (all at the same time)
	get_child(1).get_child(0).rotation += (-rotation_input*rotation_speed*delta)
	# 5. Rotate each tree sprite for 3d effect
	for child in get_child(1).get_child(0).get_children():
		child.rotation += (rotation_input*rotation_speed*delta)
