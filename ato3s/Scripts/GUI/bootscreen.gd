extends CanvasLayer


@onready var particles = $CPUParticles2D
@onready var logo = $Sprite2D

@export var gravity = 100

func _ready() -> void:
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade_out")
	

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
	#var logo_size = logo.texture.get_size()
	#var logo_scale = logo.scale.x
	
	# Imposta la posizione del logo in modo che sia centrato
	#logo.position = Vector2((window_size.x - logo_size.x * logo_scale) / 2, (window_size.y - logo_size.y*logo_scale) / 2)
	logo.position = Vector2(window_size.x / 2, window_size.y / 2)
	logo.scale.x = window_size.x * 2 /640
	logo.scale.y = window_size.x * 2 / 640


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		$AnimationPlayer.play("Title_fade_in")
