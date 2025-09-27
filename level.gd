extends Node

var screen_size = Vector2(1920, 1080)
var tile_size = 32
var tile_scene = preload("res://tile.tscn")
var player_scene = preload("res://player.tscn")
var player_position = Vector2(59, 33)
var monster_scene = preload("res://monster.tscn")
var monster_position = Vector2(randi_range(0, 60),randi_range(0, 32))

var player_move_amount = 1
var monster_move_amount = 1
var player_pv = 10
var monter_pv = 8 
var player_pw = 2
var monster_pw = 1

var turn = "player"

var player
var monster

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
	
	monster = monster_scene.instantiate()
	monster.position = monster_position * tile_size
	add_child(monster)

func move_up(player_position:Vector2) -> Vector2:
	if player_position.y > 0:
		player_position = Vector2(player_position.x, player_position.y - 1)
	return(player_position)
	
func move_down(player_position:Vector2) -> Vector2:
	if player_position.y < (screen_size.y / tile_size) - 2:
		player_position = Vector2(player_position.x, player_position.y + 1)
	return(player_position)	
	
func move_right(player_position:Vector2) -> Vector2:
	if player_position.x < (screen_size.x / tile_size) - 1:
		player_position = Vector2(player_position.x + 1, player_position.y)
	return(player_position)
	
func move_left(player_position:Vector2) -> Vector2:
	if player_position.x  > 0:
		player_position = Vector2(player_position.x - 1, player_position.y)
	return(player_position)

func normalize_value(x:int) -> int:
	if x > 1:
		return(1)
	if x < -1:
		return(-1)
	return(x)

func normalize_vector(vecteur:Vector2) -> Vector2:
	return(Vector2(normalize_value(vecteur.x), normalize_value(vecteur.y)))
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if turn == "player":
	
		if Input.is_action_just_pressed("ui_up"):
			player_position = move_up(player_position)
			turn = "monster"

		if Input.is_action_just_pressed("ui_down"):
			player_position = move_down(player_position)
			turn = "monster"

		if Input.is_action_just_pressed("ui_right"):
			player_position = move_right(player_position)
			turn = "monster"
				
		if Input.is_action_just_pressed("ui_left"):
			player_position = move_left(player_position)
			turn = "monster"
			
# Il faut tester la direction dans chaque coordonnée soit -1 soit 0 soit 1;
# si la direction esyt négative il faut prendre la mx entre -1 etle monster direction et sinon le min entre 1 et le ponster direction see clamp !!!!
			
	if turn == "monster":
		var monster_direction = Vector2(player_position.x - monster_position.x, player_position.y - monster_position.y)
		var monster_direction_normalized = normalize_vector(monster_direction)
		print(monster_direction_normalized)
		print(monster_direction)
		monster_position = monster_position + monster_direction_normalized
		turn = "player"
	# Vecteur entre deux points =  xB - xA ; yB - yA
	player.position = player_position * tile_size
	monster.position = monster_position * tile_size


	
	
	
	
