@tool

extends Sprite2D

@export var show_sprites = false: set = set_show_sprites, get = get_show_sprites
@export var rotate_sprites = false: set = set_rotate_sprites, get = get_rotate_sprites

func set_show_sprites(_show_sprites):
	show_sprites = _show_sprites
	if show_sprites:
		render_sprites()
	else:
		clear_sprites()
		
func get_show_sprites():
	return show_sprites
	
func clear_sprites():
	for sprite in get_children():
		sprite.queue_free()

func set_rotate_sprites(_rotate_sprites):
	rotate_sprites = _rotate_sprites


func get_rotate_sprites():
	return rotate_sprites

func _set_rotation(_rotation):
	for sprite in get_children():
		sprite.rotation = _rotation
	

# Called when the node enters the scene tree for the first time.
func _ready():
	render_sprites()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rotate_sprites:
		for sprite in get_children():
			sprite.rotation += delta


func render_sprites():
	clear_sprites()
	for i in range(0, hframes):
		var next_sprite = Sprite2D.new()
		next_sprite.texture = texture
		next_sprite.hframes = hframes
		next_sprite.frame = i
		next_sprite.position.y = -i
		add_child(next_sprite)
