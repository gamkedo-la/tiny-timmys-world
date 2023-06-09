extends Node
class_name StateMachine

#Based on GDQuest StateMachine but switching is using states Dictionary instead of node path

signal transitioned(state)

@export var initial_state: = NodePath()
@onready var state_label: Label = owner.get_node("StateLabel")
@onready var state: State = get_node(initial_state):
	set(value):
		state = value

var states: = {}	#collects state nodes with state name as key
@onready var current_state: = state.name


func _init() -> void:
	add_to_group("state_machine")


func _ready() -> void:
	await owner.ready
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _process(delta: float) -> void:
	state.process(delta)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


func transition_to(target_state: String, msg: Dictionary = {}) -> void:
	
#	print(current_state, ' to ', target_state)
	
	if not states.has(target_state):
		print("there's no state: ", target_state)
		return
	state.exit()
	
	set_state(states[target_state])
	current_state = target_state
	state.enter(msg)
	state_label.text = current_state
	#emit_signal("transitioned", target_state)

func set_state(value):
	state = value

