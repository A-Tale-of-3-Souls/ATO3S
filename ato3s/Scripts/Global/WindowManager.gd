extends Node
#WORK IN PROGRESS!!!!!BUT IT WORKS!
@onready var defaultSize = DisplayServer.window_get_size()
@onready var CurrentSize = DisplayServer.window_get_size()
@onready var Scale = CurrentSize / defaultSize
@onready var PreviousSize = CurrentSize
 
var ignore_Y = false
var ignore_X = false
 
func _process(delta):
	CurrentSize = DisplayServer.window_get_size()
	Scale = CurrentSize / defaultSize
 
	if CurrentSize.x != PreviousSize.x && ignore_X == false:#Tests if the window is being resized in the x axis and not the y
		DisplayServer.window_set_size(Vector2(CurrentSize.x, defaultSize.y * Scale.x))#Scales the y axis by the same factor as x
		ignore_Y = true#Makes sure both pieces of code dont run at the same time
	elif CurrentSize.x == PreviousSize.x && ignore_X == true:#Stops ignoring X
		ignore_X = false
 
	if CurrentSize.y != PreviousSize.y && ignore_Y == false:#Tests if the window is being resized in the y axis and not the x
		DisplayServer.window_set_size(Vector2(defaultSize.x * Scale.y, CurrentSize.y))#Scales the x axis by the same factor as y
		ignore_X = true#Makes sure both pieces of code dont run at the same time
	elif CurrentSize.y == PreviousSize.y && ignore_Y == true:#Stops ignoring Y
		ignore_Y = false
 
	if DisplayServer.window_get_position().y < 0:#Prevents the title bar from going off screen
		DisplayServer.window_set_position(Vector2(DisplayServer.window_get_position().x, 0))
 
	if CurrentSize < defaultSize / 4:#Prevents the window from being too small
		DisplayServer.window_set_size(defaultSize / 4)
 
	PreviousSize = CurrentSize #This line MUST go at the end
#@onready var bootscreen = BootScreen
#
#func _scale(window_size, object, x=0, y=0):
	##object.position = Vector2(window_size.x / 2, window_size.y / 2)
	##if x == 0 and y == 0:
		##object.position = Vector2((window_size.x - object.size.x * object.scale.x) / 2, (window_size.y - object.size.y * object.scale.y) / 2)
	##else:
		##object.position = Vector2((window_size.x - object.size.x * object.scale.x) / 2 + x*object.scale.x, (window_size.y - object.size.y * object.scale.y) / 2 + y*object.scale.y)
	#object.scale.x = window_size.x/320
	#object.scale.y = window_size.x/320
##per oggetti con ancoraggio al centro
#func _center_and_scale_anchor_center(window_size, object):
	#object.position = Vector2(window_size.x / 2, window_size.y / 2)
	#object.scale.x = window_size.x/320
	#object.scale.y = window_size.x/320
#
##per oggetto con ancoraggio alto a sinistra
#func _center_and_scale_anchor_left(window_size, object, x = 0, y = 0):
	#if x == 0 and y == 0:
		#object.position = Vector2((window_size.x - object.size.x * object.scale.x) / 2, (window_size.y - object.size.y * object.scale.y) / 2)
	#else:
		#object.position = Vector2((window_size.x - object.size.x * object.scale.x) / 2 + x*object.scale.x, (window_size.y - object.size.y * object.scale.y) / 2 + y*object.scale.y)
	#object.scale.x = window_size.x/320
	#object.scale.y = window_size.x/320
#
#func _center_and_scale_font_bigger(window_size, object, x = 0, y = 0):#:')
	#if x == 0 and y == 0:
		#object.position = Vector2((window_size.x - object.size.x * object.scale.x) / 2, (window_size.y - object.size.y * object.scale.y) / 2)
	#else:
		#object.position = Vector2((window_size.x - object.size.x * object.scale.x) / 2 + x*object.scale.x, (window_size.y - object.size.y * object.scale.y) / 2 + y*object.scale.y)
	#object.scale.x = window_size.x /320
	#object.scale.y = window_size.x / 320
