extends RigidBody2D
class_name Coin

@export var SPEED = 50.0
@export var score: int = 30

var dir = Vector2.LEFT

#func _ready() -> void:
#	velocity.x = dir.x * SPEED
#
#func _physics_process(delta: float) -> void:
#	move_and_slide()

func _on_player_detector_body_entered(body: Node2D) -> void:
	Global.emit_signal("points_scored", score, (get_global_transform() * body.position))
	Global.tween_eng_halftime()
	queue_free()
