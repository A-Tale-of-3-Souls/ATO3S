extends Node2D


# Configurazione elementi e percorsi scene
var entity_scenes = {
	"Devil_Eye": preload("res://scenes/Characters/Devil_eye.tscn"),
	"Tree": preload("res://scenes/WorldEntities/Tree.tscn"),
}

# Area di spawn 
var spawn_area = Rect2(Vector2(-500, -500), Vector2(1000, 1000))
var spawn_density = {
	"Devil_Eye": 5,
	"Tree": 15,
}
#@onready var entity_spawner = "res://Scripts/Global/entity_spawner.gd"
@onready var map_entities = $MapEntities

func _ready():
	randomize()
	spawn_map_entities()

func spawn_map_entities():
	for entity_type in spawn_density:
		if entity_scenes.has(entity_type):
			var scene = entity_scenes[entity_type]
			
			for i in range(spawn_density[entity_type]):
				var instance = scene.instantiate()
				map_entities.add_child(instance)
				
				# Assegna posizione casuale
				var spawn_pos = Vector2(
					randf_range(spawn_area.position.x, spawn_area.end.x),
					randf_range(spawn_area.position.y, spawn_area.end.y)
				)
				instance.global_position = spawn_pos
				
				# Sistema di profondità pseudo-3D
				if entity_type == "Tree":
					self.setup_3d_depth(instance, spawn_pos.y)
				
				instance.rotation = 0

func setup_3d_depth(instance, y_position):
	# Regola lo Z-index in base alla posizione Y
	instance.z_index = int(y_position)
	
	# Opzionale: Regola l'offset verticale per l'effetto parallasse
	var depth_factor = remap(y_position, 
		spawn_area.position.y, spawn_area.end.y, 
		0.8, 1.2)
	
	# Crea un effetto di prospettiva modificando scala e offset
	instance.scale *= depth_factor
	instance.position.y += (1 - depth_factor) * 50  # Regola questo valore
	
	# Aggiungi un'ombra dinamica (opzionale)
	var shadow = Sprite2D.new()
	#shadow.texture = preload("res://path_to_shadow_texture.png")
	shadow.position.y += 20  # Offset ombra
	shadow.scale = Vector2(0.5, 0.5) * depth_factor
	shadow.modulate = Color(0, 0, 0, 0.3)
	instance.add_child(shadow)
