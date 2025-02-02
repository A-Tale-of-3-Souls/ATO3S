extends CanvasLayer

class_name BootScreen

@onready var particles = $CPUParticles2D
@onready var logo = $Sprite2D
@onready var Title1 = $Label
@onready var Title2 = $Label2

@export var gravity = 100

func _ready() -> void:
	WindowManager.bootscreen = self
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
	#_center_logo(window_size)
	WindowManager._center_and_scale_anchor_center(window_size, logo)
	WindowManager._center_and_scale_anchor_left(window_size,Title1,0 , -27)
	WindowManager._center_and_scale_anchor_left(window_size,Title2,0,0)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		$AnimationPlayer.play("Title_fade_in")
