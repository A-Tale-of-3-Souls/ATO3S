extends Camera2D
# camera variables
var cam_velocity = Vector2.ZERO
var cam_accelerat = 1
var rotation_speed = 5 # Velocità di rotazione della telecamera

# Called every frame
func _process(delta):
	position = GameManager.taco.position
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
	#$Taco/steps_on_snow.emitting = false
	# Cam rotation effect
	# 1. Rotate the whole map
	var map_entities = get_parent()
	var rotation_value = (rotation_input*rotation_speed*delta)
	var fix_rotation = -rotation_value
	map_entities.rotation += rotation_value
	#GameManager.taco.rotation += fix_rotation
	GameManager.taco.collision.rotation = GameManager.taco.velocity.angle()
	for child in map_entities.get_children(): # for every child of map_entities
		if child.get_children():#if map object
			var stack = child.get_child(0)#get spritestack of map object
			stack.rotation += fix_rotation # rotate stack of sprites opposite of map entities
			var collision_shape = child.get_child(1)#get collisionshape of entity
			if GameManager.player_moving and child is Taco:
				pass
			else:
				collision_shape.rotation += fix_rotation
			for sprite in stack.get_children():#for every sprite in stack
				sprite.rotation += rotation_value#rotate it with map entities
		#if child.get_children(): # if it has children
			#var stack = child.get_child(0)
			#var area = child.get_child(2)
			#var collision_child = child.get_child(1)
			#stack.rotation += (-rotation_input*rotation_speed*delta) # rotate stack of sprites
			## 3. Rotate each taco sprite for 3d effect
			#if collision_child is CollisionShape2D:
				##if GameManager.player_moving:
				##GameManager.taco.collision.rotation = GameManager.taco.velocity.angle()
				#collision_child.rotation += (-rotation_input*rotation_speed*delta)
			##if area is Area2D:
				##area.rotation += (-rotation_input*rotation_speed*delta)
			#for nephew in stack.get_children(): 
				#nephew.rotation += (rotation_input*rotation_speed*delta)
			## 4. Rotate Tree Stack of sprites (all at the same time)
		#else: # particles or eother stuff we don't wanna move
			#child.rotation += (-rotation_input*rotation_speed*delta)
