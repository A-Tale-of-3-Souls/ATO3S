extends Node2D

func _ready():
	EntityGenerator.map_entities = $MapEntities
	EntityGenerator.spawn_area = Rect2(Vector2(-500, -500), Vector2(1000, 1000))
	EntityGenerator.spawn_density = {
		"Devil_Eye": 5,
		"Tree": 30,
	}
	randomize()
	EntityGenerator.spawn_map_entities()
	
