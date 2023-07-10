extends RigidBody2D
class_name Coin

@export var SPEED = 50.0
@export var score: int = 30

var coin_pickup = preload("res://src/Audio/Player/slingshot-2.wav")

var dir = Vector2.LEFT

#func _ready() -> void:
#	var con_res
#	if not Global.is_connected("coin_retrieved", _play_coin_retrieved):
#		con_res = Global.connect("coin_retrieved", _play_coin_retrieved)
#		assert(con_res == OK)


func _on_player_detector_body_entered(body: Node2D) -> void:
	Global.emit_signal("play_sfx", coin_pickup)
	Global.emit_signal("points_scored", score, (get_global_transform() * body.position))
	Global.tween_eng_halftime()
	Global.tween_eng_halftime()
	queue_free()
