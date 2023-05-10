extends Node2D

@export var score: int = 30

func _on_player_detector_body_entered(body: Node2D) -> void:
	Global.emit_signal("points_scored", score, (get_global_transform() * body.position))
	Global.tween_eng_halftime()
	queue_free()
