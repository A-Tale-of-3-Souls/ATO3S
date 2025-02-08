extends CanvasLayer

class_name BootScreen

@onready var particles = $CPUParticles2D
@onready var logo = $logo
@onready var title_screen = $TitleScreen
@onready var Title1 = $TitleScreen/VBoxContainer/TitleContainer/Title1
@onready var Title2 = $TitleScreen/VBoxContainer/TitleContainer/Title2
@onready var input_prompt = $TitleScreen/VBoxContainer/InputPrompt
@onready var game_ready = false
@onready var buttons = $CenterContainer

@export var gravity = 100

func _ready() -> void:
	#var window_size = DisplayServer.window_get_size_with_decorations()
	#particles.emission_rect_extents = window_size
	input_prompt.self_modulate =  "ffffff00"
	buttons.hide()
	#WindowManager.bootscreen = self
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade_out")
	
	

func _process(delta: float) -> void:
	#InputHandler
	if Input.is_action_just_pressed("Interact") and game_ready:
		$AnimationPlayer2.play("text_event")
	# Calcola le dimensioni della finestra
	var window_size = DisplayServer.window_get_size_with_decorations()
	
	# Imposta l'emissione dei particellari in base alle dimensioni della finestra
	#particles.emission_rect_extents = window_size
	#particles.amount = 500 * (window_size.x/320)
	#particles.scale_amount_min = window_size.x / 320
	#particles.scale_amount_max = particles.scale_amount_min * 2
	#particles.gravity.y = (gravity * window_size.x) / 320
	
	# Ricalcola la posizione del logo ogni frame per tenerlo centrato
	#_center_logo(window_size)
	#WindowManager._scale(window_size,title_screen)
	#WindowManager._scale(window_size, logo)
	#WindowManager._scale(window_size,Title1)
	#WindowManager._scale(window_size,Title2)
	#WindowManager._scale(window_size, input_prompt)
	#WindowManager._scale(window_size, buttons)
	
	if buttons.visible == true and Input.is_action_just_pressed("back"):
		$AnimationPlayer2.stop()
		_ready()
	animation_handler()


func animation_handler():
	if $CenterContainer/VBoxContainer/NewGameButton.has_focus():
		$AnimationPlayer.play("NewGameAnimation")
	elif $CenterContainer/VBoxContainer/LoadGameButton.has_focus():
		$AnimationPlayer.play("LoadGameAnimation")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		$AnimationPlayer.play("Title_fade_in")
	if anim_name == "Title_fade_in":
		input_prompt.self_modulate =  "ffffffda"
		$AnimationPlayer2.play("Text_Blink")
		game_ready = true
		$AnimationPlayer.play("Title_Animation")
	if anim_name == "Title_fade_out":
		$AnimationPlayer2.play("Buttons_fade_in")
		buttons.show()
		$CenterContainer/VBoxContainer/NewGameButton.grab_focus()
	


func _on_animation_player_2_animation_finished(anim_name):
	if anim_name == "text_event":
		$AnimationPlayer.play("Title_fade_out")
		
		


func _on_new_game_button_mouse_entered():
	$CenterContainer/VBoxContainer/NewGameButton.grab_focus()


func _on_load_game_button_mouse_entered():
	$CenterContainer/VBoxContainer/LoadGameButton.grab_focus()
