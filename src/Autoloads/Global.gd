extends Node

signal points_scored(val, pos)
signal screen_shake(val)

var LEVEL_SPEED: float = -20.0
var show_debug_labels_enemies: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_fullscreen(val: bool) -> void:
	if val:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func tween_eng_halftime() -> void:
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", 0.5, 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(Engine, "time_scale", 1.0, 0.05).set_trans(Tween.TRANS_EXPO)
	
