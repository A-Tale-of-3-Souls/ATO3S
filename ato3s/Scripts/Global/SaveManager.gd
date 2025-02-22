extends Node

var save_data = SaveData.new()
var save_name = "Save1.tres"
var file_path = "user://"


func save_game():
	
	ResourceSaver.save(save_data, file_path+save_name)


func load_game():
	ResourceLoader.load(file_path+save_name).duplicate(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
