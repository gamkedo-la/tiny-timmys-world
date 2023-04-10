extends Node
class_name State
# State interface to use in Hierarchical State Machines. The lowest leaf tries
# to handle callbacks, and if it can't, it delegates the work to its parent.
#
# It's up to the user to call the parent state's functions, e.g.
# `_parent.physics_process(delta)`
#
# Use State as a child of a StateMachine node.


@onready var _state_machine: StateMachine = owner.get_node_or_null('StateMachine')
@onready var _ai_state_machine: AIStateMachine = owner.get_node_or_null('AIFSM')
@onready var parent = get_parent()

# Using the same class, i.e. State, as a type hint causes a memory leak in Godot
# 3.2.


func _ready() -> void:
	if _state_machine:
		_state_machine.states[name] = self
	elif _ai_state_machine:
		_ai_state_machine.states[name] = self
	else:
		assert(false)


func unhandled_input(event: InputEvent) -> void:
	pass

func process(delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg := {}) -> void:
	pass


func exit() -> void:
	pass

