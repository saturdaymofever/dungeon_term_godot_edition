extends Node

var screen_size = Vector2(1920, 1080)
var tile_size = 32
var tile_scene = preload("res://tile.tscn")
var player_scene = preload("res://player.tscn")
var player_position = Vector2(10, 10)
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for x in range(screen_size.x / tile_size):
		for y in range(screen_size.y / tile_size):
			var tile = tile_scene.instantiate()
			tile.position = Vector2(tile_size * x,tile_size * y)
			add_child(tile)
			
	player = player_scene.instantiate()
	player.position = player_position * tile_size
	add_child(player)

func move_up(player_position):
	if player_position.y > 0:
		player_position = Vector2(player_position.x, player_position.y - 1)
	return(player_position)
	
func move_down(player_position):
	if player_position.y < (screen_size.y / tile_size) - 1:
		player_position = Vector2(player_position.x, player_position.y + 1)
	return(player_position)	
	
func move_right(player_position):
	if player_position.x < (screen_size.x / tile_size) - 1:
		player_position = Vector2(player_position.x + 1, player_position.y)
	return(player_position)
	
func move_left(player_position):
	if player_position.x  > 0:
		player_position = Vector2(player_position.x - 1, player_position.y)
	return(player_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_up"):
		player_position = move_up(player_position)

	if Input.is_action_just_pressed("ui_down"):
		player_position = move_down(player_position)

	if Input.is_action_just_pressed("ui_right"):
		player_position = move_right(player_position)
			
	if Input.is_action_just_pressed("ui_left"):
		player_position = move_left(player_position)
	
	player.position = player_position * tile_size
