extends AIState

@onready var fly: PackedScene = preload("res://src/Actors/Enemies/Bosses/FrogFly.tscn")
@export var fly_path: NodePath
var fly_node: Node2D
var fly_spawned: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	if !fly_spawned:
		spawn_fly()
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 2.0 && fly_spawned:
		_ai_state_machine.transition_to('Idle', {})
	if time_in_state > 10.0:
		_ai_state_machine.transition_to('Idle', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	fly_spawned = false
	actor.audio_stream_player.stream = actor.flies_sfx
	actor.audio_stream_player.play()
	time_in_state = 0.0
	pass

func exit() -> void:
	pass
	
func spawn_fly() -> void:
	var new_fly = fly.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	fly_node = get_node_or_null(fly_path)
	if fly_node:
		new_fly.top_level = true
		fly_node.add_child(new_fly)
		var rand_x = randf_range(150.0, 350.0)
		var rand_y = randf_range(100.0, 10.0)
		new_fly.global_position = Vector2(rand_x, rand_y)
		fly_spawned = true
	else:
		print_debug("Fly Node not found on Frog Boss")
	

