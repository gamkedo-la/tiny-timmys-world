extends RigidBody2D

class_name Heart

@export var SPEED = 50.0
@export var score: int = 10

var dir = Vector2.LEFT

func _on_player_detector_body_entered(body: Node2D) -> void:
	PlayerVars.player_health = min(PlayerVars.player_health + 2, PlayerVars.player_max_health)
	
	Global.emit_signal("player_health_restored", PlayerVars.player_health, (get_global_transform() * body.position))
	Global.emit_signal("points_scored", score, (get_global_transform() * body.position))
	Global.tween_eng_halftime()
	queue_free()
