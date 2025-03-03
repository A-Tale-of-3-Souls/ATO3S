extends CanvasLayer

class_name BootScreen

@onready var window_size = WindowManager.defaultSize

@onready var particles = $Snow_Particles
@onready var logo = $logo

@onready var title_screen = $TitleScreen
@onready var Title1 = $TitleScreen/VBoxContainer/TitleContainer/Title1
@onready var Title2 = $TitleScreen/VBoxContainer/TitleContainer/Title2
@onready var input_prompt = $TitleScreen/VBoxContainer/InputPrompt

@onready var buttons = $Buttons_Container
@onready var load_button = $Buttons_Container/VBoxContainer/LoadGameButton
@onready var new_game_button = $Buttons_Container/VBoxContainer/NewGameButton

@onready var game_ready = false
@export var gravity = 100

@onready var flash_rect = $Flash_effect  # ColorRect per il flash
@onready var storm_sound = $Flash_effect/storm_sound  # AudioStreamPlayer per il suono del temporale
@onready var crt_effect_container = $CRT_Effect/MeshInstance2D
@onready var music = $BG_Music

func _ready() -> void:
	# set crt monitor effect size to the current window size
	# since we're on _ready, we need to do this multiple times :/
	# we need to find a way to make it attached to the window
	# or limit the user to never be able to freely change window size
	crt_effect_container.mesh.size = window_size
	
	# If no saves, disable load button
	if not FileAccess.file_exists("user://Save1.tres"):
		load_button.disabled = true
	
	# Hide everything, we need to show logo
	input_prompt.self_modulate = "ffffff00"
	buttons.hide()
	
	# Animate logo fade in
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(2.0).timeout
	
	# animate flash and start snow particles
	_flash_and_storm() # Flash e suono temporale
	
	# Animate logo fade out
	$AnimationPlayer.play("fade_out")

# Funzione per il flash e il suono temporale (after logo fades in)
func _flash_and_storm():
	# Mostra il flash e riproduci il suono temporale
	storm_sound.play()  # Riproduce il suono della tempesta
	flash_rect.size = window_size
	flash_rect.visible = true
	# animiamo il flash in questo modo easy
	flash_rect.modulate = Color(1, 1, 1, 0.7)  # Colore bianco per il flash
	await get_tree().create_timer(0.05).timeout
	flash_rect.modulate = Color(0, 0, 0, 0)  # Colore nero per il flash
	await get_tree().create_timer(0.05).timeout
	flash_rect.modulate = Color(1, 1, 1, 0.7)  # Colore bianco per il flash
	await get_tree().create_timer(0.1).timeout  
	
	# Nascondi il rect  del flash dopo il timer
	flash_rect.visible = false
	#storm_sound.stop()  # Interrompe il suono della tempesta dopo il flash (non serve)
	
	await get_tree().create_timer(0.369).timeout
	particles.visible = true
	particles.amount = 500

func _process(delta: float) -> void:
	#InputHandler
	if Input.is_action_just_pressed("Interact") and game_ready:
		$AnimationPlayer2.play("text_event")
	if buttons.visible == true and Input.is_action_just_pressed("back"):
		$AnimationPlayer2.stop()
		particles.visible = false
		_ready()
	animation_handler()

func animation_handler():
	if new_game_button.has_focus():
		$AnimationPlayer.play("NewGameAnimation")
	elif load_button.has_focus():
		if FileAccess.file_exists("user://Save1.tres"):
			$AnimationPlayer.play("LoadGameAnimation")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		music.play()
		$AnimationPlayer.play("Title_fade_in")
	if anim_name == "Title_fade_in":
		input_prompt.self_modulate = "ffffffda"
		$AnimationPlayer2.play("Text_Blink")
		game_ready = true
		$AnimationPlayer.play("Title_Animation")
	if anim_name == "Title_fade_out":
		$AnimationPlayer2.play("Buttons_fade_in")
		buttons.show()
		new_game_button.grab_focus()

func _on_animation_player_2_animation_finished(anim_name):
	if anim_name == "text_event":
		$AnimationPlayer.play("Title_fade_out")
	if anim_name == "Buttons__fade_out":
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_new_game_button_mouse_entered():
	new_game_button.grab_focus()

func _on_load_game_button_mouse_entered():
	new_game_button.grab_focus()

func _on_new_game_button_pressed():
	SaveManager.save_game()
	$AnimationPlayer2.play("Buttons__fade_out")
