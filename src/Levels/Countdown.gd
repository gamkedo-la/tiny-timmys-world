extends Control

@onready var timer: Timer = $Timer
@onready var one: TextureRect = $one_countdown
@onready var two: TextureRect = $two_countdown
@onready var three: TextureRect = $three_countdown


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one.visible = false
	two.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.time_left == 0:
		one.visible = false
		set_process_mode(Node.PROCESS_MODE_DISABLED)
	elif timer.time_left < 1:
		one.visible = true
		two.visible = false
		three.visible = false
	elif timer.time_left < 2:
		one.visible = false
		two.visible = true
		three.visible = false
	elif timer.time_left < 3:
		one.visible = false
		two.visible = false
		three.visible = true
