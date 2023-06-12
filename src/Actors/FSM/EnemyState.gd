extends State
class_name EnemyState
# Base type for the player's state classes. Contains boilerplate code to get
# autocompletion and type hints.

@onready var enemy: Enemy = owner
#@onready var animation:AnimationPlayer = owner.get_node('AnimationPlayer')

var next_state: = {}
