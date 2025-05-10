extends Camera2D
# camera variables
var cam_velocity = Vector2.ZERO
var cam_accelerat = 1
var rotation_speed = 3  # Velocità di rotazione desiderata (radians/second)
var current_rotation_speed = 0.0  # Velocità attuale interpolata
var rotation_smoothness = 10.0  # Fattore di smoothing

@onready var player = get_parent().get_parent()
@onready var map_entities = $"../../../MapEntities"
@onready var terrain = $"../../../TileMapLayer"

# Usiamo _physics_process per un movimento più fluido
func _physics_process(delta):
	handle_camera_rotation(delta)

func handle_camera_rotation(delta):
	var rotation_input = 0.0
	
	# Calcola l'inputs
	if Input.is_action_pressed("cam_right"):
		rotation_input += 1
	if Input.is_action_pressed("cam_left"):
		rotation_input -= 1
	
	# Interpola la velocità di rotazione
	var target_speed = rotation_input * rotation_speed
	current_rotation_speed = lerp(current_rotation_speed, target_speed, delta * rotation_smoothness)
	
	# Applica la rotazione solo se c'è input
	if abs(current_rotation_speed) > 0.01:
		var rotation_value = current_rotation_speed * delta
		var fix_rotation = -rotation_value
		rotate_world(rotation_value, fix_rotation)
		rotate_player(rotation_value, fix_rotation)

func rotate_sprite_stacks(stack, rotation_val):
	for sprite in stack.get_children():
		# Usiamo la rotazione locale invece di global_rotation
		sprite.rotation += rotation_val

func rotate_player(rotation_value, fix_rotation):
	player.global_rotation += rotation_value
	var taco_object = player.get_child(0)
	var taco_stack = taco_object.get_child(0)
	
	# Correzione locale invece che globale
	taco_stack.rotation += fix_rotation
	rotate_sprite_stacks(taco_stack, rotation_value)

func rotate_world(rotation_value, fix_rotation):
	terrain.rotation += rotation_value
	map_entities.rotation += rotation_value
	for child in map_entities.get_children():
		if child.get_children():
			var stack = child.get_child(0)
			stack.rotation += fix_rotation
			rotate_sprite_stacks(stack, rotation_value)
