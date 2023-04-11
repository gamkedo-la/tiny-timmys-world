extends AIState

@onready var rain_drop = preload("res://src/Actors/Enemies/Bosses/rain_drop.tscn")

var has_stomped: bool = false
var rain_drops: int = 0
var start_x: float = 395.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	
	if has_stomped && actor.is_on_floor():
		rain_storm()
		
	if !has_stomped:
		actor.velocity.y = -700
		has_stomped = true

	actor.physics_process(delta)



func state_check()->void:
	if time_in_state > 2.0 && rain_drops <= 0:
		_ai_state_machine.transition_to('Idle', {})
	if time_in_state > 10.0:
		_ai_state_machine.transition_to('Idle', {})
	pass

func enter(msg:Dictionary = {}) -> void:
#	actor.ani_player_play("Idle")
	has_stomped = false
	time_in_state = 0.0
	rain_drops = randi_range(4, 10)
	start_x = 395.0
#	Global.emit_signal("screen_shake", 3.0)
	pass

func exit() -> void:
	pass


func rain_storm() -> void:
	if rain_drops > 0:
		var new_drop: RigidBody2D = rain_drop.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		new_drop.top_level = true
		add_child(new_drop)
		new_drop.global_position = Vector2(start_x, 10)
		start_x = clamp(start_x - randf_range(40.0, 100.0), 10.0, 395.0)
		rain_drops -= 1
	
