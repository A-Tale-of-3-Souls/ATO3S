extends CanvasLayer

var main_menu_scene = preload("res://scenes/main_menu.tscn")

@onready var particles = $CPUParticles2D
@onready var logo = $TextureRect

@export var gravity = 100

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	# Inizializza la posizione del logo
	#_center_logo(window_size)

func _process(delta: float) -> void:
	# Calcola le dimensioni della finestra
	var window_size = DisplayServer.window_get_size()
	
	# Imposta l'emissione dei particellari in base alle dimensioni della finestra
	particles.emission_rect_extents = window_size
	particles.scale_amount_min = window_size.x / 640
	particles.scale_amount_max = particles.scale_amount_min * 4
	particles.gravity.y = (gravity * window_size.x) / 640
	
	# Ricalcola la posizione del logo ogni frame per tenerlo centrato
	_center_logo(window_size)

func _center_logo(window_size) -> void:
	var logo_size = logo.texture.get_size()
	var logo_scale = logo.scale.x
	
	# Imposta la posizione del logo in modo che sia centrato
	logo.position = Vector2((window_size.x - logo_size.x * logo_scale) / 2, (window_size.y - logo_size.y*logo_scale) / 2)
