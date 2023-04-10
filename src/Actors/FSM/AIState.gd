extends State
class_name AIState
# Base type for the player's state classes. Contains boilerplate code to get
# autocompletion and type hints.

@onready var actor: AIActor = owner
#@onready var animation:AnimationPlayer = owner.get_node('AnimationPlayer')

var next_state: = {}
var time_in_state: float = 0.0
