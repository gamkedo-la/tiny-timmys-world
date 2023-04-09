extends Node2D

@onready var bounce_pods = $BouncePods
var score: int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	var con_res
#	for pod in bounce_pods.get_children():
#		if not pod.is_connected("body_entered", pod_bounce):
#			con_res = pod.connect("body_entered", pod_bounce)
#			assert(con_res == OK)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pod_bounce(body: Node) -> void:
	print_debug("Getting here")
	Global.emit_signal("points_scored", score, (get_global_transform() * body.position))
	Global.tween_eng_halftime()
	pass
