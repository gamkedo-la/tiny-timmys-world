extends HBoxContainer

var max_health: int
var heart_full = preload("res://src/Sprites/Health/heart_full-export.png")
var heart_empty = preload("res://src/Sprites/Health/heart_empty_container.png")
var heart_half = preload("res://src/Sprites/Health/heart_half.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = PlayerVars.player_health
	
	var con_res
	
	if not Global.is_connected("player_damage_taken", _on_player_damage_taken):
		con_res = Global.connect("player_damage_taken", _on_player_damage_taken)
		assert(con_res == OK)
	
	_update_health_bar(max_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _update_health_bar(current_health):
	for i in get_child_count():
		if current_health > i * 2 + 1:
			get_child(i).texture = heart_full
		elif current_health > i * 2:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
		
	
func _on_player_damage_taken(points: int, pos: Vector2):
	print_debug("Player Damaged!!" , points)
	_update_health_bar(points)
