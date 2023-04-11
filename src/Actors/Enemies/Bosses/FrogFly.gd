extends Path2D

@onready var fly_path: PathFollow2D = $FlyFollow
@onready var fly_body: Area2D = $FlyFollow/FlyBody

@export var score: int = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var con_res
	tween_flight()
	
	if not fly_body.is_connected("area_entered", _on_bullet_detector_area_entered):
		con_res = fly_body.connect("area_entered", _on_bullet_detector_area_entered)
		assert(con_res == OK)

func tween_flight() -> void:
	var fly_tween = create_tween()
	fly_tween.set_loops()
	fly_tween.tween_property(fly_path, "progress_ratio", 100.0, 60.0).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_SINE)


func _on_bullet_detector_area_entered(area: Area2D) -> void:	
	Global.emit_signal("points_scored", score, (get_global_transform() * area.position))
	queue_free()
