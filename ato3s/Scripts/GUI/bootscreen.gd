extends CanvasLayer

class_name BootScreen

@onready var particles = $CPUParticles2D
@onready var logo = $Sprite2D
@onready var Title1 = $Label
@onready var Title2 = $Label2
@onready var Text1 = $Label3
@onready var game_ready = false

@export var gravity = 100

func _ready() -> void:
	$Label3.hide()
	WindowManager.bootscreen = self
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade_out")
	
	

func _process(delta: float) -> void:
	#InputHandler
	if Input.is_action_just_pressed("Interact") and game_ready:
		$AnimationPlayer2.play("text_event")
	
	
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
	WindowManager._center_and_scale_font_bigger(window_size, Text1,0, 50)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		$AnimationPlayer.play("Title_fade_in")
	if anim_name == "Title_fade_in":
		if not FileAccess.file_exists(SaveManager.file_path+SaveManager.save_name):
			$Label3.show()
			$AnimationPlayer2.play("Text_Blink")
			game_ready = true
		elif FileAccess.file_exists(SaveManager.file_path+SaveManager.save_name):
			$Label3.hide()
		$AnimationPlayer.play("Title_Animation")
